# 👑 OpenCode Kingdom

A canonical, reusable agent hierarchy — the **Palace** at the center, **Territories** (your projects) bound by common law.

The kingdom is one realm. There is no "inside vs outside." Every agent, every project, every rule — all part of the same kingdom.

---

## 🏰 The Kingdom

```
OPENCODE KINGDOM (~/.config/opencode/kingdom/)
│
├── 🏰 PALACE (central seat of power)
│   ├── 👑 King Sisyphus       — always-running orchestrator
│   ├── 👸 Queen Metis         — wisdom, context, self-improvement
│   ├── 🫅 Prince of Memory    — state, tasks, decisions
│   ├── 🫅 Prince of Code      — building, quality enforcement
│   ├── 🫅 Prince of Git       — commit discipline, history
│   └── 🛡️ 10 Knight Orders    — sub-agent specialists
│
│   Palace files:
│   ├── king/                  — royal agent definitions
│   ├── knights/               — knight agent definitions
│   ├── opencode.kingdom.json  — canonical agent registry
│   └── RULES.kingdom.md       — universal kingdom law
│
├── 🌍 TERRITORIES (linked projects)
│   ├── RxPro                  — first province of the kingdom
│   ├── project-b              — next province
│   └── ...
│
├── 🗡️ KINGDOM STEWARD (./kingdom CLI)
│   ├── init                   — establish a new territory
│   ├── link                   — swear a project to the kingdom
│   ├── sync                   — spread palace updates to territories
│   ├── promote                — invite a local official to the palace
│   ├── backup / restore       — preserve & regenerate
│   └── status                 — survey the realm
│
└── 📦 backup/                 — palace mirror (instant regeneration)
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

## Territories (Linked Projects)

Every project under the kingdom is a **territory**. It has:
- **Local officials** — project-specific agents (`rxpro-manager`, `rxpro-builder`, etc.) that serve the kingdom within that province
- **Kingdom law** — `RULES.md` derived from `RULES.kingdom.md` with territory-specific additions
- **Oath of fealty** — `kingdom-link.txt` in `.opencode/kingdom/`

Local officials are **not excluded from the kingdom**. They are stationed in their territory doing kingdom work — the same as knights stationed in a castle town. When a local official proves strong and generic enough, they can be **promoted to the palace** to serve the entire realm.

## Quick Start

```bash
# Establish a new territory
./kingdom init ~/projects/my-app

# Link an existing project
./kingdom link .

# After updating palace agents, spread to all territories
./kingdom sync

# If the palace is destroyed, regenerate instantly
./kingdom restore

# Invite a strong local official to the palace
./kingdom promote ./territory-agent.md

# Survey the realm
./kingdom status
```

## Principles

1. **One kingdom** — there is no "generic vs project-specific" in the exclusionary sense. Every agent is part of the kingdom. Palace agents serve the realm. Territory officials serve their province. All serve the kingdom.
2. **Instant regeneration** — `backup/` mirrors the palace. If destroyed, one command restores it.
3. **Never duplicated** — territory agents are synced from the palace, never manually copied.
4. **Self-improving** — strong territory officials can be promoted to the palace.
5. **Common law, local rule** — `RULES.kingdom.md` is universal. Territories add their own constraints without contradicting the law.

## License

MIT
