#!/bin/sh
set -e
if [ -n "$GSC_SERVICE_ACCOUNT_B64" ]; then
  echo "$GSC_SERVICE_ACCOUNT_B64" | base64 -d > /app/service_account_credentials.json
fi
exec uv run --no-sync python gsc_server.py
