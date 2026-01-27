create table public.compatibility_answers (
  profile_id uuid not null default auth.uid (),
  created_at timestamp with time zone not null default now(),
  question_id bigint not null,
  option_id bigint not null,
  constraint compatibility_answers_pkey primary key (profile_id, option_id),
  constraint compatibility_answers_option_id_fkey foreign KEY (option_id) references compatibility_options (id) on delete CASCADE,
  constraint compatibility_answers_profile_id_fkey foreign KEY (profile_id) references profiles (id) on delete CASCADE,
  constraint compatibility_answers_question_id_fkey foreign KEY (question_id) references compatibility_questions (id) on delete CASCADE
) TABLESPACE pg_default;

create trigger compatibility_answers_insert_question_id BEFORE INSERT on compatibility_answers for EACH row
execute FUNCTION compatibility_answer_add_question_id ();

create trigger compatibility_answers_update_vector
after INSERT
or DELETE
or
update on compatibility_answers for EACH row
execute FUNCTION compatibility_vectors_compute ();

create trigger compatibility_answer_insert_check BEFORE INSERT on compatibility_answers for EACH row
execute FUNCTION compatibility_answer_check ();