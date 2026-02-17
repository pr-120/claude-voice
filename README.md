# 🗣️ claude-voice

**Hear which Claude Code session needs you — without looking.**

When you're running multiple [Claude Code](https://claude.com/claude-code) sessions on different branches, it's hard to tell which one just finished or needs approval. claude-voice speaks the branch name out loud so you always know.

## What you'll hear

| Event | What it says |
|-------|-------------|
| ✅ Task completes | *"done, feature auth login"* |
| 🔐 Permission prompt | *"feature auth login, needs approval"* |
| 🚀 Session start | *(nothing — no need to interrupt you)* |

Branch names are cleaned up for natural speech — `feature/auth-login` becomes "feature auth login". Not in a git repo? It'll use the folder name instead.

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
