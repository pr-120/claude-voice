# 🗣️ claude-voice

**Speaks your git branch name when a Claude Code session finishes or needs approval.**

Running Claude Code on three branches at once? A notification dings but you don't know if it's `main`, `feature/auth-login`, or `fix/signup-bug`. claude-voice tells you — out loud.

## What you'll hear

| Event | What it says | So you know... |
|-------|-------------|----------------|
| ✅ Task completes | *"done, feature auth login"* | That branch is done |
| 🔐 Permission prompt | *"feature auth login, needs approval"* | That branch needs you |
| 🚀 Session start | *(nothing)* | — |

The branch name `feature/auth-login` is cleaned up for speech as "feature auth login". Not in a git repo? It falls back to the folder name.

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
    "stop": true,
    "permission": true
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
