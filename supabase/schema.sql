


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE SCHEMA IF NOT EXISTS "public";


ALTER SCHEMA "public" OWNER TO "pg_database_owner";


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE OR REPLACE FUNCTION "public"."build_group"("seed_user_id" "uuid", "min_common_countries" integer DEFAULT 1) RETURNS TABLE("user_id" "uuid", "final_dates" "daterange", "final_days" "int4range", "final_mates" "int4range", "final_budget" "int4range", "destination_stats" "jsonb")
    LANGUAGE "plpgsql"
    AS $$DECLARE
  current_group_ids uuid[] := array[seed_user_id];
  current_group_size int := 1;
  current_personality vector; 
  current_destinations int[];
  
  current_dates daterange;
  current_days int4range;
  current_mates int4range;
  current_budget int4range;

  candidate_rec record;
  max_distance float8 := 0.4;
BEGIN
  -- 0. Sécurité : Si le Seed est déjà en groupe, on arrête tout de suite.
  IF EXISTS (SELECT 1 FROM public.group_members gm WHERE gm.user_id = seed_user_id) THEN
    RETURN;
  END IF;

  -- 1. Initialisation Seed
  SELECT 
    c.personality, c.destination, c.dates, c.days, c.mates, c.budget
  INTO 
    current_personality, current_destinations, current_dates, current_days, current_mates, current_budget
  FROM public.compatibility c
  WHERE c.user_id = seed_user_id
    AND c.personality IS NOT NULL
    AND c.destination IS NOT NULL
    AND c.dates IS NOT NULL
    AND c.days IS NOT NULL
    AND c.mates IS NOT NULL
    AND c.budget IS NOT NULL;

  IF current_personality IS NULL THEN RETURN; END IF;

  -- 2. Boucle de construction
  WHILE current_group_size < (upper(current_mates) - 1) LOOP
    
    SELECT 
      c.user_id, c.personality, c.destination, 
      c.dates, c.days, c.mates, c.budget
    INTO candidate_rec
    FROM public.compatibility c
    WHERE 
      -- A. Vérification de l'intégrité
      c.personality IS NOT NULL
      AND c.destination IS NOT NULL
      AND c.dates IS NOT NULL
      AND c.days IS NOT NULL
      AND c.mates IS NOT NULL
      AND c.budget IS NOT NULL

      -- B. On exclut ceux déjà dans CE groupe
      AND c.user_id <> ALL(current_group_ids)

      -- C. On exclut ceux déjà dans un AUTRE groupe
      AND NOT EXISTS (
          SELECT 1 
          FROM public.group_members gm 
          WHERE gm.user_id = c.user_id
      )

      -- D. Compatibilité
      AND c.destination && current_destinations
      AND c.days && current_days
      AND c.budget && current_budget
      AND c.mates && current_mates
      AND c.dates && current_dates 
      AND (upper(c.dates * current_dates) - lower(c.dates * current_dates)) >= lower(c.days * current_days)
      AND (current_group_size + 1) < upper(c.mates * current_mates)
      AND (c.personality <-> current_personality) / sqrt(vector_dims(current_personality)) < max_distance
      AND (
          SELECT count(*)
          FROM (
            SELECT unnest(c.destination)
            INTERSECT
            SELECT unnest(current_destinations)
          ) i
      ) >= min_common_countries
    ORDER BY 
      (SELECT count(*) FROM (SELECT unnest(c.destination) INTERSECT SELECT unnest(current_destinations)) i) DESC,
      c.personality <-> current_personality ASC 
    LIMIT 1;

    IF candidate_rec.user_id IS NOT NULL THEN
      current_group_ids := array_append(current_group_ids, candidate_rec.user_id);
      current_group_size := current_group_size + 1;
      
      current_dates  := current_dates * candidate_rec.dates;
      current_days   := current_days * candidate_rec.days;
      current_mates  := current_mates * candidate_rec.mates;
      current_budget := current_budget * candidate_rec.budget;

      SELECT ARRAY(
        SELECT unnest(current_destinations)
        INTERSECT
        SELECT unnest(candidate_rec.destination)
      ) INTO current_destinations;
      
      SELECT AVG(t.personality) INTO current_personality
      FROM public.compatibility t
      WHERE t.user_id = ANY(current_group_ids);
    ELSE
      EXIT; 
    END IF;
  END LOOP;

  -- 3. Validation taille
  IF current_group_size < lower(current_mates) THEN
    RETURN;
  END IF;

  -- 4. Retour
  RETURN QUERY
  WITH group_destinations_cte AS (
      SELECT unnest(c.destination) as dest_id
      FROM public.compatibility c
      WHERE c.user_id = ANY(current_group_ids)
  ),
  stats AS (
      SELECT jsonb_object_agg(dest_id::text, count_val) as summary
      FROM (
          SELECT dest_id, count(*) as count_val
          FROM group_destinations_cte
          GROUP BY dest_id
          HAVING count(*) > 1
      ) s
  )
  SELECT 
    gm.uid,
    current_dates,
    current_days,
    current_mates,
    current_budget,
    (SELECT summary FROM stats)
  FROM unnest(current_group_ids) as gm(uid);
