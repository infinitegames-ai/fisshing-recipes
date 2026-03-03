#!/bin/sh
# health-check.sh — HTTP endpoint monitor with fisshing alert on failure
#
# Setup:
#   1. export FISSHING_API_KEY="fsh_..."
#   2. chmod +x health-check.sh
#   3. Add to crontab: */5 * * * * /path/to/health-check.sh https://your-app.example.com/health
#
# Usage:
#   ./health-check.sh https://your-app.example.com/health

URL="${1:?Usage: $0 <url>}"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
if [ "$STATUS" != "200" ]; then
  curl -s -X POST https://fisshing.net/api/notify \
    -H "Authorization: Bearer $FISSHING_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"message\":\"$URL returned $STATUS\",\"source\":\"health\",\"alert_level\":\"error\",\"dismiss_interval\":15000}"
fi
