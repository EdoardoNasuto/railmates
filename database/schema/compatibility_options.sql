create table public.compatibility_options (
  id bigserial not null,
  question_id bigint not null,
  value numeric(3, 2) not null,
  label jsonb null,
  description jsonb null,
  constraint question_options_pkey primary key (id),
  constraint compatibility_options_question_id_fkey foreign KEY (question_id) references compatibility_questions (id) on delete CASCADE,
  constraint question_options_value_numeric_check check (
    (
      (value >= (0)::numeric)
      and (value <= (1)::numeric)
    )
  )
) TABLESPACE pg_default;