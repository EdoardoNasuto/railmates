create table public.compatibility (
  user_id uuid not null default auth.uid (),
  personality extensions.vector null,
  essential extensions.vector null,
  destination integer[] null,
  start_date date null,
  end_date date null,
  min_days smallint null,
  max_days smallint null,
  constraint compatibility_vectors_pkey primary key (user_id),
  constraint compatibility_vectors_user_key unique (user_id),
  constraint compatibility_user_id_fkey foreign KEY (user_id) references profiles (id) on delete CASCADE,
  constraint compatibility_consistency_check check (
    (
      (end_date >= start_date)
      and (min_days <= max_days)
      and (((end_date - start_date) + 1) >= max_days)
    )
  )
) TABLESPACE pg_default;

create index IF not exists compatibility_essential_start_date_end_date_idx on public.compatibility using btree (essential, start_date, end_date) TABLESPACE pg_default;

create index IF not exists compatibility_destination_idx on public.compatibility using gin (destination) TABLESPACE pg_default;