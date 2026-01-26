create table public.compatibility (
  user_id uuid not null default auth.uid (),
  personality extensions.vector null,
  essential extensions.vector null,
  destination extensions.vector null,
  start_date date null,
  end_date date null,
  constraint compatibility_vectors_pkey primary key (user_id),
  constraint compatibility_vectors_user_key unique (user_id),
  constraint compatibility_user_id_fkey foreign KEY (user_id) references profiles (id) on delete CASCADE
) TABLESPACE pg_default;