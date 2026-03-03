# fisshing-recipes

<img src="/whale-shark-og.gif" width="640px" />

<hr>

Ready-to-use integrations for [fisshing](https://fisshing.net) — the fishing game that lives in your terminal. The fisshing developer API lets you send notifications to your phone, activate a spinner while tasks run, and build stream overlays. This repo has copy-paste recipes for shells, CI, editors, cron jobs, and OBS.

## Setup

Get your API key from the [docs page](https://fisshing.net/docs), then export it:

```sh
export FISSHING_API_KEY="fsh_..."
```

## Recipes

| Recipe | File | Description |
|--------|------|-------------|
| Shell wrapper | [`shell/fsh.sh`](shell/fsh.sh) | Source-able `fsh` function — wraps any command with spinner + notification |
| Git post-commit | [`shell/post-commit.sh`](shell/post-commit.sh) | Notify on every git commit |
| Test runner | [`shell/run-tests.sh`](shell/run-tests.sh) | Wrap any test command (`./run-tests.sh npm test`) |
| Deploy | [`shell/deploy.sh`](shell/deploy.sh) | Spinner + pass/fail notification for deploys |
| Docker build | [`shell/docker-build.sh`](shell/docker-build.sh) | Spinner + notification for `docker build` |
| Pomodoro timer | [`shell/pomodoro.sh`](shell/pomodoro.sh) | 25-minute focus timer |
| Health check | [`shell/health-check.sh`](shell/health-check.sh) | Alert when an HTTP endpoint is down |
| Zsh slow notify | [`shell/zsh-slow-notify.zsh`](shell/zsh-slow-notify.zsh) | Auto-notify on commands that take 30+ seconds |
| GitHub Actions | [`ci/fisshing.yml`](ci/fisshing.yml) | CI workflow steps with spinner + result notification |
| Backup monitor | [`cron/backup-monitor.cron`](cron/backup-monitor.cron) | Crontab entry for backup pass/fail alerts |
| Claude Code | [`editors/claude-code.json`](editors/claude-code.json) | `.claude/settings.json` hooks (PostToolUse, PreToolUse, PermissionRequest, Stop) |
| Cursor IDE | [`editors/cursor.md`](editors/cursor.md) | Instructions + curl commands for Cursor |
| OpenCode | [`editors/opencode-plugin.js`](editors/opencode-plugin.js) | OpenCode JS plugin with spinner + notifications |
| OBS overlay | [`overlay/overlay.html`](overlay/overlay.html) | Self-contained browser source for streaming catch cards |

## API quick reference

**Send a notification:**

```sh
curl -X POST https://fisshing.net/api/notify \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"message": "Build passed!", "source": "my-script"}'
```

**Set spinner status:**

```sh
curl -X POST https://fisshing.net/api/status \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"active": true}'
```

Full API docs: [fisshing.net/docs](https://fisshing.net/docs)

## License

[MIT](LICENSE)
