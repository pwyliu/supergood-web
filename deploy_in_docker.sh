#!/bin/bash
# build and deploy supergood.work. This script expects to execute in Docker container described by Dockerfile in this repo.
# See README.md and config.rb for more details

set -euo pipefail

working_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${working_dir}

printf "\n** Running bundle install **\n"
bundle install --deployment >/dev/null 2>&1

printf "\n** Building site **\n"
rm -rf build/
bundle exec middleman build

# https://support.cloudflare.com/hc/en-us/articles/200172516
# https://support.cloudflare.com/hc/en-us/articles/202775670
printf "\n** S3 sync **\n"
s3cmd \
  --delete-removed \
  --guess-mime-type \
  --no-mime-magic \
  --acl-public \
  --recursive \
  --add-header="Cache-Control: public, max-age=31536000" \
  sync "build/" "s3://supergood.work/"

printf "\n** Invalidating CDN **\n"
bundle exec middleman cdn

printf "\n** Warm cache **\n"
wget \
  --recursive \
  --delete-after \
  --level 0 \
  --quiet \
  "https://supergood.work/"

printf "\n** Done **\n"