END;$$;


ALTER FUNCTION "public"."build_group"("seed_user_id" "uuid", "min_common_countries" integer) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."compatibility_answer_add_question_id"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$BEGIN
    -- Sélectionne le question_id associé à l'option choisie
    -- et l'assigne directement à la colonne question_id de la nouvelle ligne (NEW)
    SELECT question_id INTO NEW.question_id
    FROM public.compatibility_options
    WHERE id = NEW.option_id;

    RETURN NEW;
END;$$;


ALTER FUNCTION "public"."compatibility_answer_add_question_id"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."compatibility_answer_check"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
    -- Get the question ID and multi_select value for the inserted option
    question_id_var bigint;
    is_multi_select boolean;
BEGIN
    SELECT compatibility_options.question_id, (compatibility_questions.multi_select::boolean)
    INTO question_id_var, is_multi_select
    FROM compatibility_options
    JOIN compatibility_questions ON compatibility_options.question_id = compatibility_questions.id
    WHERE compatibility_options.id = NEW.option_id
    LIMIT 1;

    IF is_multi_select = false THEN
        -- Check that there is no other answer for this question and profile
        IF EXISTS (
            SELECT 1
            FROM compatibility_answers ca
            WHERE ca.profile_id = NEW.profile_id
                AND ca.option_id IN (
                    SELECT id FROM compatibility_options WHERE question_id = question_id_var
                )
        ) THEN
            RAISE EXCEPTION 'An answer for this question and profile already exists (single select)';
        END IF;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."compatibility_answer_check"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."compatibility_destinations_update_vector"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$DECLARE
    _user_id uuid;
    _country_ids bigint[];
BEGIN
    -- 1. Determine User ID based on the operation
    IF (TG_OP = 'DELETE') THEN
        _user_id := OLD.profile_id;
    ELSE
        _user_id := NEW.profile_id;
    END IF;

    -- 2. Aggregate country IDs into an array
    -- We use COALESCE to ensure we get an empty array '{}' instead of NULL if no countries exist
    SELECT COALESCE(array_agg(country_id ORDER BY country_id ASC), '{}')
    INTO _country_ids
    FROM public.compatibility_destinations
    WHERE profile_id = _user_id;

    -- 3. Upsert (Insert or Update) into compatibility table
    -- If the user_id exists, update the destination. If not, insert a new row.
    INSERT INTO public.compatibility (user_id, destination)
    VALUES (_user_id, _country_ids)
    ON CONFLICT (user_id) 
    DO UPDATE SET
        destination = EXCLUDED.destination;

    RETURN NULL;
END;$$;


ALTER FUNCTION "public"."compatibility_destinations_update_vector"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."compatibility_group_creation"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$DECLARE
    rec record;
    v_group_id uuid;
    v_group_created boolean := false;
    v_dest_id text;
    v_dest_count int;
    target_user_id uuid;
