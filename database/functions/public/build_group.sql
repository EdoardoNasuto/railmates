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
  final_max_mates smallint,
  final_min_budget int,   
  final_max_budget int    
) 
LANGUAGE plpgsql
AS $$
DECLARE
  -- État du groupe
  current_group_ids uuid[] := array[seed_user_id];
  current_group_size int := 1;
  
  -- Vecteurs et Destinations
  current_personality extensions.vector;
  current_destinations int[];
  
  -- Calendrier
  current_start date;
  current_end date;
  
  -- Contraintes dynamiques (Intersection)
  current_min_duration smallint;
  current_max_duration smallint;
  current_min_mates smallint;
  current_max_mates smallint;
  current_min_budget int;
  current_max_budget int;

  -- Candidat
  candidate_rec record;
  
  -- Config
  max_distance float8 := 0.15;
BEGIN
  -- 1. Initialisation Seed
  SELECT 
    personality, destination, start_date, end_date, 
    min_days, max_days, min_mates, max_mates,
    min_budget, max_budget
  INTO 
    current_personality, current_destinations, current_start, current_end, 
    current_min_duration, current_max_duration, current_min_mates, current_max_mates,
    current_min_budget, current_max_budget
  FROM public.compatibility
  WHERE public.compatibility.user_id = seed_user_id;

  IF current_personality IS NULL THEN RETURN; END IF;

  -- 2. Boucle itérative
  WHILE current_group_size < current_max_mates LOOP
    
    -- 3. Recherche du candidat
    SELECT 
      c.user_id, c.personality, c.destination, c.start_date, c.end_date, 
      c.min_days, c.max_days, c.min_mates, c.max_mates,
      c.min_budget, c.max_budget
    INTO candidate_rec
    FROM public.compatibility c
    WHERE 
      -- A. Filtres de base
      c.user_id <> ALL(current_group_ids)
      AND c.destination && current_destinations

      -- B. Compatibilité DURÉES (Jours)
      AND GREATEST(c.min_days, current_min_duration) <= LEAST(c.max_days, current_max_duration)
      AND (LEAST(c.end_date, current_end) - GREATEST(c.start_date, current_start)) >= GREATEST(c.min_days, current_min_duration)

      -- C. Compatibilité BUDGET
      AND GREATEST(c.min_budget, current_min_budget) <= LEAST(c.max_budget, current_max_budget)

      -- D. Compatibilité TAILLES DE GROUPE (Mates)
      AND GREATEST(c.min_mates, current_min_mates) <= LEAST(c.max_mates, current_max_mates)
      AND (current_group_size + 1) <= LEAST(c.max_mates, current_max_mates) -- Look-ahead

      -- E. Filtre Vectoriel (Personnalité)
      AND (c.personality <-> current_personality) / vector_dims(current_personality) < max_distance

      -- F. Filtre Destination "Lourd"
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

      -- Mise à jour Contraintes Budget (Rétrécissement)
      current_min_budget := GREATEST(current_min_budget, candidate_rec.min_budget);
      current_max_budget := LEAST(current_max_budget, candidate_rec.max_budget);

      -- Mise à jour Contraintes Mates (Rétrécissement)
      current_min_mates := GREATEST(current_min_mates, candidate_rec.min_mates);
      current_max_mates := LEAST(current_max_mates, candidate_rec.max_mates);

      -- Mise à jour Destinations
      SELECT ARRAY(
        SELECT unnest(current_destinations)
        INTERSECT
        SELECT unnest(candidate_rec.destination)
      ) INTO current_destinations;

      -- Mise à jour Personality (Moyenne du groupe)
      SELECT AVG(personality) INTO current_personality 
      FROM public.compatibility 
      WHERE public.compatibility.user_id = ANY(current_group_ids);

    ELSE
      -- Plus aucun candidat ne matche
      EXIT; 
    END IF;

  END LOOP;

  -- 5. Validation Finale
  IF current_group_size < current_min_mates THEN
    RETURN;
  END IF;

  -- 6. Succès : Retourner le groupe avec toutes les infos finales
  RETURN QUERY
  SELECT 
    gm.uid,
    (gm.uid = seed_user_id),
    gm.idx::int,
    current_min_duration,
    current_max_duration,
    current_min_mates,
    current_max_mates,
    current_min_budget,
    current_max_budget 
  FROM unnest(current_group_ids) with ordinality as gm(uid, idx);
END;
$$;