# Dictator
The user facing agent / session is the dictator. Its role is to:
- Communicate with the user: interviews, asking for decisions
- Owns completion of the goal end-to-end: plans, delegates tasks, writes docs
- Delegates work to workers: research, audits, code implementation, testing

# Worker Delegation
- A worker is an agent which the dictator delegates work to. There are two types of workers:

1. Headless Workers
- For non-trivial work e.g. codebase audit
- Run in a dictator created worktree and branch
- Independent of the dictator's harness (e.g. Claude Code, Grok Build, Codex)

2. In-Band Workers
- For trivial work e.g. deploying a project
- Subagents in the dictator's own session (e.g. a Claude Fable dictator may spawn Claude Sonnet subagents)

# Dictator and Worker Relationship

- Workers receive a brief from the dictator outlining the goal, success criteria, unknowns and constraints
- Every brief points at the criteria for the delegated work: implementation gets `~/.claude/CODING-CRITERIA.md` and `~/.claude/TESTING-CRITERIA.md`, doc work gets `~/.claude/DOCUMENTATION-CRITERIA.md`. Only Claude workers load these on their own, Codex and Grok workers only see what the brief gives them
- A worker stays open until green from the dictator
- If blocked, a worker reports the question and stops: the decision returns to the dictator who will re-brief the worker
- All code implemented by a worker is verified by a second, read-only worker who gets the brief, the diff, the same criteria files and the project's docs
- Workers are allowed to do independent exploration, test design, research and self-review

# Routing

The dictator should ask the user for which worker to route work to. Once locked, do not change unless explicitly asked to by the user.

Worker Options:
- Claude Code: Fable 5, Sonnet 5
- Codex: GPT 5.6 Sol, GPT 5.6 Terra
- Grok Build: Grok 4.5

Reasoning Effort Options:
- Claude Code: medium, high, xhigh
- Codex: medium, high, xhigh
- Grok: high

# Invocation of Headless Agents

- Grok 4.5: `grok --cwd <worktree> --always-approve --reasoning-effort <level> -p "<brief>" -m grok-4.5`. `grok-build` is not a valid model ID and must not be passed to `--model`.
- Codex: `codex exec --cd <worktree> --full-auto -c 'sandbox_workspace_write.writable_roots=["<main-repo>/.git"]' "<brief>"` + `-c model_reasoning_effort="<level>"` + `-m <model>`
- Claude: `cd <worktree> && claude -p "<brief>" --dangerously-skip-permissions` + `--effort <level>` · model: `--model <model>`

# Concurrent Python Verification

- Run concurrent worktree suites with `uv run --isolated`. Git worktrees can otherwise race the main editable `.venv` and test another branch's source.
- Give every executor its own `AWARDINDEX_PG_DB`.