BEGIN
    -- On récupère l'ID de l'utilisateur concerné (NEW car c'est un INSERT ou UPDATE)
    target_user_id := NEW.user_id;

    -- On itère sur les résultats de votre fonction de matching
    FOR rec IN SELECT * FROM public.build_group(target_user_id) LOOP
        
        -- A. Création du groupe (une seule fois pour la première ligne trouvée)
        IF NOT v_group_created THEN
            INSERT INTO public.groups (dates, days, mates, budget)
            VALUES (rec.final_dates, rec.final_days, rec.final_mates, rec.final_budget)
            RETURNING id INTO v_group_id;
            
            v_group_created := true;

            -- B. Insertion des statistiques de destinations (JSON -> Table SQL)
            FOR v_dest_id, v_dest_count IN SELECT * FROM jsonb_each_text(rec.destination_stats)
            LOOP
                INSERT INTO public.group_destinations (group_id, countries_id, counts)
                VALUES (v_group_id, v_dest_id::bigint, v_dest_count::smallint);
            END LOOP;
        END IF;

        -- C. Insertion des membres
        -- On met à jour le groupe si l'utilisateur est déjà ailleurs (ON CONFLICT)
        INSERT INTO public.group_members (group_id, user_id)
        VALUES (v_group_id, rec.user_id)
        ON CONFLICT (user_id) 
        DO UPDATE SET group_id = EXCLUDED.group_id;
        
    END LOOP;

    RETURN NEW;
END;$$;


ALTER FUNCTION "public"."compatibility_group_creation"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."compatibility_vectors_compute"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$DECLARE
    target_profile_id uuid;
    personality_vector float8[];
BEGIN
    -- Identifier l'utilisateur concerné
    IF (TG_OP = 'DELETE') THEN
        target_profile_id := OLD.profile_id;
    ELSE
        target_profile_id := NEW.profile_id;
    END IF;

    -- 1. Calcul du vecteur PERSONALITY
    SELECT ARRAY_AGG(
        COALESCE(user_vals.avg_val, 0)
        ORDER BY q.section_id ASC, q.pos ASC
    )
    INTO personality_vector
    FROM public.compatibility_questions q
    LEFT JOIN (
        SELECT 
            a.question_id, 
            AVG(o.value) as avg_val
        FROM public.compatibility_answers a
        JOIN public.compatibility_options o ON a.option_id = o.id
        WHERE a.profile_id = target_profile_id
        GROUP BY a.question_id
    ) user_vals ON q.id = user_vals.question_id;

    -- 2. Upsert dans la table 'compatibility'
    IF personality_vector IS NOT NULL THEN
        INSERT INTO public.compatibility (user_id, personality)
        VALUES (
            target_profile_id, 
            personality_vector::vector
        )
        ON CONFLICT (user_id) 
        DO UPDATE SET 
            personality = EXCLUDED.personality;
    END IF;

    RETURN NULL;
END;$$;


ALTER FUNCTION "public"."compatibility_vectors_compute"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_my_group_ids"() RETURNS SETOF "uuid"
    LANGUAGE "sql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT group_id FROM group_members WHERE user_id = auth.uid();
$$;


ALTER FUNCTION "public"."get_my_group_ids"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$begin
  insert into public.profiles (id, last_name)
  values (new.id, new.raw_user_meta_data->>'last_name');
  return new;
end;$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_profile_deletion"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$BEGIN
  if exists (select 1 from auth.users where id = old.id) then
    delete from auth.users where id = old.id;
  end if;

  return old;
END;$$;


ALTER FUNCTION "public"."handle_profile_deletion"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."cities" (
    "id" bigint NOT NULL,
    "name" "text",
    "state_id" bigint,
    "state_code" "text",
    "state_name" "text",
    "country_id" bigint,
    "latitude" double precision,
    "longitude" double precision,
    "native" "text",
    "timezone" "text",
    "wikiDataId" "text"
);


ALTER TABLE "public"."cities" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."compatibility" (
    "user_id" "uuid" DEFAULT "auth"."uid"() NOT NULL,
    "personality" "extensions"."vector",
    "destination" integer[],
    "dates" "daterange",
    "days" "int4range",
    "mates" "int4range",
    "budget" "int4range"
);


ALTER TABLE "public"."compatibility" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."compatibility_answers" (
    "profile_id" "uuid" DEFAULT "auth"."uid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "question_id" bigint NOT NULL,
    "option_id" bigint NOT NULL
);


ALTER TABLE "public"."compatibility_answers" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."compatibility_destinations" (
    "profile_id" "uuid" DEFAULT "auth"."uid"() NOT NULL,
    "country_id" bigint NOT NULL
);


ALTER TABLE "public"."compatibility_destinations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."compatibility_options" (
    "value" numeric(3,2) NOT NULL,
    "label" "jsonb",
    "description" "jsonb",
    "id" bigint NOT NULL,
    "question_id" bigint,
    CONSTRAINT "question_options_value_numeric_check" CHECK ((("value" >= (0)::numeric) AND ("value" <= (1)::numeric)))
);


