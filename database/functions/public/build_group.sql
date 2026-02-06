CREATE OR REPLACE FUNCTION build_group(
  seed_user_id uuid, 
  min_common_countries int DEFAULT 1
)
RETURNS TABLE (
  uid uuid,
  is_seed boolean,
  idx int,
  dates daterange,
  days int4range,
  mates int4range,
  budget int4range 
) 
LANGUAGE plpgsql
AS $$
DECLARE
  -- Variables internes (préfixées par current_ pour éviter les conflits)
  current_group_ids uuid[] := array[seed_user_id];
  current_group_size int := 1;
  
  current_personality vector; 
  current_destinations int[];
  
  -- Variables "buffer" pour stocker les intersections
  current_dates daterange;
  current_days int4range;
  current_mates int4range;
  current_budget int4range;

  candidate_rec record;
  max_distance float8 := 0.4;
BEGIN
  -- 1. Initialisation Seed
  -- CORRECTION ICI : Utilisation de l'alias 'c' pour lever l'ambiguïté
  SELECT 
    c.personality, c.destination, c.dates, c.days, c.mates, c.budget
  INTO 
    current_personality, current_destinations, current_dates, current_days, current_mates, current_budget
  FROM public.compatibility c  -- <-- Alias défini ici
  WHERE c.user_id = seed_user_id;

  IF current_personality IS NULL THEN RETURN; END IF;

  -- 2. Boucle
  WHILE current_group_size < (upper(current_mates) - 1) LOOP
    
    -- 3. Recherche candidat
    -- CORRECTION ICI AUSSI : Utilisation stricte de l'alias 'c'
    SELECT 
      c.user_id, c.personality, c.destination, 
      c.dates, c.days, c.mates, c.budget
    INTO candidate_rec
    FROM public.compatibility c
    WHERE 
      c.user_id <> ALL(current_group_ids)
      AND c.destination && current_destinations
      AND c.days && current_days
      AND c.budget && current_budget
      AND c.mates && current_mates
      AND c.dates && current_dates 
      
      -- Logique temporelle
      AND (upper(c.dates * current_dates) - lower(c.dates * current_dates)) >= lower(c.days * current_days)
      
      -- Logique taille
      AND (current_group_size + 1) < upper(c.mates * current_mates)
      
      -- Logique Vectorielle
      AND (c.personality <-> current_personality) / sqrt(vector_dims(current_personality)) < max_distance
      
      -- Logique Destination
      AND (
          SELECT count(*)
          FROM (
            SELECT unnest(c.destination)
            INTERSECT
            SELECT unnest(current_destinations)
          ) i
      ) >= min_common_countries

    ORDER BY 
      (
        SELECT count(*)
        FROM (
          SELECT unnest(c.destination)
          INTERSECT
          SELECT unnest(current_destinations)
        ) i
      ) DESC,
      c.personality <-> current_personality ASC 
    LIMIT 1;

    -- 4. Mise à jour si trouvé
    IF candidate_rec.user_id IS NOT NULL THEN
      current_group_ids := array_append(current_group_ids, candidate_rec.user_id);
      current_group_size := current_group_size + 1;
      
      -- Intersection des ranges
      current_dates  := current_dates * candidate_rec.dates;
      current_days   := current_days * candidate_rec.days;
      current_mates  := current_mates * candidate_rec.mates;
      current_budget := current_budget * candidate_rec.budget;

      SELECT ARRAY(
        SELECT unnest(current_destinations)
        INTERSECT
        SELECT unnest(candidate_rec.destination)
      ) INTO current_destinations;

      -- On cible explicitement la table pour le calcul de moyenne aussi
      SELECT AVG(t.personality) INTO current_personality 
      FROM public.compatibility t
      WHERE t.user_id = ANY(current_group_ids);

    ELSE
      EXIT; 
    END IF;

  END LOOP;

  -- 5. Validation
  IF current_group_size < lower(current_mates) THEN
    RETURN;
  END IF;

  -- 6. Retour
  RETURN QUERY
  SELECT 
    gm.uid,
    (gm.uid = seed_user_id),
    gm.idx::int,
    current_dates,  -- Ici on renvoie les variables internes vers les colonnes de sortie
    current_days,
    current_mates,
    current_budget
  FROM unnest(current_group_ids) with ordinality as gm(uid, idx);
END;
$$;