create table public.compatibility (
  user_id uuid not null default auth.uid (),
  personality extensions.vector null,
  destination integer[] null,
  dates daterange null,
  days int4range null,
  mates int4range null,
  budget int4range null,
  constraint compatibility_vectors_pkey primary key (user_id),
  constraint compatibility_vectors_user_key unique (user_id),
  constraint compatibility_user_id_fkey foreign KEY (user_id) references profiles (id) on delete CASCADE
) TABLESPACE pg_default;

create index IF not exists compatibility_destination_idx on public.compatibility using gin (destination) TABLESPACE pg_default;