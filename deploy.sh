#!/bin/bash
set -euo pipefail

docker build -t supergood-web:deployenv .

docker run \
    -it \
    --rm \
    --env AWS_ACCESS_KEY_ID \
    --env AWS_SECRET_ACCESS_KEY \
    --env AWS_SESSION_TOKEN \
    --env CLOUDFLARE_CLIENT_API_KEY \
    --env CLOUDFLARE_EMAIL \
    -v "$(pwd)":/app \
    supergood-web:deployenv /app/deploy_in_docker.sh
