# 👑 OpenCode Kingdom — Architecture & Flow Visualization

> *"One realm. Palace at the center. Territories bound by common law."*

---

## 1. The Realm — Organizational Overview

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                           👑 OPENCODE KINGDOM                                │
│                     ~/.config/opencode/kingdom/                              │
│                                                                              │
│  ┌────────────────────────────────────────┐   ┌──────────────────────────┐   │
│  │         🏰  PALACE (Central Seat)       │   │  🌍  TERRITORIES         │   │
│  │                                        │   │                          │   │
│  │  ┌──────┐  ┌──────┐  ┌──────┐         │   │  ┌────────────────────┐  │   │
│  │  │ KING │  │QUEEN │  │PRINCE│  ...     │   │  │ 📁 RxPro            │  │   │
│  │  │SISY- │  │ METIS│  │ OF   │         │   │  │  ┌──────────────┐   │   │
│  │  │PHUS  │  │      │  │MEMORY│         │   │  │  │rxpro-manager  │   │   │
│  │  └──────┘  └──────┘  └──────┘         │   │  │  │rxpro-builder  │   │   │
│  │      │         │          │            │   │  │  │RxPro-context  │   │   │
│  │      ▼         ▼          ▼            │   │  │  └──────────────┘   │   │
│  │  ┌──────────────────────────────┐      │   │  │                     │   │
│  │  │        10 KNIGHT ORDERS       │      │   │  │  Kingdom Law:       │   │
│  │  │  ┌────┐ ┌────┐ ┌────┐       │      │   │  │  RULES.md           │   │
│  │  │  │CMP │ │DAL │ │PAGE│  ...  │      │   │  │  Oath: kingdom-     │   │
│  │  │  │BLDR│ │BLDR│ │ASM │       │      │   │  │  link.txt           │   │
│  │  │  └────┘ └────┘ └────┘       │      │   │  └────────────────────┘  │   │
│  │  └──────────────────────────────┘      │   │                          │   │
│  │                                        │   │  ┌────────────────────┐  │   │
│  │  Files:                                │   │  │ 📁 Project B        │  │   │
│  │  ├── king/          (5 royals)         │   │  │  (next territory)   │  │   │
│  │  ├── knights/       (11 knights)       │   │  └────────────────────┘  │   │
│  │  ├── opencode.kingdom.json             │   │                          │   │
│  │  ├── RULES.kingdom.md                  │   └──────────────────────────┘   │
│  │  └── backup/       (instant restore)   │                                │
│  └────────────────────────────────────────┘                                │
│                                                                              │
│  ┌──────────────────────────────────────────────────────────────────┐       │
│  │           🗡️  KINGDOM STEWARD  (./kingdom CLI)                    │       │
│  │  init │ link │ sync │ promote │ backup │ restore │ status        │       │
│  └──────────────────────────────────────────────────────────────────┘       │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Agent Hierarchy — Who Reports to Whom

