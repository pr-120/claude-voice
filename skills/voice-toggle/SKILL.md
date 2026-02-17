---
name: voice-toggle
description: Toggle voice TTS notifications on/off. Use when user wants to mute, unmute, pause, or resume voice announcements during a Claude Code session.
user_invocable: true
---

# voice-toggle

Toggle voice TTS announcements on or off.

Run the following command using the Bash tool:

```bash
bash ~/.claude/hooks/voice/voice.sh --toggle
```

Report the output to the user. The command will print either:
- `voice: paused` — voice announcements are now muted
- `voice: resumed` — voice announcements are now active
