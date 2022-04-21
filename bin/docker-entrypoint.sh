#!/usr/bin/env bash
# ! /bin/sh

echo '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
echo '-----------------------  RUNNING ENTRY POINT  -----------------------'
echo '====================================================================='
echo "Running qa_server_container image for version: $(< ../VERSION)"

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
