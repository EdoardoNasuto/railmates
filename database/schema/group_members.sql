create table public.group_members (
  group_id uuid not null,
  user_id uuid not null,
  constraint group_members_pkey primary key (group_id, user_id),
  constraint group_members_user_id_key unique (user_id),
  constraint group_members_group_id_fkey foreign KEY (group_id) references groups (id) on delete CASCADE,
  constraint group_members_user_id_fkey foreign KEY (user_id) references compatibility (user_id) on delete CASCADE
) TABLESPACE pg_default;