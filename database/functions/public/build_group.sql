DECLARE
  -- État du groupe
  current_group_ids uuid[] := array[seed_user_id];
  current_personality extensions.vector;
  current_essential extensions.vector; 
  current_destinations int[];
  current_start date;
  current_end date;

  -- Variables candidat
  candidate_rec record;
  
  -- Configuration
  max_distance float8 := 0.2;
BEGIN
  -- 1. Initialisation Seed
  SELECT personality, essential, destination, start_date, end_date
  INTO current_personality, current_essential, current_destinations, current_start, current_end
  FROM public.compatibility
  WHERE public.compatibility.user_id = seed_user_id;

  IF current_personality IS NULL THEN RETURN; END IF;

  -- 2. Boucle itérative
  WHILE array_length(current_group_ids, 1) < target_group_size LOOP
    
    -- 3. Recherche du MEILLEUR candidat
    SELECT 
      c.user_id, c.personality, c.destination, c.start_date, c.end_date
    INTO candidate_rec
    FROM public.compatibility c
    WHERE 
      -- A. Filtres Rapides (Scalaires & Indexables)
      c.essential = current_essential
      AND c.user_id <> ALL(current_group_ids)
      
      -- Filtre Index GIN (Overlap): Vérifie s'il y a AU MOINS UN pays en commun très vite
      AND c.destination && current_destinations 

      -- B. Filtre Dates (Math simple)
      AND (LEAST(c.end_date, current_end) - GREATEST(c.start_date, current_start)) >= min_common_days

      -- C. Filtre Vectoriel (HNSW)
      AND (c.personality <#> current_personality) < max_distance

      -- D. Filtre Destination "Lourd" (Calcul exact après filtrage rapide)
      -- On ne fait ce calcul coûteux que sur les quelques lignes qui ont passé les filtres A, B et C
      AND (
          SELECT count(*)
          FROM (
            SELECT unnest(c.destination)
            INTERSECT
            SELECT unnest(current_destinations)
          ) i
      ) >= min_common_countries

    ORDER BY 
      c.personality <#> current_personality ASC
    LIMIT 1;

    -- 4. Si trouvé, mise à jour
    IF candidate_rec.user_id IS NOT NULL THEN
      -- Mise à jour des IDs
      current_group_ids := array_append(current_group_ids, candidate_rec.user_id);
      
      -- Mise à jour des Dates
      current_start := GREATEST(current_start, candidate_rec.start_date);
      current_end := LEAST(current_end, candidate_rec.end_date);

      -- Mise à jour des Destinations (Intersection stricte pour le tour suivant)
      SELECT ARRAY(
        SELECT unnest(current_destinations)
        INTERSECT
        SELECT unnest(candidate_rec.destination)
      ) INTO current_destinations;

      -- Mise à jour Personality (Via SQL standard pour éviter l'erreur d'opérateur)
      -- C'est très rapide car on filtre sur les IDs du groupe (Primary Key scan)
      SELECT AVG(personality) INTO current_personality 
      FROM public.compatibility 
      WHERE public.compatibility.user_id = ANY(current_group_ids);

    ELSE
      EXIT; -- Plus de candidat valide
    END IF;

  END LOOP;

  -- 5. Retourner le résultat
  RETURN QUERY
  SELECT 
    gm.uid,
    (gm.uid = seed_user_id),
    gm.idx::int
  FROM unnest(current_group_ids) with ordinality as gm(uid, idx);
END;