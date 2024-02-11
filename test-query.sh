#!/bin/bash

KC_HOST=<>:8081
KC_REALM=OPA
KC_CLIENT_ID=backend
KC_CLIENT_SECRET="<>"
KC_URL=http://$KC_HOST/realms/$KC_REALM/protocol/openid-connect/token
KC_USERNAME=<>
KC_PASSWORD=<>
KC_SCOPE=openid
OPA_HOST=<>:8181
OPA_URL=http://$OPA_HOST/v1/data/rules

TOKEN=$(curl \
--silent \
--request POST \
--url $KC_URL \
--header "accept: application/json" \
--header "cache-control: no-cache" \
--header "content-type: application/x-www-form-urlencoded" \
--data "grant_type=password" \
--data "client_id=$KC_CLIENT_ID" \
--data "client_secret=$KC_CLIENT_SECRET" \
--data "scope=$KC_SCOPE" \
--data "username=$KC_USERNAME" \
--data "password=$KC_PASSWORD" | jq -r .access_token)

curl \
--silent \
--request POST \
--url $OPA_URL \
--data "{\"input\":{\"jwt\":\"$TOKEN\"}}"
