# Contributing to Claude-Voice

Thanks for your interest! Claude-Voice is a small project and contributions are welcome.

## Setup

1. Fork and clone the repo
2. The main script is `voice.sh` — that's where most of the logic lives
3. Test locally by copying files to `~/.claude/hooks/voice/`

## Testing

There's no test suite — just manual testing:

```bash
# Test TTS works
say "test"

# Test the script directly (simulate a Stop event)
echo '{"hook_event_name":"Stop","cwd":"/path/to/your/repo","session_id":"test-123","permission_mode":"default"}' | bash voice.sh

# Test toggle
bash voice.sh --toggle
bash voice.sh --status
```

## Pull requests

- Keep changes small and focused
- Test on macOS before submitting
- Update the README if you add or change a feature

## Ideas for contributions

Check the [issues](https://github.com/dokuniev/claude-voice/issues) for things to work on, or open a new issue to discuss your idea before building it.

## Questions?

Open an issue — happy to help.
