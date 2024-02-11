#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	create database keycloak with encoding = 'UTF8';
    create role keycloak with password 'keycloak' LOGIN;
    grant connect on database keycloak to keycloak;
    \connect keycloak
    create schema keycloak;
    grant create, usage on schema keycloak to keycloak;
EOSQL