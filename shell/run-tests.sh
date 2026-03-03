#!/bin/sh
# run-tests.sh — Test runner wrapper with fisshing notifications
#
# Setup:
#   1. export FISSHING_API_KEY="fsh_..."
#   2. chmod +x run-tests.sh
#
# Usage:
#   ./run-tests.sh mix test
#   ./run-tests.sh npm test
#   ./run-tests.sh pytest
#   ./run-tests.sh cargo test

CMD="${@:-mix test}"
OUTPUT=$(eval "$CMD" 2>&1)
EXIT=$?
if [ $EXIT -eq 0 ]; then
  AL=success; MSG="Tests passed"
else
  AL=error; MSG="Tests failed"
fi
curl -s -X POST https://fisshing.net/api/notify \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"message\":\"$MSG\",\"source\":\"tests\",\"alert_level\":\"$AL\"}"
echo "$OUTPUT"
