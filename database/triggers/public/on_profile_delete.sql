CREATE TRIGGER on_profile_delete
AFTER DELETE ON public.profiles
FOR EACH ROW
EXECUTE FUNCTION public.handle_profile_deletion();