ALTER TABLE "public"."compatibility_options" OWNER TO "postgres";


ALTER TABLE "public"."compatibility_options" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."compatibility_options_new_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."compatibility_questions" (
    "code" "text",
    "multi_select" boolean NOT NULL,
    "section_id" bigint,
    "label" "jsonb",
    "pos" smallint NOT NULL,
    "id" bigint NOT NULL
);


ALTER TABLE "public"."compatibility_questions" OWNER TO "postgres";


ALTER TABLE "public"."compatibility_questions" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."compatibility_questions_new_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."compatibility_sections" (
    "id" bigint NOT NULL,
    "code" "text" NOT NULL,
    "label" "jsonb"
);


ALTER TABLE "public"."compatibility_sections" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."countries" (
    "id" bigint NOT NULL,
    "name" "text",
    "iso3" "text",
    "iso2" "text",
    "numeric_code" bigint,
    "phonecode" bigint,
    "capital" "text",
    "currency" "text",
    "currency_name" "text",
    "currency_symbol" "text",
    "tld" "text",
    "native" "text",
    "population" bigint,
    "region" "text",
    "region_id" bigint,
    "subregion" "text",
    "subregion_id" bigint,
    "nationality" "text",
    "timezones" "text",
    "latitude" double precision,
    "longitude" double precision,
    "emoji" "text",
    "emojiU" "text",
    "wiki_dataId" "text",
    "flag_url" "text"
);


ALTER TABLE "public"."countries" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."group_destinations" (
    "group_id" "uuid" NOT NULL,
    "countries_id" bigint NOT NULL,
    "counts" smallint
);


ALTER TABLE "public"."group_destinations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."group_members" (
    "group_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL
);


ALTER TABLE "public"."group_members" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."groups" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "dates" "daterange",
    "days" "int4range",
    "mates" "int4range",
    "budget" "int4range"
);


ALTER TABLE "public"."groups" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "first_name" "text",
    "last_name" "text",
    "birth_date" "date",
    "city" bigint,
    "phone" "text",
    "gender" "text",
    CONSTRAINT "profiles_phone_number_check" CHECK (("phone" ~ '^\+[1-9]\d{6,14}$'::"text")),
    CONSTRAINT "username_length" CHECK (("char_length"("first_name") >= 3))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."question_groups_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."question_groups_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."question_groups_id_seq" OWNED BY "public"."compatibility_sections"."id";



ALTER TABLE ONLY "public"."compatibility_sections" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."question_groups_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."cities"
    ADD CONSTRAINT "cities_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."compatibility_answers"
    ADD CONSTRAINT "compatibility_answers_pkey" PRIMARY KEY ("profile_id", "option_id");



