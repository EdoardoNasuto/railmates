declare
  -- État actuel du groupe
  current_group_ids uuid[] := array[seed_user_id];
  current_personality extensions.vector;
  current_essential extensions.vector;
  current_destinations int[];
  current_start date;
  current_end date;

  -- Variables temporaires candidat
  candidate_id uuid;
  candidate_personality extensions.vector;
  candidate_destinations int[];
  candidate_start date;
  candidate_end date;
  
  found_new_member boolean;
begin
  -- 1. Initialisation avec le Seed User
  select personality, essential, destination, start_date, end_date
  into current_personality, current_essential, current_destinations, current_start, current_end
  from public.compatibility
  where public.compatibility.user_id = seed_user_id;

  if current_personality is null then return; end if;

  -- 2. Boucle itérative
  WHILE array_length(current_group_ids, 1) < target_group_size LOOP
    
    found_new_member := false;

    -- 3. Recherche du MEILLEUR candidat
    SELECT 
      c.user_id, c.personality, c.destination, c.start_date, c.end_date
    INTO 
      candidate_id, candidate_personality, candidate_destinations, candidate_start, candidate_end
    FROM 
      public.compatibility c
    WHERE 
      c.user_id <> ALL(current_group_ids) -- Pas déjà dans le groupe
      AND c.essential = current_essential
      -- Dates
      AND (LEAST(c.end_date, current_end) - GREATEST(c.start_date, current_start)) >= min_common_days
      -- Destinations (Intersection)
      AND (
          SELECT count(*) 
          FROM (
             SELECT unnest(c.destination) 
             INTERSECT 
             SELECT unnest(current_destinations)
          ) as intersection
      ) >= min_common_countries

    ORDER BY 
      c.personality <=> current_personality ASC
    LIMIT 1;

    -- 4. Si trouvé, mise à jour
    IF candidate_id IS NOT NULL THEN
      current_group_ids := array_append(current_group_ids, candidate_id);
      found_new_member := true;

      -- Update Dates
      current_start := GREATEST(current_start, candidate_start);
      current_end := LEAST(current_end, candidate_end);

      -- Update Destinations
      SELECT array_agg(x) INTO current_destinations
      FROM (
        SELECT unnest(current_destinations) AS x
        INTERSECT
        SELECT unnest(candidate_destinations)
      ) t;

      -- Update Personality (Moyenne)
      SELECT avg(personality) INTO current_personality 
      FROM public.compatibility 
      WHERE public.compatibility.user_id = ANY(current_group_ids);
    ELSE
      EXIT; -- Plus de candidat valide
    END IF;

  END LOOP;

  -- 5. Retourner le résultat (CORRECTION ICI : ::int)
  RETURN QUERY
  SELECT 
    gm.uid as user_id,
    (gm.uid = seed_user_id) as is_seed,
    gm.idx::int as match_round  -- <--- CORRECTION: conversion explicite de bigint vers int
  FROM unnest(current_group_ids) with ordinality as gm(uid, idx);
end;