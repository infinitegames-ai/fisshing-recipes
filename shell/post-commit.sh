#!/bin/sh
# post-commit.sh — Git post-commit hook that sends a fisshing notification
#
# Setup:
#   1. export FISSHING_API_KEY="fsh_..."
#   2. Copy to your repo:
#      cp post-commit.sh /path/to/repo/.git/hooks/post-commit
#      chmod +x /path/to/repo/.git/hooks/post-commit
#
# Usage:
#   Runs automatically after every git commit.

MSG=$(git log -1 --pretty=%s | cut -c1-60)
curl -s -X POST https://fisshing.net/api/notify \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"message\":\"Committed: $MSG\",\"source\":\"git\"}"
