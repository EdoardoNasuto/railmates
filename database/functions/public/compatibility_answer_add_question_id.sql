CREATE OR REPLACE FUNCTION public.compatibility_answer_add_question_id()
RETURNS TRIGGER AS $$
BEGIN
    SELECT question_id INTO NEW.question_id
    FROM public.compatibility_options
    WHERE id = NEW.option_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;