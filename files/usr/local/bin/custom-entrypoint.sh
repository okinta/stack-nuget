#!/usr/bin/env bash

S3_BUCKET_URL=$(curl -s http://vault.in.okinta.ge:7020/api/kv/nuget_bucket)
if [ -z "$S3_BUCKET_URL" ]; then
    echo "Could not obtain S3 bucket from Vault" >&2
    exit 1
fi
export S3_BUCKET_URL
S3_BUCKET=$(awk -F "." '{print $1}' <<< "$S3_BUCKET_URL")
export S3_BUCKET

AWS_ACCESS_KEY=$(curl -s http://vault.in.okinta.ge:7020/api/kv/aws_access_key)
if [ -z "$AWS_ACCESS_KEY" ]; then
    echo "Could not obtain AWS access key from Vault" >&2
    exit 1
fi
export AWS_ACCESS_KEY
AWS_SECRET_KEY=$(curl -s http://vault.in.okinta.ge:7020/api/kv/aws_secret_key)
if [ -z "$AWS_SECRET_KEY" ]; then
    echo "Could not obtain AWS secret key from Vault" >&2
    exit 1
fi
export AWS_SECRET_KEY

AUTH_KEY=$(curl -s http://vault.in.okinta.ge:7020/api/kv/nuget_auth_key)
if [ -z "$AUTH_KEY" ]; then
    echo "Could not obtain authorization key from Vault" >&2
    exit 1
fi
export AUTH_KEY

exec /usr/local/bin/entrypoint.sh "$@"
