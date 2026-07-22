# claude-config

Portable Claude Code instruction files, shared across machines.

`~/.claude/` also holds machine state and secrets (settings, sessions, history, caches). Only the instruction `.md` files below belong in version control, so they are symlinked in from this repo rather than the whole directory being tracked.

## Contents

- `CLAUDE.md` loads the rest with `@` references
- Referenced files: principles, workflow, the four criteria docs, communication, vocabulary, iOS
- `install.sh` symlinks each file into `~/.claude/`
- The authoritative file list lives in `install.sh`

## Set up a new machine

```sh
git clone https://github.com/JimmyC41/claude-config.git ~/dotfiles/claude
~/dotfiles/claude/install.sh
```

`install.sh` backs up any existing `~/.claude/*.md` into `~/.claude/.config-backup-<timestamp>/` before linking. Safe to re-run.

## Sync an edit

Edit the file anywhere (both machines link to this repo, so edits land here), then:

```sh
cd ~/dotfiles/claude && git commit -am "update" && git push   # machine that changed it
cd ~/dotfiles/claude && git pull                              # every other machine
```

Symlinks pick up pulled changes with no reinstall.

## Override the target

`install.sh` links into `~/.claude` by default. Set `CLAUDE_HOME` to point elsewhere.
