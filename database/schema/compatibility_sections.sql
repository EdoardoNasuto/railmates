create table public.compatibility_sections (
  id bigserial not null,
  code text not null,
  label jsonb null,
  constraint question_groups_pkey primary key (id),
  constraint question_groups_code_key unique (code)
) TABLESPACE pg_default;