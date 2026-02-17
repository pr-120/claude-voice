#!/bin/bash
# uninstall.sh — Remove claude-voice TTS hook
set -euo pipefail

VOICE_DIR="$HOME/.claude/hooks/voice"
SKILL_DIR="$HOME/.claude/skills/voice-toggle"
SETTINGS="$HOME/.claude/settings.json"

# Remove voice hook entries from settings.json
if [ -f "$SETTINGS" ]; then
  /usr/bin/python3 -c "
import json, os

path = os.path.expanduser('$SETTINGS')
with open(path) as f:
    s = json.load(f)

hooks = s.get('hooks', {})
for event in ['Stop', 'Notification']:
    groups = hooks.get(event, [])
    for group in groups:
        hook_list = group.get('hooks', [])
        group['hooks'] = [h for h in hook_list if not h.get('command', '').endswith('voice/voice.sh')]
    # Remove event entirely if no hooks remain
    if all(len(g.get('hooks', [])) == 0 for g in groups):
        del hooks[event]

with open(path, 'w') as f:
    json.dump(s, f, indent=2)
    f.write('\n')
"
  echo "Removed voice hooks from settings.json"
fi

# Remove files
rm -rf "$VOICE_DIR"
echo "Removed $VOICE_DIR"

rm -rf "$SKILL_DIR"
echo "Removed $SKILL_DIR"

echo ""
echo "claude-voice uninstalled."
