#!/bin/sh
# docker-build.sh — Docker build wrapper with spinner + fisshing notifications
#
# Setup:
#   1. export FISSHING_API_KEY="fsh_..."
#   2. chmod +x docker-build.sh
#
# Usage:
#   ./docker-build.sh myapp:latest

curl -s -X POST https://fisshing.net/api/status \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"active": true}' > /dev/null
docker build -t "$1" .
EXIT=$?
if [ $EXIT -eq 0 ]; then AL=success; MSG="Build done: $1"
else AL=error; MSG="Build failed: $1"; fi
curl -s -X POST https://fisshing.net/api/notify \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"message\":\"$MSG\",\"source\":\"docker\",\"alert_level\":\"$AL\"}"
curl -s -X POST https://fisshing.net/api/status \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"active": false}' > /dev/null
