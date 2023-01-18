#!/bin/sh
# Export the password so psql does not prompt for it.
export PGPASSWORD=$POSTGRESQL_PASSWORD
# Create tables if they do not exist

DATABASE=sampledb

echo "Provisioning database with demo data."
echo "Creating tables"

psql -h $POSTGRESQL_HOSTNAME -U $POSTGRESQL_USER -w -d $DATABASE --command \
  "CREATE TABLE IF NOT EXISTS \
    public.products(id integer, name varchar); \
    ALTER TABLE public.products OWNER TO \"$POSTGRESQL_USER\";"

psql -h $POSTGRESQL_HOSTNAME -U $POSTGRESQL_USER -w -d $DATABASE --command \
  "INSERT INTO public.products(id, name) VALUES (1, 'apple'); \
  INSERT INTO public.products(id, name) VALUES (2, 'orange'); \
  INSERT INTO public.products(id, name) VALUES (3, 'lemon'); "