```
┌─────────────────────────────────────────────────────────────────────────┐
│  👑 KING SISYPHUS                                                       │
│  mode: primary  │  always running  │  never works alone                 │
│  delegates EVERYTHING to royal council                                  │
└─────────────────────────────────────────────────────────────────────────┘
     │                        │                       │              │
     ▼                        ▼                       ▼              ▼
┌──────────────┐   ┌──────────────────┐   ┌──────────────────┐   ┌──────────────┐
│ 👸 QUEEN     │   │ 🫅 PRINCE OF     │   │ 🫅 PRINCE OF     │   │ 🫅 PRINCE    │
│    METIS     │   │    MEMORY        │   │    CODE           │   │    OF GIT    │
│              │   │                  │   │                  │   │              │
│ wisdom       │   │ state tracking   │   │ building         │   │ commit       │
│ context      │   │ task management  │   │ quality          │   │ discipline   │
│ self-improve │   │ decisions        │   │ enforcement      │   │ history      │
└──────┬───────┘   └────────┬─────────┘   └────────┬─────────┘   └──────┬───────┘
       │                    │                       │                   │
       ▼                    ▼                       ▼                   ▼
  ┌─────────┐         ┌──────────┐           ┌──────────┐         ┌──────────┐
  │context  │         │ task-    │           │component │         │ git-     │
  │-loader  │         │ tracker  │           │-builder  │         │ manager  │
  └─────────┘         └──────────┘           └──────────┘         └──────────┘
       │                                       │                       │
       ▼                                       ▼                       ▼
  ┌─────────┐                           ┌──────────┐           ┌──────────────┐
  │context  │                           │ data-    │           │ change-      │
  │-checker │                           │ layer-   │           │ inspector    │
  └─────────┘                           │ builder  │           └──────────────┘
                                         └──────────┘                 │
                                            │                         ▼
                                            ▼                  ┌──────────────┐
                                       ┌──────────┐           │ commit-      │
                                       │ page-    │           │ executor     │
                                       │ assembler│           └──────────────┘
                                       └──────────┘
                                            │
                                            ▼
                                       ┌──────────┐
                                       │ quality-  │
                                       │ gate      │
                                       └──────────┘
                                          🛡️
                                   BLOCKS COMMITS
                                   IF TSC OR BUILD
                                         FAILS
```

### Summonable Beings (Outside the Hierarchy)

```
┌────────────┐   ┌────────────┐   ┌────────────┐   ┌────────────┐
│  🦉 ORACLE │   │ 📚 LIBRARIAN│   │ 🔍 EXPLORE │   │ ⚙️  SKILLS  │
│            │   │            │   │            │   │            │
│ deep       │   │ external   │   │ codebase   │   │ domain-    │
│ debugging  │   │ research   │   │ grep &     │   │ specific   │
│ arch       │   │ OSS        │   │ pattern    │   │ workflows  │
│ decisions  │   │ patterns   │   │ discovery  │   │ (30+ cmd)  │
└────────────┘   └────────────┘   └────────────┘   └────────────┘
```

---

## 3. Territory in Practice — RxPro as a Living Example

```
🌍  TERRITORY: RxPro  (D:\code\PORTFOLIO_BUSINESS\projects\rxpro)
│
├── 👑 SWORN TO KINGDOM via kingdom-link.txt
├── 📜 BOUND BY RULES.md (derived from RULES.kingdom.md + local additions)
│
├── 🏛️  LOCAL OFFICIALS (territory-specific agents)
│   ├── rxpro-manager      — project state, task tracking
│   ├── rxpro-builder      — code generation, building
│   └── RxPro-context      — domain knowledge (prescriptions, patients)
│
├── ⚔️  ROYAL AGENTS (synced from palace, same code)
│   ├── king-sisyphus.md   ─┐
│   ├── queen-metis.md      │
│   ├── prince-of-*.md      ├── same as opencode.kingdom.json
│   ├── component-builder   │
│   └── all 11 knights     ─┘
│
├── 📦 TECH STACK
│   ├── Next.js 16 (App Router)    ─── routing + SSR
│   ├── shadcn/ui 4.11 + Tailwind  ─── UI components
│   ├── better-sqlite3             ─── local database
│   ├── TanStack Query v5          ─── data fetching
│   ├── react-hook-form + yup      ─── forms
│   └── next-client-cookies        ─── auth
│
└── 🔗 PLUGIN CHAIN
    ├── oh-my-openagent            ─── agent orchestration
    ├── adversarial-review         ─── code critique
    ├── agents-loader              ─── dynamic agent loading
    └── agent-prompt-inheritance   ─── prompt composition
```

### RxPro Data Flow

