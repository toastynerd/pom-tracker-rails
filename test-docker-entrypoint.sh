#!/bin/sh

set -e

echo "Environment: ${RAILS_ENV}"

rm -rf $APP_PATH/tmp/pids/server.pid

bundle exec ${@}
