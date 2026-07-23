# claude-config

Claude Code instruction files, symlinked into your Claude config dir (`~/.claude`) on each machine.

macOS / Linux:

    git clone https://github.com/JimmyC41/claude-config.git ~/dotfiles/claude
    ~/dotfiles/claude/install.sh

Windows (PowerShell):

    git clone https://github.com/JimmyC41/claude-config.git $HOME\dotfiles\claude
    powershell -ExecutionPolicy Bypass -File $HOME\dotfiles\claude\install.ps1

Each installer backs up any existing `.md` before linking and is safe to re-run.

## Updating

`git pull`. Symlinks make the pulled change live with no reinstall. To change the instructions, edit a file, commit, push.

Native Windows needs Developer Mode on for symlinks. Without it the installer copies instead, so there you must edit the repo files (not the `~/.claude` copies) and re-run `install.ps1` after every pull.
