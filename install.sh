#!/usr/bin/env bash
# Symlink this repo's Claude instruction files into ~/.claude/
# Safe to re-run. Backs up a real file it would overwrite; silently re-points its own stale links.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$REPO_DIR/instructions"
DEST="${CLAUDE_HOME:-$HOME/.claude}"

FILES=(
  CLAUDE.md
  PRINCIPLES.md
  WORKFLOW.md
  DESIGN-CRITERIA.md
  CODING-CRITERIA.md
  TESTING-CRITERIA.md
  DOCUMENTATION-CRITERIA.md
  COMMUNICATION.md
  VOCABULARY.md
  IOS.md
)

mkdir -p "$DEST"
backup="$DEST/.config-backup-$(date +%Y%m%d-%H%M%S)"

for f in "${FILES[@]}"; do
  src="$SRC_DIR/$f"
  dst="$DEST/$f"

  [ -e "$src" ] || { echo "skip: $f missing from repo"; continue; }

  if [ -L "$dst" ]; then
    link="$(readlink "$dst")"
    [ "$link" = "$src" ] && { echo "ok:   $f"; continue; }
    case "$link" in
      "$REPO_DIR"/*) rm "$dst" ;;                                  # our own stale link
      *) mkdir -p "$backup"; mv "$dst" "$backup/"; echo "back: $f" ;;
    esac
  elif [ -e "$dst" ]; then
    mkdir -p "$backup"; mv "$dst" "$backup/"; echo "back: $f"      # a real pre-existing file
  fi

  ln -s "$src" "$dst"
  echo "link: $f"
done

echo "done. repo=$REPO_DIR dest=$DEST"
