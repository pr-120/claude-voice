# 🗣️ Claude-Voice

**Speaks the repo and branch name when a Claude Code session finishes or needs approval.** 🍎 macOS only.

Running Claude Code on three branches at once? A notification dings but you don't know if it's `myapp/main`, `myapp/feature/auth-login`, or `api-server/fix/signup-bug`. Claude-Voice tells you — out loud.

## What you'll hear

| Event | What it says | So you know... |
|-------|-------------|----------------|
| ✅ Task completes | *"myapp, feature auth login"* | That session finished |
| 🔐 Permission prompt | *"myapp, feature auth login, needs approval"* | That session needs you |
| 💥 Tool failure | *"myapp, feature auth login, tool failed"* | Something broke |
| 🚀 Session start | *"let's go"*, *"showtime"*, *"let's cook"*, etc. | Session is ready |

Names are cleaned up for natural speech — `feature/auth-login` becomes "feature auth login". Not in a git repo? It falls back to the folder name.

**Multiple sessions on the same branch?** Claude-Voice auto-detects this and appends a session number — *"myapp, feature auth login, session 2"*. Only when needed.

You can also name sessions explicitly with an environment variable:

```bash
CLAUDE_VOICE_NAME="auth module" claude
CLAUDE_VOICE_NAME="signup flow" claude
```

Then you'll hear *"auth module"* and *"signup flow"* instead of the branch name.

## Getting started

```bash
curl -fsSL https://raw.githubusercontent.com/dokuniev/claude-voice/main/install.sh | bash
```

That's it! Next time a Claude Code session completes, you'll hear it. Requires macOS (uses the built-in `say` command).

## Toggling on/off

Voice is on by default. Mute it anytime:

- Type `/voice-toggle` inside Claude Code
- Or from the terminal: `bash ~/.claude/hooks/voice/voice.sh --toggle`

Also available: `--pause`, `--resume`, `--status`

## Configuration

Tweak `~/.claude/hooks/voice/config.json` to your liking:

```json
{
  "enabled": true,
  "voice": "Samantha",
  "rate": 200,
  "events": {
    "start": true,
    "stop": true,
    "permission": true,
    "failure": true
  }
}
```

- **voice** — pick any macOS voice (run `say -v '?'` to see them all)
- **rate** — words per minute (200 is snappy, 175 is more relaxed)
- **events** — turn individual announcements on/off

## Uninstall

```bash
bash ~/.claude/hooks/voice/uninstall.sh
```

Cleanly removes all files and hook entries from your settings.
