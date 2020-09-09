#!/bin/sh
set -e

db-wait.sh "$DB_HOST:$DB_PORT"

bundle exec rails db:migrate
bundle exec rails db:seed
