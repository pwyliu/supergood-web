#!/bin/bash
# build and deploy supergood.work
# see README.md and config.rb for more details
echo "Engage..."
set -veuo pipefail

bundle install --deployment > /dev/null
rm -rf build/

bundle exec middleman build
bundle exec middleman s3_sync