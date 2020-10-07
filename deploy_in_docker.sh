#!/bin/bash
# build and deploy supergood.work. This script expects to execute in Docker container described by Dockerfile in this repo.
# See README.md and config.rb for more details

set -euo pipefail

working_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd ${working_dir}

echo "Bundle install"
bundle install --deployment

echo "Building site"
rm -rf build/
bundle exec middleman build

echo "S3 sync"
s3cmd \
  --quiet \
  --delete-removed \
  --guess-mime-type \
  --no-mime-magic \
  --acl-public \
  --recursive \
  sync "build/" "s3://supergood.work/"

echo "Invalidating CDN"
bundle exec middleman cdn

echo "Done"
