# claude-voice

TTS branch name announcements for [Claude Code](https://claude.com/claude-code) hooks. When running multiple sessions on different branches, hear *which* session needs your attention without switching to it.

## What it does

| Event | You hear |
|-------|----------|
| Task completes | "done, feature auth login" |
| Permission prompt | "feature auth login, needs approval" |
| Session start | *(nothing)* |

Branch names are sanitized for speech — `feature/auth-login` becomes "feature auth login".

Falls back to the folder name if you're not in a git repo.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/dokuniev/claude-voice/main/install.sh | bash
```

Requires macOS (uses the built-in `say` command).

## Uninstall

```bash
bash ~/.claude/hooks/voice/uninstall.sh
```

## Usage

Voice announcements are active by default. Toggle them during a session:

- `/voice-toggle` in Claude Code
- Or from the terminal: `bash ~/.claude/hooks/voice/voice.sh --toggle`

Other commands: `--pause`, `--resume`, `--status`

## Configuration

Edit `~/.claude/hooks/voice/config.json`:

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

- **voice** — any macOS voice (list available voices with `say -v '?'`)
- **rate** — words per minute
- **events** — toggle which events trigger speech
