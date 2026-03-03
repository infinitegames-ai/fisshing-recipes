#!/bin/sh
# fsh.sh — Source-able wrapper that adds a spinner + notification to any command
#
# Setup:
#   1. export FISSHING_API_KEY="fsh_..."
#   2. Add to ~/.bashrc or ~/.zshrc:
#      source /path/to/fsh.sh
#
# Usage:
#   fsh make build
#   fsh npm install
#   fsh cargo test

fsh() {
  curl -s -X POST https://fisshing.net/api/status \
    -H "Authorization: Bearer $FISSHING_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{"active": true}' > /dev/null
  "$@"
  EXIT=$?
  if [ $EXIT -eq 0 ]; then AL=success; else AL=error; fi
  curl -s -X POST https://fisshing.net/api/notify \
    -H "Authorization: Bearer $FISSHING_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"message\":\"Done: $1\",\"source\":\"shell\",\"alert_level\":\"$AL\"}" > /dev/null
  curl -s -X POST https://fisshing.net/api/status \
    -H "Authorization: Bearer $FISSHING_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{"active": false}' > /dev/null
  return $EXIT
}
