DECLARE
  -- État du groupe (Variables accumulatrices)
  current_group_ids uuid[] := array[seed_user_id];
  current_personality extensions.vector;
  current_essential extensions.vector; 
  current_destinations int[];
  current_start date;
  current_end date;
  
  -- NOUVEAU : Range de durée acceptée par le groupe (intersection des préférences)
  current_min_duration smallint;
  current_max_duration smallint;

  -- Variables candidat
  candidate_rec record;
  
  -- Configuration
  max_distance float8 := 0.15;
BEGIN
  -- 1. Initialisation Seed
  -- On récupère aussi min_days et max_days du premier utilisateur
  SELECT personality, essential, destination, start_date, end_date, min_days, max_days
  INTO current_personality, current_essential, current_destinations, current_start, current_end, current_min_duration, current_max_duration
  FROM public.compatibility
  WHERE public.compatibility.user_id = seed_user_id;

  IF current_personality IS NULL THEN RETURN; END IF;

  -- 2. Boucle itérative
  WHILE array_length(current_group_ids, 1) < target_group_size LOOP
    
    -- 3. Recherche du MEILLEUR candidat
    SELECT 
      c.user_id, c.personality, c.destination, c.start_date, c.end_date, c.min_days, c.max_days
    INTO candidate_rec
    FROM public.compatibility c
    WHERE 
      -- A. Filtres de base
      c.essential = current_essential
      AND c.user_id <> ALL(current_group_ids)
      AND c.destination && current_destinations -- Overlap rapide destination

      -- B. NOUVEAU : Filtre de compatibilité des durées (Range Intersection)
      -- 1. Vérifier que les PRÉFÉRENCES de durée se chevauchent
      -- Le plus exigeant des mins doit être <= au plus restrictif des max
      AND GREATEST(c.min_days, current_min_duration) <= LEAST(c.max_days, current_max_duration)

      -- 2. Vérifier que le CALENDRIER permet cette nouvelle durée minimale
      -- (Fin commune - Début commun) >= (Le plus grand des minimums requis)
      AND (LEAST(c.end_date, current_end) - GREATEST(c.start_date, current_start)) >= GREATEST(c.min_days, current_min_duration)

      -- C. Filtre Vectoriel (HNSW)
      AND (c.personality <-> current_personality) / vector_dims(current_personality) < max_distance

      -- D. Filtre Destination "Lourd" (Intersection Count)
      AND (
          SELECT count(*)
          FROM (
            SELECT unnest(c.destination)
            INTERSECT
            SELECT unnest(current_destinations)
          ) i
      ) >= min_common_countries

    -- Tri par nombre de destinations communes, puis affinité
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

    -- 4. Si trouvé, mise à jour
    IF candidate_rec.user_id IS NOT NULL THEN
      -- A. Mise à jour des IDs
      current_group_ids := array_append(current_group_ids, candidate_rec.user_id);
      
      -- B. Mise à jour des Dates (Calendrier) - On rétrécit la fenêtre
      current_start := GREATEST(current_start, candidate_rec.start_date);
      current_end := LEAST(current_end, candidate_rec.end_date);

      -- C. NOUVEAU : Mise à jour des Durées (Préférences) - On rétrécit l'intervalle
      -- Le groupe doit satisfaire le minimum le plus élevé de tous ses membres
      current_min_duration := GREATEST(current_min_duration, candidate_rec.min_days);
      -- Le groupe ne peut pas dépasser le maximum le plus bas de tous ses membres
      current_max_duration := LEAST(current_max_duration, candidate_rec.max_days);

      -- D. Mise à jour des Destinations
      SELECT ARRAY(
        SELECT unnest(current_destinations)
        INTERSECT
        SELECT unnest(candidate_rec.destination)
      ) INTO current_destinations;

      -- E. Mise à jour Personality (Moyenne du groupe)
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
    gm.idx::int,
    current_min_duration, -- On retourne la contrainte finale calculée
    current_max_duration
  FROM unnest(current_group_ids) with ordinality as gm(uid, idx);
END;