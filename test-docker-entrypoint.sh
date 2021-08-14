#!/bin/sh

set -e

echo "Environment: ${RAILS_ENV}"

bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:create db:migrate

bundle exec ${@}