```
USER BROWSER
    │
    ▼
┌──────────────────────────────────────────────────────────────────────┐
│  REACT CLIENT (Client Component)                                     │
│                                                                      │
│  src/api/api.ts                                                      │
│  ┌──────────────────────────────────────────────┐                    │
│  │ function callApi(action, params) {            │                    │
│  │   return fetch('/api/data', {                 │                    │
│  │     method: 'POST',                           │                    │
│  │     body: JSON.stringify({ action, ...params })│                   │
│  │   }).then(r => r.json())                      │                    │
│  │ }                                              │                    │
│  └──────────────────────────────────────────────┘                    │
│                                                                      │
│  TanStack Query Hooks (src/hooks/)                                   │
│  ┌──────────────────────────────────────────────┐                    │
│  │ useQuery({ queryKey, queryFn })               │                    │
│  │ useMutation({ mutationFn, onSuccess })         │                    │
│  │                                                │                    │
│  │ Hooks: usePatients, useAppointments,           │                    │
│  │ usePrescriptions, useSetup, useDoctorInfo      │                    │
│  └──────────────────────────────────────────────┘                    │
└──────────────────────────┬───────────────────────────────────────────┘
                           │  POST /api/data
                           ▼
┌──────────────────────────────────────────────────────────────────────┐
│  API ROUTE (src/app/api/data/route.ts)                              │
│                                                                      │
│  POST handler dispatches to DAL via action name:                    │
│  ┌────────────────────────────────────────────────────┐              │
│  │ switch (action) {                                   │              │
│  │   'fetchPatients'   → fetchPatients(doctorId)       │              │
│  │   'createAppointment' → createAppointment(data)     │              │
│  │   'fetchPrescriptions' → fetchPrescriptions(doctorId)│             │
│  │   ... 44 actions total                              │              │
│  │ }                                                   │              │
│  └────────────────────────────────────────────────────┘              │
└──────────────────────────┬───────────────────────────────────────────┘
                           │  function call
                           ▼
┌──────────────────────────────────────────────────────────────────────┐
│  DATA ACCESS LAYER (src/lib/dal.ts)                                 │
│                                                                      │
│  44 typed CRUD functions:                                           │
│  ┌────────────────────────────────────────────────────┐              │
│  │ fetchPatients(doctorId) → rows(prepare(...).all()) │              │
│  │ createPatient(data)      → prepare(...).run(data)  │              │
│  │ updatePatient(id, data)  → prepare(...).run(data)  │              │
│  │ deletePatient(id)        → prepare(...).run(id)    │              │
│  │ ... 40 more functions                              │              │
│  └────────────────────────────────────────────────────┘              │
└──────────────────────────┬───────────────────────────────────────────┘
                           │  SQL queries
                           ▼
┌──────────────────────────────────────────────────────────────────────┐
│  DATABASE (src/lib/database.ts)                                     │
│                                                                      │
│  better-sqlite3 — 10 tables:                                        │
│  ┌────────────────────────────────────────────────────┐              │
│  │ rx_doctors                                        │              │
│  │ rx_doctor_info     ← seed data                     │              │
│  │ rx_patients        ← 5 seed rows                   │              │
│  │ rx_appointments    ← 5 seed rows                   │              │
│  │ rx_prescriptions                                  │              │
│  │ rx_setups          ← 3 seed rows                   │              │
│  │ rx_favorite_setups ← 2 seed rows                   │              │
│  │ rx_favorite_medicines ← 5 seed rows                │              │
│  │ rx_instructions    ← 4 seed rows                   │              │
│  │ rx_route_types     ← 5 seed rows                   │              │
│  └────────────────────────────────────────────────────┘              │
│                                                                      │
│  File: data/rxpro.db (auto-created on first access)                 │
└──────────────────────────────────────────────────────────────────────┘
```

---

## 4. Session Flow — How a Request Travels Through the Kingdom

