#!/usr/bin/env bash
# Symlink this repo's Claude instruction files into ~/.claude/
# Safe to re-run. Backs up a real file it would overwrite; silently re-points its own stale links.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${CLAUDE_HOME:-$HOME/.claude}"
backup="$DEST/.config-backup-$(date +%Y%m%d-%H%M%S)"

mkdir -p "$DEST"

link() {
  src="$1"
  name="$(basename "$src")"
  dst="$DEST/$name"

  [ -e "$src" ] || { echo "skip: $name missing from repo"; return; }

  if [ -L "$dst" ]; then
    cur="$(readlink "$dst")"
    [ "$cur" = "$src" ] && { echo "ok:   $name"; return; }
    case "$cur" in
      "$REPO_DIR"/*) rm "$dst" ;;                                # our own stale link
      *) mkdir -p "$backup"; mv "$dst" "$backup/"; echo "back: $name" ;;
    esac
  elif [ -e "$dst" ]; then
    mkdir -p "$backup"; mv "$dst" "$backup/"; echo "back: $name" # a real pre-existing file
  fi

  ln -s "$src" "$dst"
  echo "link: $name"
}

# CLAUDE.md is the entry point; it @-loads the rest.
link "$REPO_DIR/CLAUDE.md"

for f in \
  PRINCIPLES.md WORKFLOW.md \
  DESIGN-CRITERIA.md CODING-CRITERIA.md TESTING-CRITERIA.md DOCUMENTATION-CRITERIA.md \
  COMMUNICATION.md VOCABULARY.md IOS.md
do
  link "$REPO_DIR/instructions/$f"
done

echo "done. dest=$DEST"
