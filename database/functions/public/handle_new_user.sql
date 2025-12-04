-- This function inserts a new profile into the public.profiles table
-- It uses the last_name and avatar_url fields extracted from raw_user_meta_data
-- To be used as a trigger or procedure when adding a new user

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, last_name, avatar_url)
    VALUES (NEW.id, NEW.raw_user_meta_data->>'last_name', NEW.raw_user_meta_data->>'avatar_url');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
