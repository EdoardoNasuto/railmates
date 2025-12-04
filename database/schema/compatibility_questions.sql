create table public.compatibility_questions (
  id bigserial not null,
  code text not null,
  multi_select boolean not null,
  section_id bigint null,
  label jsonb null,
  constraint questions_pkey primary key (id),
  constraint questions_code_key unique (code),
  constraint questions_group_id_fkey foreign KEY (section_id) references compatibility_sections (id)
) TABLESPACE pg_default;