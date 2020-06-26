#!/usr/bin/env bash

S3_BUCKET=$(curl -s http://vault.in.okinta.ge:7020/api/kv/nuget_bucket)
if [ -z "$S3_BUCKET" ]; then
    echo "Could not obtain S3 bucket from Vault" >&2
    exit 1
fi
export S3_BUCKET

AUTH_KEY=$(curl -s http://vault.in.okinta.ge:7020/api/kv/nuget_auth_key)
if [ -z "$AUTH_KEY" ]; then
    echo "Could not obtain authorization key from Vault" >&2
    exit 1
fi
export AUTH_KEY

exec /usr/local/bin/entrypoint.sh "$@"