ALTER TABLE ONLY "public"."compatibility_destinations"
    ADD CONSTRAINT "compatibility_destinations_pkey" PRIMARY KEY ("profile_id", "country_id");



ALTER TABLE ONLY "public"."compatibility_options"
    ADD CONSTRAINT "compatibility_options_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."compatibility_questions"
    ADD CONSTRAINT "compatibility_questions_order_key" UNIQUE ("pos");



ALTER TABLE ONLY "public"."compatibility_questions"
    ADD CONSTRAINT "compatibility_questions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."compatibility"
    ADD CONSTRAINT "compatibility_vectors_pkey" PRIMARY KEY ("user_id");



ALTER TABLE ONLY "public"."countries"
    ADD CONSTRAINT "countries_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."countries"
    ADD CONSTRAINT "countries_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."group_destinations"
    ADD CONSTRAINT "group_destinations_pkey" PRIMARY KEY ("group_id", "countries_id");



ALTER TABLE ONLY "public"."group_members"
    ADD CONSTRAINT "group_members_pkey" PRIMARY KEY ("group_id", "user_id");



ALTER TABLE ONLY "public"."group_members"
    ADD CONSTRAINT "group_members_user_id_key" UNIQUE ("user_id");



ALTER TABLE ONLY "public"."groups"
    ADD CONSTRAINT "groups_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."compatibility_sections"
    ADD CONSTRAINT "question_groups_code_key" UNIQUE ("code");



ALTER TABLE ONLY "public"."compatibility_sections"
    ADD CONSTRAINT "question_groups_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."compatibility_questions"
    ADD CONSTRAINT "questions_code_key" UNIQUE ("code");



CREATE INDEX "compatibility_destination_idx" ON "public"."compatibility" USING "gin" ("destination");



CREATE OR REPLACE TRIGGER "compatibility_answer_insert_check" BEFORE INSERT ON "public"."compatibility_answers" FOR EACH ROW EXECUTE FUNCTION "public"."compatibility_answer_check"();



CREATE OR REPLACE TRIGGER "compatibility_answers_insert_question_id" BEFORE INSERT ON "public"."compatibility_answers" FOR EACH ROW EXECUTE FUNCTION "public"."compatibility_answer_add_question_id"();



CREATE OR REPLACE TRIGGER "compatibility_answers_update_vector" AFTER INSERT OR DELETE OR UPDATE ON "public"."compatibility_answers" FOR EACH ROW EXECUTE FUNCTION "public"."compatibility_vectors_compute"();



CREATE OR REPLACE TRIGGER "compatibility_destinations_vector" AFTER INSERT OR DELETE OR UPDATE ON "public"."compatibility_destinations" FOR EACH ROW EXECUTE FUNCTION "public"."compatibility_destinations_update_vector"();



CREATE OR REPLACE TRIGGER "compatibility_on_change" AFTER INSERT OR UPDATE ON "public"."compatibility" FOR EACH ROW EXECUTE FUNCTION "public"."compatibility_group_creation"();



CREATE OR REPLACE TRIGGER "on_profile_delete" AFTER DELETE ON "public"."profiles" FOR EACH ROW EXECUTE FUNCTION "public"."handle_profile_deletion"();



