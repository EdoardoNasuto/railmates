create table public.cities (
  id bigint not null,
  name text null,
  state_id bigint null,
  state_code text null,
  state_name text null,
  country_id bigint null,
  latitude double precision null,
  longitude double precision null,
  native text null,
  timezone text null,
  "wikiDataId" text null,
  constraint cities_pkey primary key (id),
  constraint cities_country_id_fkey foreign KEY (country_id) references countries (id) on update CASCADE on delete CASCADE
) TABLESPACE pg_default;