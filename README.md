# 👑 OpenCode Kingdom

A **single source of truth** for OpenCode agents — reusable across every project in your portfolio.

## Architecture

```
kingdom/
├── king/           # Royal agents (King, Queen, Princes)
├── knights/        # Sub-agent knights (doers)
├── backup/         # Auto-mirrored clone for regeneration
├── projects/       # Lightweight project registrations
├── scripts/        # Bash scripts for kingdom operations
├── opencode.kingdom.json  # Canonical agent config
└── RULES.kingdom.md       # Universal kingdom law
```

## The Royal Hierarchy

```
👑 KING SISYPHUS (always running orchestrator)
 ├── 👸 QUEEN METIS (wisdom, context, self-improvement)
 │    ├── context-loader
 │    └── context-checker
 ├── 🫅 PRINCE OF MEMORY (state, tasks, decisions)
 │    ├── task-tracker
 │    └── state-writer
 ├── 🫅 PRINCE OF CODE (building, quality)
 │    ├── component-builder
 │    ├── data-layer-builder
 │    ├── page-assembler
 │    └── quality-gate
 └── 🫅 PRINCE OF GIT (commit discipline)
      ├── git-manager
      ├── change-inspector
      └── commit-executor
```

## Quick Start

```bash
# Initialize a new project with the kingdom
bash scripts/init-project.sh \
  --name "my-project" \
  --path /path/to/my-project

# After updating kingdom agents, sync to all projects
bash scripts/sync-down.sh

# If kingdom is destroyed, regenerate from backup instantly
bash scripts/regenerate.sh

# After every kingdom change, update backup
bash scripts/sync-backup.sh

# Promote a good project-specific agent to the kingdom
bash scripts/promote-agent.sh \
  --name "my-agent" \
  --role knights \
  --from /path/to/project/.opencode/agents/my-agent.md
```

## Principles

1. **Only the strong survive** — agents must be generic and proven to join the kingdom. Weak/project-specific agents stay in their project.
2. **Instant regeneration** — `backup/` is a clone. If the kingdom is destroyed, one command restores it.
3. **Never duplicated** — project agents are generated from the kingdom, not manually copied.
4. **Self-improving** — new agents born in projects can be promoted to the kingdom via `promote-agent.sh`.
