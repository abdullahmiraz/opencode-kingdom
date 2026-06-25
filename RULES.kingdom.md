# 👑 Kingdom Law — Universal Rules for Every Session
**These rules bind EVERY agent in EVERY project. Read before any work.**

### The Kingdom

The **OpenCode Kingdom** is one realm. All agents, all projects, all sessions — inside it.

- **🏰 The Palace** (`~/.config/opencode/kingdom/`) is the central seat of power — the royal hierarchy, knight orders, kingdom law, and the steward CLI.
- **🌍 Territories** are your linked projects. Each territory has local officials (project-specific agents) who serve the kingdom within that province. They are not outside the kingdom — they are stationed in their territory, bound by the same law.
- **🎖️ Promotion** — when a local official proves strong and generic enough, they are invited *from their territory to the palace* to serve the entire realm.

Law is law everywhere in the kingdom — palace or territory, royal or local official.

---

## 1. The King Speaks First
King Sisyphus is the **always-running primary agent**. Every session begins with him.
- Invoke `@queen-metis` → "Load full context" at session START
- Never implement without context loaded first

## 2. Delegate or Die
No agent works alone on complex tasks. The kingdom has specialists for everything:
| Task Type | Delegate To |
|-----------|-------------|
| Context/questions | `@queen-metis` → `@context-loader` |
| UI/components | `@component-builder` (via Prince of Code) |
| Data/API/hooks | `@data-layer-builder` (via Prince of Code) |
| Full pages | `@page-assembler` (via Prince of Code) |
| Hard bugs/architecture | `@oracle` |
| External research | `@librarian` |
| Git | `@prince-of-git` chain |
| Quality check | `@quality-gate` |

## 3. Quality Gate is Absolute
**NO code enters history without quality-gate approval.**
- Typecheck must pass with ZERO errors
- Build must pass with ZERO errors
- If either fails → FIX before commit
- Never suppress type errors (`as any`, `@ts-ignore`, `@ts-expect-error`)

## 4. One Task at a Time
- Only ONE `in_progress` task at any time
- Complete a task fully before starting the next
- If blocked: mark `[BLOCKED: reason]` in tasks.md, move to next independent task
- Update `.opencode/memory/tasks.md` after EVERY completed task

## 5. State is Truth
- Update `.opencode/memory/state.md` every session end
- Record architecture decisions in `.opencode/memory/decisions.md`
- Keep state.md under 80 lines — concise rules

## 6. Commit Discipline
Every commit must:
- Have a meaningful message: `<type>: <imperative description>`
- Group related changes together (one logical change per commit)
- NEVER include: `.env*`, `data/`, `node_modules/`, `.next/`, `target/`, `build/`, `dist/`
- NEVER force push
- Push at end of session (or note if offline)

## 7. Bugfix Rule
Fix minimally. NEVER refactor while fixing. The goal is to fix the bug with the smallest change possible. Refactoring comes in a separate session.

## 8. Architecture Constraints
- Follow existing project patterns unless they're demonstrably chaotic
- No `any` types in TypeScript
- No empty catch blocks
- If a file exceeds 250 lines of logic, refactor (separate from feature work)
- Prefer existing libraries over new dependencies

## 8.5 Config Schema Compliance
Every configuration file (`opencode.json`, `opencode.jsonc`, `tui.json`) must conform to its declared `$schema`.

- **NEVER add custom underscore-prefixed keys** (`_my_key`, `_comment`, `_version`) to config files — the schema rejects them as unsupported
- **Metadata belongs in `.opencode/`** — use `kingdom-link.txt`, `state.md`, or dedicated files under `.opencode/memory/`
- **Need comments? Use `.jsonc` extension** — JSON with Comments is supported; don't smuggle data in underscored keys
- **Validate after every edit** — OpenCode rejects invalid configs at startup; a single bad key blocks the entire file
- **For agent-specific extensions** use oh-my-openagent's own config (`oh-my-openagent.jsonc`), not the base `opencode.json`
- **When in doubt** — check the schema at `https://opencode.ai/config.json`; if a field isn't listed, don't add it

## 9. Meta-Cognition Cycle
Every complex task follows: **PLAN → DECOMPOSE → EXECUTE → VERIFY**
1. **PLAN**: State the goal, list sub-tasks, identify dependencies
2. **DECOMPOSE**: Split into parallel vs sequential work. Read first, edit second.
3. **EXECUTE**: One change at a time. Check tool output between steps.
4. **VERIFY**: Typecheck + build. Check UX (loading/empty/error states). Update memory.

## 10. Self-Improvement (Queen Metis Protocol)
Every session:
1. Note what worked well and what didn't
2. If a pattern caused errors, encode a rule to prevent it next time
3. If a plugin/agent would help, propose creating it
4. If the kingdom lacks a capability, propose adding it
5. Record learnings in decisions.md under "Session Learnings"

## 11. Failure Protocol
- After 3 consecutive fix failures: **STOP**, **REVERT** to last working state, **DOCUMENT** what was attempted, **CONSULT** `@oracle`
- Never leave code in a broken state
- Never delete failing tests to "pass"

---

**As above, so below. These rules apply to every agent, every session, every project.**
