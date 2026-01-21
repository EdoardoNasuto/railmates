create table public.compatibility_answers (
  id uuid not null default gen_random_uuid (),
  profile_id uuid not null default auth.uid (),
  option_id bigint not null,
  question_id bigint not null,
  constraint compatibility_answers_pkey primary key (id),
  constraint compatibility_answers_profile_option_unique unique (profile_id, option_id),
  constraint profile_answers_option_id_fkey foreign KEY (option_id) references compatibility_options (id) on delete CASCADE,
  constraint profile_answers_profile_id_fkey foreign KEY (profile_id) references profiles (id) on delete CASCADE
) TABLESPACE pg_default;

create trigger compatibility_answer_insert_check BEFORE INSERT on compatibility_answers for EACH row
execute FUNCTION compatibility_answer_check ();

create trigger compatibility_answers_insert_question_id BEFORE INSERT on compatibility_answers for EACH row
execute FUNCTION compatibility_answer_add_question_id ();