-- This trigger calls the compatibility_answer_check function before inserting a new row into the compatibility_answers table.
-- Its purpose is to prevent duplicate answers for the same question and profile when the question is single select, ensuring data integrity according to the rules defined in the function.
-- Use this trigger to enforce uniqueness constraints on compatibility answers at the database level for single select questions.


CREATE TRIGGER compatibility_answer_insert_check
BEFORE INSERT ON compatibility_answers
FOR EACH ROW
EXECUTE FUNCTION compatibility_answer_check();