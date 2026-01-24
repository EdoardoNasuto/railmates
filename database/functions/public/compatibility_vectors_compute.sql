DECLARE
    target_profile_id uuid;
    calculated_vector float8[];
BEGIN
    -- Identifier l'utilisateur concerné
    IF (TG_OP = 'DELETE') THEN
        target_profile_id := OLD.profile_id;
    ELSE
        target_profile_id := NEW.profile_id;
    END IF;

    -- Calcul du vecteur (Moyenne des valeurs, 0 si vide)
    SELECT ARRAY_AGG(
        COALESCE(user_vals.avg_val, 0)
        ORDER BY q.section_id ASC, q.pos ASC
    )
    INTO calculated_vector
    FROM public.compatibility_questions q
    LEFT JOIN (
        SELECT 
            a.question_id, 
            AVG(o.value) as avg_val
        FROM public.compatibility_answers a
        JOIN public.compatibility_options o ON a.option_id = o.id
        WHERE a.profile_id = target_profile_id
        GROUP BY a.question_id
    ) user_vals ON q.id = user_vals.question_id
    WHERE q.section_id BETWEEN 2 AND 5;

    -- Upsert du vecteur
    IF calculated_vector IS NOT NULL THEN
        INSERT INTO public.compatibility_vectors (user_id, vector)
        VALUES (target_profile_id, calculated_vector::vector)
        ON CONFLICT (user_id) 
        DO UPDATE SET vector = EXCLUDED.vector;
    END IF;

    RETURN NULL;
END;