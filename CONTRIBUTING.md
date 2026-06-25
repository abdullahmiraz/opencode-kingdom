# Contributing to OpenCode Kingdom

Welcome! The kingdom grows stronger with every contribution. Here's how to help.

## How Agents Are Organized

```
kingdom/
├── king/        # Royal agents — orchestrators, wisdom, high-level command
│                #   king-sisyphus.md    — always-running orchestrator
│                #   queen-metis.md      — wisdom, context, self-improvement
│                #   prince-of-memory.md — state, tasks, decisions
│                #   prince-of-code.md   — building, quality
│                #   prince-of-git.md    — commit discipline
├── knights/     # Sub-agent doers — specific skills
│                #   quality-gate.md, component-builder.md, etc.
├── opencode.kingdom.json  — Canonical agent config
└── RULES.kingdom.md       — Universal kingdom law
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

**Weak agents** (project-specific, no clear workflow, too short) stay in their project. They are **never promoted** to the kingdom.

## Need a New Royal Agent?

If you think the kingdom needs a new Prince/Prince/Queen:
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
