# Contributing to OpenCode Kingdom

Welcome! The kingdom grows stronger with every contribution. Here's how to help.

## The Kingdom — Palace & Territories

All agents are part of the kingdom. The distinction is *where they serve*:

- **🏰 Palace** (`king/` + `knights/`) — the central hierarchy. Royal agents (King, Queen, Princes) and knight orders (sub-agent specialists). These serve every territory.
- **🌍 Territories** — your linked projects. Each territory has **local officials** — project-specific agents that serve the kingdom within that province. They are not outsiders; they are stationed in their territory doing kingdom work.
- **🎖️ Promotion** — when a local official proves strong and generic enough, they are invited *from their territory to the palace*.

## How Agents Are Organized

```
kingdom/                    # The entire kingdom
├── king/                   # Palace: royal agents — orchestrators, wisdom, high-level command
│   ├── king-sisyphus.md    # — always-running orchestrator
│   ├── queen-metis.md      # — wisdom, context, self-improvement
│   ├── prince-of-memory.md # — state, tasks, decisions
│   ├── prince-of-code.md   # — building, quality
│   └── prince-of-git.md    # — commit discipline
├── knights/                # Palace: sub-agent doers — specific skills
│   ├── quality-gate.md
│   ├── component-builder.md
│   └── ...
├── opencode.kingdom.json   # Canonical palace agent config
└── RULES.kingdom.md        # Universal kingdom law
```

## Adding a New Agent

1. **Write the agent** — keep it generic (no project-specific references)
2. **Check strength** — the agent should have:
   - Clear purpose ("I am..." or "My role is...")
   - Workflow ("When invoked...")
   - Rules or constraints
   - Output format
   - 15-100 lines (sweet spot)
3. **Promote it:**
   ```bash
   ./kingdom promote ./my-agent.md
   ```
   The CLI checks for quality. If it's weak or project-specific, it will warn you.
4. **Register in opencode.kingdom.json** — add the agent entry
5. **Update backup:**
   ```bash
   ./kingdom backup
   ```

## Agent Quality Standards

| Criteria | Minimum |
|----------|---------|
| Clear purpose statement | ✅ |
| Workflow or procedure | ✅ |
| Rules or constraints | ✅ |
| Output/response format | ✅ |
| Generic (no project refs) | ✅ |
| 15-100 lines | ✅ |

**Weak or territory-specific agents** remain in their province as local officials — still part of the kingdom, just stationed where they're needed. They may be invited to the palace **once they prove strong and generic enough** (score ≥ 4/8 via `./kingdom promote`).

## Need a New Royal Agent?

If you think the palace needs a new Prince/Prince/Queen:
1. Open an issue describing the gap
2. Propose the agent's role and hierarchy position
3. The community reviews and decides

## Reporting Issues

- **Bug**: Describe what happened, what you expected, and the kingdom version (`./kingdom version`)
- **Feature request**: Describe the capability gap and why it belongs in the kingdom
- **Agent improvement**: Suggest specific changes to an existing agent

## Code Style

- Bash scripts: `set -euo pipefail`, POSIX-compatible where possible
- Agent files: Markdown with YAML frontmatter
- Keep it simple — the kingdom is a collection of markdown files, not a framework

## First Time Setup

```bash
git clone https://github.com/YOUR_ORG/opencode-kingdom.git
cd opencode-kingdom
./kingdom backup
./kingdom init ~/projects/my-app
```

## License

MIT — do what you want, just don't blame us.
