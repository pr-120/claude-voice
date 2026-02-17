#!/bin/bash
# install.sh — Install claude-voice TTS hook
set -euo pipefail

VOICE_DIR="$HOME/.claude/hooks/voice"
SKILL_DIR="$HOME/.claude/skills/voice-toggle"
SETTINGS="$HOME/.claude/settings.json"

# Determine source directory (works whether run from repo checkout or piped from curl)
if [ -f "$(dirname "$0")/voice.sh" ]; then
  SRC_DIR="$(cd "$(dirname "$0")" && pwd)"
else
  # Downloaded via curl — fetch files to a temp dir
  SRC_DIR=$(mktemp -d)
  trap 'rm -rf "$SRC_DIR"' EXIT
  BASE_URL="https://raw.githubusercontent.com/dokuniev/claude-voice/main"
  echo "Downloading claude-voice..."
  curl -fsSL "$BASE_URL/voice.sh" -o "$SRC_DIR/voice.sh"
  curl -fsSL "$BASE_URL/config.json" -o "$SRC_DIR/config.json"
  mkdir -p "$SRC_DIR/skills/voice-toggle"
  curl -fsSL "$BASE_URL/skills/voice-toggle/SKILL.md" -o "$SRC_DIR/skills/voice-toggle/SKILL.md"
fi

# Install hook files
mkdir -p "$VOICE_DIR"
cp "$SRC_DIR/voice.sh" "$VOICE_DIR/voice.sh"
chmod +x "$VOICE_DIR/voice.sh"

# Only write config if it doesn't already exist (preserve user customizations)
if [ ! -f "$VOICE_DIR/config.json" ]; then
  cp "$SRC_DIR/config.json" "$VOICE_DIR/config.json"
else
  echo "Keeping existing config.json"
fi

# Install skill
mkdir -p "$SKILL_DIR"
cp "$SRC_DIR/skills/voice-toggle/SKILL.md" "$SKILL_DIR/SKILL.md"

# Patch settings.json — add voice hook to Stop and Notification events
/usr/bin/python3 -c "
import json, os

path = os.path.expanduser('$SETTINGS')
if os.path.exists(path):
    with open(path) as f:
        s = json.load(f)
else:
    s = {}

hooks = s.setdefault('hooks', {})
entry = {
    'type': 'command',
    'command': os.path.expanduser('~/.claude/hooks/voice/voice.sh'),
    'timeout': 10
}

for event in ['SessionStart', 'Stop', 'PostToolUseFailure', 'Notification']:
    groups = hooks.setdefault(event, [{'matcher': '', 'hooks': []}])
    hook_list = groups[0].setdefault('hooks', [])
    # Avoid duplicates
    if not any(h.get('command', '').endswith('voice/voice.sh') for h in hook_list):
        hook_list.append(entry)

with open(path, 'w') as f:
    json.dump(s, f, indent=2)
    f.write('\n')
"

echo ""
echo "claude-voice installed!"
echo "  Hook:   $VOICE_DIR/voice.sh"
echo "  Config: $VOICE_DIR/config.json"
echo "  Skill:  $SKILL_DIR/SKILL.md"
echo ""
echo "Test it:  say 'hello'"
echo "Toggle:   /voice-toggle (in Claude Code)"
echo "Config:   edit $VOICE_DIR/config.json"
