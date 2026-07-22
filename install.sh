#!/usr/bin/env bash
# Symlink this repo's Claude instruction files into ~/.claude/
# Safe to re-run. Backs up anything real it would overwrite.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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
  src="$REPO_DIR/$f"
  dst="$DEST/$f"

  [ -e "$src" ] || { echo "skip: $f missing from repo"; continue; }

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "ok:   $f"
    continue
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$backup"
    mv "$dst" "$backup/"
    echo "back: $f -> ${backup##*/}/"
  fi

  ln -s "$src" "$dst"
  echo "link: $f"
done

echo "done. repo=$REPO_DIR dest=$DEST"
