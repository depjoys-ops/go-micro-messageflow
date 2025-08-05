# psql -h 127.0.0.1 -p 5433 -U auth_role -d auth_db

DO
$$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'auth_role') THEN
        CREATE ROLE auth_role WITH LOGIN PASSWORD 'auth_password';
    END IF;
END
$$;

SELECT 'CREATE DATABASE auth_db OWNER auth_role'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'auth_db')\gexec

GRANT ALL PRIVILEGES ON DATABASE auth_db TO auth_role;
