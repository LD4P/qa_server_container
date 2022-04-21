#!/usr/bin/env bash
# ! /bin/sh

echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo '-----------------------  RUNNING ENTRY POINT  -----------------------'
echo '====================================================================='
echo "Running qa_server_container image for version: "
echo "    2021-04-02 39411ba08e97f3b7133db7d9143af255d49e5bea"

set -e

# Wait for DB services
sh ./bin/db-wait.sh

# Prepare DB (Migrate if exists; else Create db & Migrate)
sh ./bin/db-prepare.sh

# Pre-compile app assets
# sh ./bin/asset-pre-compile.sh

# For development check if the gems as installed. If not, install them.
# sh ./bin/bundle-gems.sh

# Remove a potentially pre-existing server.pid for Rails
# rm -f /app/tmp/pids/server.pid

# Run the command defined in docker-compose.yml
exec "$@"