```
USER: "Add a new feature to RxPro"
  │
  ├── 1. 👑 KING SISYPHUS receives request
  │      │
  │      ├── 🔍 Intent Gate: Is this research / implementation / fix?
  │      │   → Implementation → continues
  │      │
  │      └── 📖 Queen Metis → Context Load
  │           │
  │           ├── @context-loader reads: state.md + tasks.md + decisions.md
  │           └── Returns structured brief to King
  │
  ├── 2. 👑 KING: DECOMPOSE
  │      │
  │      ├── Break into atomic sub-tasks
  │      ├── Identify dependencies
  │      └── Delegate each task to right agent
  │
  ├── 3. 🫅 PRINCE OF CODE receives build tasks
  │      │
  │      ├── 👷 @component-builder → UI changes
  │      ├── 👷 @data-layer-builder → DAL + API + hooks
  │      └── 👷 @page-assembler → combine into pages
  │
  ├── 4. 🛡️ @quality-gate runs
  │      │
  │      ├── npx tsc --noEmit  →  0 errors?
  │      └── npm run build     →  0 errors?
  │           │
  │           ├── YES → proceed
  │           └── NO  → BLOCKED. Fix and retry.
  │
  ├── 5. 👸 QUEEN METIS → @context-checker
  │      │
  │      └── Validates: no user journeys broken
  │
  ├── 6. 🫅 PRINCE OF GIT receives commit request
  │      │
  │      ├── 🔍 @change-inspector → categorizes changes
  │      ├── 🛡️ @quality-gate → final check
  │      └── ✍️ @commit-executor → git add + commit + push
  │
  └── 7. 🫅 PRINCE OF MEMORY updates records
         │
         ├── 📝 @state-writer → updates state.md
         └── 📝 @task-tracker → updates tasks.md
```

---

## 5. Tool & MCP Server Chain

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         MCP SERVERS (connected)                             │
├─────────────────────┬─────────────────────┬─────────────────┬───────────────┤
│  🎭 PLAYWRIGHT      │  📚 CONTEXT7        │  🔍 WEB SEARCH   │  🧠 CLAUDE   │
│                     │                     │  (Exa)           │     MEM      │
│  Browser automation │  Library docs       │                  │              │
│  Page navigation    │  API references     │  Web search      │  Cross-      │
│  Screenshots        │  Framework docs     │  Company lookup  │  session     │
│  Console inspection │  Version migration  │  News            │  memory      │
│  Form interaction   │  Best practices     │  People search   │  Knowledge   │
│                     │                     │                  │  corpora     │
└─────────────────────┴─────────────────────┴──────────────────┴──────────────┘
         │                      │                    │                │
         ▼                      ▼                    ▼                ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                         COMMANDED BY AGENTS                                 │
│                                                                             │
│  explore  →  codebase grep, pattern discovery (via task subagent)          │
│  oracle   →  deep reasoning, architecture (via task subagent)              │
│  librarian → external research OSS patterns (via task subagent)            │
│  skills   →  domain-specific workflows (loaded on-demand)                  │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 6. Skill Ecosystem — When Each Domain Expert Activates

```
SKILL NAME              TRIGGER WHEN USER SAYS / DOES
──────────────────────  ─────────────────────────────────────────────────
nextjs-developer        Next.js App Router, SSR, middleware, layouts
react-expert            React components, hooks, state management
typescript-pro          Advanced types, generics, conditional types
cloudflare              Workers, Pages, KV, D1, R2, AI
durable-objects         Stateful coordination, WebSockets, alarms
workers-best-practices  Worker code review, anti-patterns
wrangler                wrangler CLI commands
turnstile-spin          CAPTCHA, bot protection
architecture-designer   System design, ADRs, tradeoff analysis
web-perf                Lighthouse, Core Web Vitals, bundle size
code-reviewer           PR review, code quality audit
meta-cognition          PLAN→DECOMPOSE→EXECUTE→VERIFY (project skill)
self-review             Quality checklist (project skill)
playwright              Browser testing, web scraping
frontend                UI/UX design, styling, visual work
git-master              All git operations
debugging               Runtime debugging, hypothesis-driven
security-review         Vulnerability audit, exploitability
```

---

## 7. Development Workflow — Day-to-Day Operations

