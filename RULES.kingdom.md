# 👑 Kingdom Law — Universal Rules for Every Session
**These rules bind EVERY agent in EVERY project. Read before any work.**

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
