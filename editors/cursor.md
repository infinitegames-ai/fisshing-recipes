# Cursor IDE — fisshing integration

## Setup

1. Get your API key from [fisshing.net/docs](https://fisshing.net/docs)
2. Set the environment variable:
   ```sh
   export FISSHING_API_KEY="fsh_..."
   ```
3. Add the curl commands below to your `.cursor/rules` or task config.

## Send a notification when a task completes

```sh
curl -s -X POST https://fisshing.net/api/notify \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"message": "Task complete!", "source": "Cursor"}'
```

## Activate the spinner while working

```sh
curl -s -X POST https://fisshing.net/api/status \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"active": true}'
```

## Deactivate the spinner when done

```sh
curl -s -X POST https://fisshing.net/api/status \
  -H "Authorization: Bearer $FISSHING_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"active": false}'
```
