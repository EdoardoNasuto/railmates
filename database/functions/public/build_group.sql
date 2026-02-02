CREATE OR REPLACE FUNCTION build_group(
  seed_user_id uuid, 
  min_common_countries int DEFAULT 1
)
RETURNS TABLE (
  uid uuid,
  is_seed boolean,
  idx int,
  final_min_days smallint,
  final_max_days smallint,
  final_min_mates smallint,
  final_max_mates smallint
) 
LANGUAGE plpgsql
AS $$
DECLARE
  -- État du groupe
  current_group_ids uuid[] := array[seed_user_id];
  current_group_size int := 1; -- Optimisation pour éviter array_length répété
  
  -- Vecteurs et Destinations
  current_personality extensions.vector;
  current_essential extensions.vector; 
  current_destinations int[];
  
  -- Calendrier
  current_start date;
  current_end date;
  
  -- Contraintes dynamiques (Intersection)
  current_min_duration smallint;
  current_max_duration smallint;
  current_min_mates smallint;
  current_max_mates smallint;

  -- Candidat
  candidate_rec record;
  
  -- Config
  max_distance float8 := 0.15;
BEGIN
  -- 1. Initialisation Seed
  SELECT 
    personality, essential, destination, start_date, end_date, 
    min_days, max_days, min_mates, max_mates
  INTO 
    current_personality, current_essential, current_destinations, current_start, current_end, 
    current_min_duration, current_max_duration, current_min_mates, current_max_mates
  FROM public.compatibility
  WHERE public.compatibility.user_id = seed_user_id;

  IF current_personality IS NULL THEN RETURN; END IF;

  -- 2. Boucle itérative : On continue TANT QU'ON N'A PAS ATTEINT LE MAX COLLECTIF
  -- Note : current_max_mates peut diminuer au fil des ajouts
  WHILE current_group_size < current_max_mates LOOP
    
    -- 3. Recherche du candidat
    SELECT 
      c.user_id, c.personality, c.destination, c.start_date, c.end_date, 
      c.min_days, c.max_days, c.min_mates, c.max_mates
    INTO candidate_rec
    FROM public.compatibility c
    WHERE 
      -- A. Filtres de base
      c.essential = current_essential
      AND c.user_id <> ALL(current_group_ids)
      AND c.destination && current_destinations

      -- B. Compatibilité DURÉES (Jours)
      AND GREATEST(c.min_days, current_min_duration) <= LEAST(c.max_days, current_max_duration)
      AND (LEAST(c.end_date, current_end) - GREATEST(c.start_date, current_start)) >= GREATEST(c.min_days, current_min_duration)

      -- C. Compatibilité TAILLES DE GROUPE (Mates) - CRITIQUE
      -- 1. Intersection des préférences
      AND GREATEST(c.min_mates, current_min_mates) <= LEAST(c.max_mates, current_max_mates)
      
      -- 2. Vérification "Look-ahead" (Prédictive) :
      -- Si on ajoute ce candidat, la taille du groupe devient (current_group_size + 1).
      -- Cette nouvelle taille ne doit pas violer le NOUVEAU plafond imposé par ce candidat.
      AND (current_group_size + 1) <= LEAST(c.max_mates, current_max_mates)

      -- D. Filtre Vectoriel
      AND (c.personality <-> current_personality) / vector_dims(current_personality) < max_distance

      -- E. Filtre Destination "Lourd"
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

    -- 4. Traitement du résultat
    IF candidate_rec.user_id IS NOT NULL THEN
      -- Mise à jour IDs et Taille
      current_group_ids := array_append(current_group_ids, candidate_rec.user_id);
      current_group_size := current_group_size + 1;
      
      -- Mise à jour Calendrier
      current_start := GREATEST(current_start, candidate_rec.start_date);
      current_end := LEAST(current_end, candidate_rec.end_date);

      -- Mise à jour Contraintes Jours (Rétrécissement)
      current_min_duration := GREATEST(current_min_duration, candidate_rec.min_days);
      current_max_duration := LEAST(current_max_duration, candidate_rec.max_days);

      -- Mise à jour Contraintes Mates (Rétrécissement)
      current_min_mates := GREATEST(current_min_mates, candidate_rec.min_mates);
      current_max_mates := LEAST(current_max_mates, candidate_rec.max_mates);

      -- Mise à jour Destinations
      SELECT ARRAY(
        SELECT unnest(current_destinations)
        INTERSECT
        SELECT unnest(candidate_rec.destination)
      ) INTO current_destinations;

      -- Mise à jour Personality
      SELECT AVG(personality) INTO current_personality 
      FROM public.compatibility 
      WHERE public.compatibility.user_id = ANY(current_group_ids);

    ELSE
      -- Plus aucun candidat ne matche, on sort prématurément de la boucle
      EXIT; 
    END IF;

  END LOOP;

  -- 5. Validation Finale (Le "Check" Min Mates)
  -- Si la taille atteinte est inférieure au minimum requis par le membre le plus exigeant...
  IF current_group_size < current_min_mates THEN
    -- ... On retourne vide (équivalent de false/null)
    RETURN;
  END IF;

  -- 6. Succès : Retourner le groupe
  RETURN QUERY
  SELECT 
    gm.uid,
    (gm.uid = seed_user_id),
    gm.idx::int,
    current_min_duration,
    current_max_duration,
    current_min_mates,
    current_max_mates
  FROM unnest(current_group_ids) with ordinality as gm(uid, idx);
END;
$$;