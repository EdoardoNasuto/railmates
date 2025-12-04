-- This trigger executes the handle_new_user function after a new row is inserted into the users table
-- It automatically creates a profile when a new user is created

CREATE TRIGGER on_auth_user_created
AFTER INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION handle_new_user();
