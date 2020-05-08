#!/usr/bin/env bash

S3_BUCKET=$(wget -q -O - http://vault.in.okinta.ge:7020/api/kv/nuget_bucket)
if [ -z "$S3_BUCKET" ]; then
    echo "Could not obtain S3 bucket from Vault" >&2
    exit 1
fi
export S3_BUCKET

exec /usr/local/bin/entrypoint.sh "$@"