ALTER TABLE ONLY "public"."cities"
    ADD CONSTRAINT "cities_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."compatibility_answers"
    ADD CONSTRAINT "compatibility_answers_option_id_fkey" FOREIGN KEY ("option_id") REFERENCES "public"."compatibility_options"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."compatibility_answers"
    ADD CONSTRAINT "compatibility_answers_profile_id_fkey" FOREIGN KEY ("profile_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."compatibility_answers"
    ADD CONSTRAINT "compatibility_answers_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "public"."compatibility_questions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."compatibility_destinations"
    ADD CONSTRAINT "compatibility_destinations_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "public"."countries"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."compatibility_destinations"
    ADD CONSTRAINT "compatibility_destinations_profile_id_fkey" FOREIGN KEY ("profile_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."compatibility_options"
    ADD CONSTRAINT "compatibility_options_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "public"."compatibility_questions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."compatibility"
    ADD CONSTRAINT "compatibility_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."group_destinations"
    ADD CONSTRAINT "group_destinations_countries_id_fkey" FOREIGN KEY ("countries_id") REFERENCES "public"."countries"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."group_destinations"
    ADD CONSTRAINT "group_destinations_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."group_members"
    ADD CONSTRAINT "group_members_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "public"."groups"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."group_members"
    ADD CONSTRAINT "group_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_countries_fkey" FOREIGN KEY ("city") REFERENCES "public"."cities"("id") ON UPDATE CASCADE ON DELETE SET NULL;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON UPDATE CASCADE ON DELETE CASCADE;



ALTER TABLE ONLY "public"."compatibility_questions"
    ADD CONSTRAINT "questions_group_id_fkey" FOREIGN KEY ("section_id") REFERENCES "public"."compatibility_sections"("id");



CREATE POLICY "Enable delete for users based on user_id" ON "public"."compatibility_answers" FOR DELETE TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = "profile_id"));



CREATE POLICY "Enable delete for users based on user_id" ON "public"."compatibility_destinations" FOR DELETE TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = "profile_id"));



CREATE POLICY "Enable insert for users based on user_id" ON "public"."compatibility" FOR INSERT TO "authenticated" WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Enable insert for users based on user_id" ON "public"."compatibility_answers" FOR INSERT TO "authenticated" WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "profile_id"));



CREATE POLICY "Enable insert for users based on user_id" ON "public"."compatibility_destinations" FOR INSERT TO "authenticated" WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "profile_id"));



CREATE POLICY "Enable read access for all users" ON "public"."cities" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Enable read access for all users" ON "public"."compatibility_options" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Enable read access for all users" ON "public"."compatibility_questions" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Enable read access for all users" ON "public"."compatibility_sections" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Enable read access for all users" ON "public"."countries" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Enable read for users based on group_id" ON "public"."group_destinations" FOR SELECT TO "authenticated" USING (("group_id" IN ( SELECT "public"."get_my_group_ids"() AS "get_my_group_ids")));



CREATE POLICY "Enable read for users based on group_id" ON "public"."group_members" FOR SELECT TO "authenticated" USING (("group_id" IN ( SELECT "public"."get_my_group_ids"() AS "get_my_group_ids")));



CREATE POLICY "Enable read for users based on group_id" ON "public"."groups" FOR SELECT TO "authenticated" USING (("id" IN ( SELECT "public"."get_my_group_ids"() AS "get_my_group_ids")));



CREATE POLICY "Enable update for users based on user_id" ON "public"."compatibility" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Enable users to view their own data only" ON "public"."compatibility" FOR SELECT TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = "user_id"));



CREATE POLICY "Enable users to view their own data only" ON "public"."compatibility_answers" FOR SELECT TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = "profile_id"));



CREATE POLICY "Enable users to view their own data only" ON "public"."compatibility_destinations" FOR SELECT TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = "profile_id"));



CREATE POLICY "Public profiles are viewable by everyone." ON "public"."profiles" FOR SELECT USING (true);



CREATE POLICY "Users can insert their own profile." ON "public"."profiles" FOR INSERT WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "id"));



CREATE POLICY "Users can update own profile." ON "public"."profiles" FOR UPDATE USING ((( SELECT "auth"."uid"() AS "uid") = "id"));



ALTER TABLE "public"."cities" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."compatibility" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."compatibility_answers" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."compatibility_destinations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."compatibility_options" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."compatibility_questions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."compatibility_sections" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."countries" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."group_destinations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."group_members" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."groups" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";



