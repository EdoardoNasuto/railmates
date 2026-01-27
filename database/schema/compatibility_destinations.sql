create table public.compatibility_destinations (
  profile_id uuid not null default auth.uid (),
  country_id bigint not null,
  constraint compatibility_destinations_pkey primary key (profile_id, country_id),
  constraint compatibility_destinations_country_id_fkey foreign KEY (country_id) references countries (id) on delete CASCADE,
  constraint compatibility_destinations_profile_id_fkey foreign KEY (profile_id) references profiles (id) on delete CASCADE
) TABLESPACE pg_default;

create trigger compatibility_destinations_vector
after INSERT on compatibility_destinations for EACH row
execute FUNCTION compatibility_destinations_update_vector ();