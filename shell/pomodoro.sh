#!/bin/sh
# pomodoro.sh — 25-minute focus timer with fisshing notifications
#
# Setup:
#   1. export FISSHING_API_KEY="fsh_..."
#   2. chmod +x pomodoro.sh
#
# Usage:
#   ./pomodoro.sh

curl -s -X POST https://fisshing.net/api/notify \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"message":"Focus session started","source":"pomodoro","alert_level":"info"}'
curl -s -X POST https://fisshing.net/api/status \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"active": true}' > /dev/null
sleep 1500
curl -s -X POST https://fisshing.net/api/notify \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"message":"Time is up! Take a break","source":"pomodoro","alert_level":"warning","dismiss_interval":30000}'
curl -s -X POST https://fisshing.net/api/status \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"active": false}' > /dev/null
