create table public.profiles (
  id uuid not null,
  first_name text null,
  last_name text null,
  avatar_url text null,
  birth_date date null,
  city bigint null,
  phone_number text null,
  constraint profiles_pkey primary key (id),
  constraint profiles_countries_fkey foreign KEY (city) references cities (id) on update CASCADE on delete set null,
  constraint profiles_id_fkey foreign KEY (id) references auth.users (id) on update CASCADE on delete CASCADE,
  constraint profiles_phone_number_check check ((phone_number ~ '^\+[1-9]\d{6,14}$'::text)),
  constraint username_length check ((char_length(first_name) >= 3))
) TABLESPACE pg_default;