```
                         DAILY CADENCE
                              │
                              ▼
                    ┌─────────────────────┐
                    │  START SESSION       │
                    │                     │
                    │  1. Context Load    │
                    │  2. Review state    │
                    │  3. Check tasks     │
                    └─────────┬───────────┘
                              │
                              ▼
                    ┌─────────────────────┐
                    │  WORK CYCLE          │
                    │                     │
                    │  ┌───────────────┐   │
                    │  │ Pick task     │   │
                    │  └───────┬───────┘   │
                    │          ▼           │
                    │  ┌───────────────┐   │
                    │  │ Decompose     │   │
                    │  └───────┬───────┘   │
                    │          ▼           │
                    │  ┌───────────────┐   │
                    │  │ Delegate      │   │
                    │  └───────┬───────┘   │
                    │          ▼           │
                    │  ┌───────────────┐   │
                    │  │ Verify (tsc   │   │
                    │  │ + build)      │   │
                    │  └───────────────┘   │
                    │          │           │
                    │          ▼           │
                    │  ┌───────────────┐   │
                    │  │ Update memory │   │
                    │  └───────────────┘   │
                    └─────────┬───────────┘
                              │
                              ▼
                    ┌─────────────────────┐
                    │  END SESSION         │
                    │                     │
                    │  1. Commit + push   │
                    │  2. Update state    │
                    │  3. Record learn-   │
                    │     ings            │
                    │  4. Kingdom backup  │
                    └─────────────────────┘
```

---

## 8. The Plugin Stack — What Extends the Kingdom

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  PLUGIN                       ROLE                                          │
├─────────────────────────────────────────────────────────────────────────────┤
│  oh-my-openagent @latest     Core orchestration — agent spawning,           │
│                               task management, session continuity           │
│                                                                             │
│  @capybearista/              Adversarial code review — challenges           │
│  opencode-adversarial-review implementation, finds edge cases               │
│                                                                             │
│  @capybearista/              Dynamic agent loading — loads agents           │
│  opencode-agents-loader      from kingdom/templates on demand               │
│                                                                             │
│  @capybearista/              Prompt inheritance — territory agents          │
│  opencode-agent-prompt-      inherit palace context automatically           │
│  inheritance                                                               │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 9. The Steward CLI — Kingdom Tooling

```
./kingdom
  │
  ├── init <project>       Establish a new territory
  │                        → copies palace agents → creates RULES.md
  │                        → writes kingdom-link.txt
  │
  ├── link .               Swear current project to the kingdom
  │                        → validates palace exists
  │                        → creates .opencode/kingdom/kingdom-link.txt
  │
  ├── sync                 Spread palace updates to all territories
  │                        → copies king/ + knights/ to each territory
  │                        → updates opencode.json in each
  │
  ├── promote <agent.md>   Invite a local official to the palace
  │                        → copies from territory to palace knights/
  │                        → registers in opencode.kingdom.json
  │
  ├── backup               Mirror palace to backup/ directory
  │                        → instant regeneration point
  │
  ├── restore              Regenerate palace from backup/
  │                        → one command, full recovery
  │
  └── status               Survey the realm
                           → lists palace agents
                           → lists linked territories
                           → checks backup health
```

---

## 10. Legend — Symbols Used

```
👑  KING       — primary agent, always running
👸  QUEEN      — wisdom, context, learning
🫅  PRINCE     — domain commander, delegates to knights
🛡️  KNIGHT     — specialist executor
🦉  ORACLE     — deep reasoning consultant
📚  LIBRARIAN  — external research specialist
🔍  EXPLORE    — codebase search specialist
⚙️  SKILL      — domain-specific workflow (loaded on demand)
🏰  PALACE     — central kingdom seat (~/.config/opencode/kingdom/)
🌍  TERRITORY  — linked project (e.g. RxPro)
🗡️  STEWARD    — kingdom CLI tool
📜  RULES      — universal law (RULES.kingdom.md)
🛡️  QUALITY    — typecheck + build gate (blocks commits on failure)
```

---

*This document is part of the OpenCode Kingdom. The kingdom is one realm — palace and territories are one.*
