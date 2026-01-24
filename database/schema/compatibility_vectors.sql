create table public.compatibility_availability (
  user_id uuid not null default auth.uid (),
  start date not null,
  "end" date not null,
  constraint compatibility_availability_pkey primary key (user_id),
  constraint compatibility_availability_user_id_fkey foreign KEY (user_id) references profiles (id) on delete CASCADE
) TABLESPACE pg_default;