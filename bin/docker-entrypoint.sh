#!/usr/bin/env bash
# ! /bin/sh

echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo '-----------------------  RUNNING ENTRY POINT  -----------------------'
echo '====================================================================='

set -e

if [ "$WAIT_FOR_POSTGRES" == "true" ]; then
  echo -n Waiting for postgres to start...
  while ! pg_isready -h ${POSTGRES_HOST:-localhost} > /dev/null; do
    sleep 0.5; echo -n .; done
  echo done
fi

if [ "$PREPARE_DATABASE" == "true" ]; then
  bundle exec rake db:create db:migrate
fi

# For development check if the gems as installed. If not, install them.
if ! [ bundle check ];  then
  gem install bundler:2.1.4
  bundle install
fi

# Remove a potentially pre-existing server.pid for Rails
rm -f /app/tmp/pids/server.pid

# Run the command defined in docker-compose.yml
exec "$@"
