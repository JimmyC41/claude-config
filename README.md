# claude-config

Claude Code instruction files, symlinked into your Claude config dir (`~/.claude`) on each machine.

macOS / Linux:

    git clone https://github.com/JimmyC41/claude-config.git ~/dotfiles/claude
    ~/dotfiles/claude/install.sh

Windows (PowerShell):

    git clone https://github.com/JimmyC41/claude-config.git $HOME\dotfiles\claude
    powershell -ExecutionPolicy Bypass -File $HOME\dotfiles\claude\install.ps1

Each installer backs up any existing `.md` before linking and is safe to re-run. If Windows blocks symlink creation it copies instead, so re-run it after pulling updates.
