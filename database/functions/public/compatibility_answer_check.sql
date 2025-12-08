-- This function is a PL/pgSQL trigger that checks the uniqueness of answers to compatibility questions when inserting into the compatibility_answers table.
-- It only applies to questions that are not multi-select (single select):
--   - If the question is single select, it prevents multiple answers for the same question and profile.
-- If a violation occurs, an exception is raised to ensure the integrity of the answers.
-- To be used as a BEFORE INSERT trigger on the compatibility_answers table.


CREATE OR REPLACE FUNCTION compatibility_answer_check()
RETURNS TRIGGER AS $$
DECLARE
    -- Get the question ID and multi_select value for the inserted option
    question_id_var bigint;
    is_multi_select boolean;
BEGIN
    SELECT compatibility_options.question_id, (compatibility_questions.multi_select::boolean)
    INTO question_id_var, is_multi_select
    FROM compatibility_options
    JOIN compatibility_questions ON compatibility_options.question_id = compatibility_questions.id
    WHERE compatibility_options.id = NEW.option_id
    LIMIT 1;

    IF is_multi_select = false THEN
        -- Check that there is no other answer for this question and profile
        IF EXISTS (
            SELECT 1
            FROM compatibility_answers ca
            WHERE ca.profile_id = NEW.profile_id
                AND ca.option_id IN (
                    SELECT id FROM compatibility_options WHERE question_id = question_id_var
                )
        ) THEN
            RAISE EXCEPTION 'An answer for this question and profile already exists (single select)';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;