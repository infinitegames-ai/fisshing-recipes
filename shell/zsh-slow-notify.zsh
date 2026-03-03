#!/bin/zsh
# zsh-slow-notify.zsh — Auto-notify on commands taking longer than 30 seconds
#
# Setup:
#   1. export FISSHING_API_KEY="fsh_..."
#   2. Add to ~/.zshrc:
#      source /path/to/zsh-slow-notify.zsh
#
# Usage:
#   Any command that takes 30+ seconds will trigger a fisshing notification
#   when it finishes. No manual wrapping needed.

__fsh_precmd() {
  local EXIT=$? ELAPSED=$(( SECONDS - ${_FSH_START:-$SECONDS} ))
  unset _FSH_START
  if [ $ELAPSED -ge 30 ]; then
    local AL=success; [ $EXIT -ne 0 ] && AL=error
    curl -s -X POST https://fisshing.net/api/notify \
      -H "Authorization: Bearer $FISSHING_API_KEY" \
      -H "Content-Type: application/json" \
      -d "{\"message\":\"Finished (${ELAPSED}s)\",\"source\":\"shell\",\"alert_level\":\"$AL\"}" > /dev/null &
  fi
}
__fsh_preexec() { _FSH_START=$SECONDS; }
autoload -Uz add-zsh-hook
add-zsh-hook precmd __fsh_precmd
add-zsh-hook preexec __fsh_preexec