GRANT ALL ON FUNCTION "public"."build_group"("seed_user_id" "uuid", "min_common_countries" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."build_group"("seed_user_id" "uuid", "min_common_countries" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."build_group"("seed_user_id" "uuid", "min_common_countries" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."compatibility_answer_add_question_id"() TO "anon";
GRANT ALL ON FUNCTION "public"."compatibility_answer_add_question_id"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."compatibility_answer_add_question_id"() TO "service_role";



GRANT ALL ON FUNCTION "public"."compatibility_answer_check"() TO "anon";
GRANT ALL ON FUNCTION "public"."compatibility_answer_check"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."compatibility_answer_check"() TO "service_role";



GRANT ALL ON FUNCTION "public"."compatibility_destinations_update_vector"() TO "anon";
GRANT ALL ON FUNCTION "public"."compatibility_destinations_update_vector"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."compatibility_destinations_update_vector"() TO "service_role";



GRANT ALL ON FUNCTION "public"."compatibility_group_creation"() TO "anon";
GRANT ALL ON FUNCTION "public"."compatibility_group_creation"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."compatibility_group_creation"() TO "service_role";



GRANT ALL ON FUNCTION "public"."compatibility_vectors_compute"() TO "anon";
GRANT ALL ON FUNCTION "public"."compatibility_vectors_compute"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."compatibility_vectors_compute"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_my_group_ids"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_group_ids"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_group_ids"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_profile_deletion"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_profile_deletion"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_profile_deletion"() TO "service_role";



GRANT ALL ON TABLE "public"."cities" TO "anon";
GRANT ALL ON TABLE "public"."cities" TO "authenticated";
GRANT ALL ON TABLE "public"."cities" TO "service_role";



GRANT ALL ON TABLE "public"."compatibility" TO "anon";
GRANT ALL ON TABLE "public"."compatibility" TO "authenticated";
GRANT ALL ON TABLE "public"."compatibility" TO "service_role";



GRANT ALL ON TABLE "public"."compatibility_answers" TO "anon";
GRANT ALL ON TABLE "public"."compatibility_answers" TO "authenticated";
GRANT ALL ON TABLE "public"."compatibility_answers" TO "service_role";



GRANT ALL ON TABLE "public"."compatibility_destinations" TO "anon";
GRANT ALL ON TABLE "public"."compatibility_destinations" TO "authenticated";
GRANT ALL ON TABLE "public"."compatibility_destinations" TO "service_role";



GRANT ALL ON TABLE "public"."compatibility_options" TO "anon";
GRANT ALL ON TABLE "public"."compatibility_options" TO "authenticated";
GRANT ALL ON TABLE "public"."compatibility_options" TO "service_role";



GRANT ALL ON SEQUENCE "public"."compatibility_options_new_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."compatibility_options_new_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."compatibility_options_new_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."compatibility_questions" TO "anon";
GRANT ALL ON TABLE "public"."compatibility_questions" TO "authenticated";
GRANT ALL ON TABLE "public"."compatibility_questions" TO "service_role";



GRANT ALL ON SEQUENCE "public"."compatibility_questions_new_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."compatibility_questions_new_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."compatibility_questions_new_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."compatibility_sections" TO "anon";
GRANT ALL ON TABLE "public"."compatibility_sections" TO "authenticated";
GRANT ALL ON TABLE "public"."compatibility_sections" TO "service_role";



GRANT ALL ON TABLE "public"."countries" TO "anon";
GRANT ALL ON TABLE "public"."countries" TO "authenticated";
GRANT ALL ON TABLE "public"."countries" TO "service_role";



GRANT ALL ON TABLE "public"."group_destinations" TO "anon";
GRANT ALL ON TABLE "public"."group_destinations" TO "authenticated";
GRANT ALL ON TABLE "public"."group_destinations" TO "service_role";



GRANT ALL ON TABLE "public"."group_members" TO "anon";
GRANT ALL ON TABLE "public"."group_members" TO "authenticated";
GRANT ALL ON TABLE "public"."group_members" TO "service_role";



GRANT ALL ON TABLE "public"."groups" TO "anon";
GRANT ALL ON TABLE "public"."groups" TO "authenticated";
GRANT ALL ON TABLE "public"."groups" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON SEQUENCE "public"."question_groups_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."question_groups_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."question_groups_id_seq" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";







