
DECLARE
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
END;
