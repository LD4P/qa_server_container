#!/bin/sh
set -e

db-wait.sh "$MYSQL_HOST:$MYSQL_PORT"

bundle exec rails db:migrate
bundle exec rails db:seed
