CREATE OR REPLACE FUNCTION public.handle_profile_deletion()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, storage, auth
AS $$
DECLARE
  bucket_cible text := 'avatars';
BEGIN
  DELETE FROM storage.objects
  WHERE bucket_id = bucket_cible
  AND name LIKE OLD.id::text || '/%';

  IF EXISTS (SELECT 1 FROM auth.users WHERE id = OLD.id) THEN
    DELETE FROM auth.users WHERE id = OLD.id;
  END IF;

  RETURN OLD;
END;
$$;