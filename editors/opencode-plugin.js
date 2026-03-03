// opencode-plugin.js — OpenCode plugin for fisshing notifications
//
// Setup:
//   1. export FISSHING_API_KEY="fsh_..."
//   2. Register this plugin with OpenCode
//
// Features:
//   - Activates spinner on tool execution
//   - Sends "Agent stopped" on session idle
//   - Sends "Attention required" on permission prompts

const API = "https://fisshing.net/api";
const TOKEN = process.env.FISSHING_API_KEY;
const headers = {
  Authorization: `Bearer ${TOKEN}`,
  "Content-Type": "application/json",
};

async function notify(message) {
  await fetch(`${API}/notify`, {
    method: "POST",
    headers,
    body: JSON.stringify({ message, source: "OpenCode" }),
  }).catch(() => {});
}

async function setStatus(active) {
  await fetch(`${API}/status`, {
    method: "POST",
    headers,
    body: JSON.stringify({ active }),
  }).catch(() => {});
}

export const Fisshing = async () => ({
  "tool.execute.before": async () => {
    await setStatus(true);
  },
  event: async ({ event }) => {
    if (event.type === "session.idle") {
      await notify("Agent stopped");
      await setStatus(false);
    }
    if (event.type === "permission.asked") {
      await notify("Attention required");
    }
  },
});
