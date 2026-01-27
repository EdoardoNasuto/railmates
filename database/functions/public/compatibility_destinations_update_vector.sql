
DECLARE
    _user_id uuid;
    _vector_data integer[];
BEGIN
    -- Gestion du ID utilisateur selon l'opération
    IF (TG_OP = 'DELETE') THEN
        _user_id := OLD.profile_id;
    ELSE
        _user_id := NEW.profile_id;
    END IF;

    -- Construction du vecteur binaire [1, 0, 0, 1...]
    -- Basé sur l'ordre immuable des IDs de la table countries
    SELECT array_agg(
        CASE 
            WHEN cd.country_id IS NOT NULL THEN 1 
            ELSE 0 
        END
        ORDER BY c.id ASC
    )
    INTO _vector_data
    FROM public.countries c
    LEFT JOIN public.compatibility_destinations cd 
        ON c.id = cd.country_id AND cd.profile_id = _user_id;

    -- Mise à jour de la table compatibility
    UPDATE public.compatibility
    SET destination = _vector_data
    WHERE user_id = _user_id;

    RETURN NULL;
END;
