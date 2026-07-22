# Symlink this repo's Claude instruction files into %USERPROFILE%\.claude
# Falls back to a copy if Windows blocks symlink creation. Safe to re-run.
$ErrorActionPreference = 'Stop'

$RepoDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Dest = if ($env:CLAUDE_HOME) { $env:CLAUDE_HOME } else { Join-Path $env:USERPROFILE '.claude' }
$Backup = Join-Path $Dest (".config-backup-" + (Get-Date -Format 'yyyyMMdd-HHmmss'))

New-Item -ItemType Directory -Force -Path $Dest | Out-Null

function Install-File($src) {
  $name = Split-Path -Leaf $src
  $dst = Join-Path $Dest $name
  if (-not (Test-Path -LiteralPath $src)) { Write-Host "skip: $name missing from repo"; return }

  $item = Get-Item -LiteralPath $dst -Force -ErrorAction SilentlyContinue
  if ($item) {
    if ($item.LinkType -eq 'SymbolicLink' -and $item.Target -like "$RepoDir*") {
      Remove-Item -LiteralPath $dst -Force                              # our own link, replace it
    } else {
      New-Item -ItemType Directory -Force -Path $Backup | Out-Null      # a real pre-existing file
      Move-Item -LiteralPath $dst -Destination $Backup
      Write-Host "back: $name"
    }
  }

  try {
    New-Item -ItemType SymbolicLink -Path $dst -Target $src -ErrorAction Stop | Out-Null
    Write-Host "link: $name"
  } catch {
    Copy-Item -LiteralPath $src -Destination $dst -Force
    Write-Host "copy: $name (symlink not permitted; re-run after pulling updates)"
  }
}

# CLAUDE.md is the entry point; it @-loads the rest.
Install-File (Join-Path $RepoDir 'CLAUDE.md')

$instr = Join-Path $RepoDir 'instructions'
'PRINCIPLES.md','WORKFLOW.md',
'DESIGN-CRITERIA.md','CODING-CRITERIA.md','TESTING-CRITERIA.md','DOCUMENTATION-CRITERIA.md',
'COMMUNICATION.md','VOCABULARY.md','IOS.md' |
  ForEach-Object { Install-File (Join-Path $instr $_) }

Write-Host "done. dest=$Dest"
