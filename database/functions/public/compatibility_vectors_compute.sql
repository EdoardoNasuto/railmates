DECLARE
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
END;