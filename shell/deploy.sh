#!/bin/sh
# deploy.sh — Deploy wrapper with spinner + fisshing notifications
#
# Setup:
#   1. export FISSHING_API_KEY="fsh_..."
#   2. chmod +x deploy.sh
#   3. Edit the deploy command below (fly deploy, kubectl apply, etc.)
#
# Usage:
#   ./deploy.sh

curl -s -X POST https://fisshing.net/api/status \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"active": true}' > /dev/null

fly deploy  # or: kubectl apply, docker push, etc.
EXIT=$?

if [ $EXIT -eq 0 ]; then AL=success; MSG="Deploy succeeded"
else AL=error; MSG="Deploy failed"; fi
curl -s -X POST https://fisshing.net/api/notify \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"message\":\"$MSG\",\"source\":\"deploy\",\"alert_level\":\"$AL\",\"dismiss_interval\":10000}"
curl -s -X POST https://fisshing.net/api/status \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"active": false}' > /dev/null
