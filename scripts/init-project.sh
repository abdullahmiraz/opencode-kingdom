#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# 👑 init-project.sh — Bootstrap a New Project with Kingdom
# ============================================================
# Copies kingdom agents into a new project's .opencode/ directory
# and generates project-specific config with proper hierarchy.
#
# Usage:
#   bash scripts/init-project.sh \\
#     --name "my-project" \\
#     --desc "My awesome project" \\
#     --path "/path/to/project" \\
#     --typecheck "npx tsc --noEmit" \\
#     --build "npm run build" \\
#     --dev "npm run dev" \\
#     --context "Path/to/project-context.md"
#
# Minimal:
#   bash scripts/init-project.sh --name "myapp" --path .
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KINGDOM_DIR="$(dirname "$SCRIPT_DIR")"

# ─── Parse Arguments ───────────────────────────────────────
PROJECT_NAME=""
PROJECT_DESC="A project using OpenCode Kingdom"
PROJECT_PATH=""
TYPECHECK_CMD="npx tsc --noEmit"
BUILD_CMD="npm run build"
DEV_CMD="npm run dev"
CONTEXT_FILE=""
PROJECT_AGENTS=""  # comma-separated list of project-specific agent names

while [[ $# -gt 0 ]]; do
    case "$1" in
        --name) PROJECT_NAME="$2"; shift 2 ;;
        --desc) PROJECT_DESC="$2"; shift 2 ;;
        --path) PROJECT_PATH="$2"; shift 2 ;;
        --typecheck) TYPECHECK_CMD="$2"; shift 2 ;;
        --build) BUILD_CMD="$2"; shift 2 ;;
        --dev) DEV_CMD="$2"; shift 2 ;;
        --context) CONTEXT_FILE="$2"; shift 2 ;;
        --project-agents) PROJECT_AGENTS="$2"; shift 2 ;;
        *) echo "❌ Unknown option: $1"; exit 1 ;;
    esac
done

if [ -z "$PROJECT_NAME" ]; then
    echo "❌ ERROR: --name is required"
    echo "Usage: bash scripts/init-project.sh --name \"myapp\" --path /path/to/project"
    exit 1
fi

if [ -z "$PROJECT_PATH" ]; then
    PROJECT_PATH="."
fi

# Resolve absolute path
PROJECT_PATH="$(cd "$PROJECT_PATH" 2>/dev/null && pwd || echo "$PROJECT_PATH")"

echo "👑 Initializing Kingdom Project"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Project:  $PROJECT_NAME"
echo "Path:     $PROJECT_PATH"
echo "Kingdom:  $KINGDOM_DIR"
echo ""

# ─── Create .opencode directory ───────────────────────────
OPENCODE_DIR="$PROJECT_PATH/.opencode"
mkdir -p "$OPENCODE_DIR/agents"
mkdir -p "$OPENCODE_DIR/memory"
mkdir -p "$OPENCODE_DIR/kingdom"  # Stores kingdom version reference

# ─── Link Kingdom Version ──────────────────────────────────
DATE_TAG=$(date +%Y-%m-%d)
cat > "$OPENCODE_DIR/kingdom/kingdom-link.txt" << EOL
KINGDOM_VERSION: 1.0.0
LINKED_DATE: $DATE_TAG
KINGDOM_PATH: $KINGDOM_DIR
REGENERATE_CMD: bash $KINGDOM_DIR/scripts/regenerate.sh
SYNC_CMD: bash $KINGDOM_DIR/scripts/sync-down.sh
EOL
echo "   ✅ Kingdom link created"

# ─── Copy Royal Agents ─────────────────────────────────────
if [ -d "$KINGDOM_DIR/king" ]; then
    cp -r "$KINGDOM_DIR/king/"* "$OPENCODE_DIR/agents/"
    echo "   ✅ Royal agents copied (king/)"
else
    echo "   ⚠️  No royal agents found at $KINGDOM_DIR/king"
fi

# ─── Copy Knight Agents ────────────────────────────────────
if [ -d "$KINGDOM_DIR/knights" ]; then
    cp -r "$KINGDOM_DIR/knights/"* "$OPENCODE_DIR/agents/"
    echo "   ✅ Knight agents copied (knights/)"
else
    echo "   ⚠️  No knight agents found at $KINGDOM_DIR/knights"
fi

# ─── Copy RULES.md ─────────────────────────────────────────
if [ -f "$KINGDOM_DIR/RULES.kingdom.md" ]; then
    cp "$KINGDOM_DIR/RULES.kingdom.md" "$OPENCODE_DIR/RULES.md"
    echo "   ✅ RULES.md copied"
fi

# ─── Generate opencode.json ────────────────────────────────
# Start with kingdom base agents, add project-specific agents on top
OPENCODE_JSON="$PROJECT_PATH/opencode.json"

# Build project-specific agent entries
PROJECT_AGENTS_JSON=""
if [ -n "$PROJECT_AGENTS" ]; then
    IFS=',' read -ra AGENTS <<< "$PROJECT_AGENTS"
    for AGENT in "${AGENTS[@]}"; do
        AGENT_NAME=$(echo "$AGENT" | xargs)  # trim
        AGENT_FILE="$OPENCODE_DIR/agents/${AGENT_NAME}.md"
        if [ -f "$AGENT_FILE" ]; then
            # Extract description from frontmatter
            DESC=$(head -20 "$AGENT_FILE" | grep "^description:" | sed 's/description: "\(.*\)"/\1/' 2>/dev/null || echo "Project-specific agent")
            MODE=$(head -20 "$AGENT_FILE" | grep "^mode:" | sed 's/mode: \(.*\)/\1/' 2>/dev/null || echo "subagent")
            
            PROJECT_AGENTS_JSON="$PROJECT_AGENTS_JSON
    \"$AGENT_NAME\": {
      \"description\": \"$DESC\",
      \"mode\": \"$MODE\",
      \"prompt\": \"Read .opencode/agents/$AGENT_NAME.md for your instructions. Report to king-sisyphus.\"
    },"
        else
            echo "   ⚠️  Agent file not found: $AGENT_NAME.md — adding as generic subagent"
            PROJECT_AGENTS_JSON="$PROJECT_AGENTS_JSON
    \"$AGENT_NAME\": {
      \"description\": \"Project-specific agent for $PROJECT_NAME\",
      \"mode\": \"subagent\",
      \"prompt\": \"Read .opencode/agents/$AGENT_NAME.md for your instructions. Report to king-sisyphus.\"
    },"
        fi
    done
fi

# Build context file entry
CONTEXT_PROMPT_LINE=""
if [ -n "$CONTEXT_FILE" ]; then
    CONTEXT_PROMPT_LINE="Read AGENTS.md and .opencode/agents/$CONTEXT_FILE for project-specific context. "
fi

cat > "$OPENCODE_JSON" << EOL
{
  "\$schema": "https://opencode.ai/config.json",
  "_kingdom_version": "1.0.0",
  "_generated": "$DATE_TAG",
  "_generated_by": "opencode-kingdom/scripts/init-project.sh",
  "plugin": [
    "oh-my-openagent",
    "@capybearista/opencode-adversarial-review@latest",
    "@capybearista/opencode-agents-loader@latest",
    "@capybearista/opencode-agent-prompt-inheritance@latest"
  ],
  "instructions": [".opencode/RULES.md"],
  "agent": {
    "king-sisyphus": {
      "description": "👑 KING: Always-running supreme orchestrator. Delegates to royal council.",
      "mode": "primary",
      "prompt": "Read .opencode/RULES.md and .opencode/agents/king-sisyphus.md. I am King Sisyphus. I always run, I never work alone. ${CONTEXT_PROMPT_LINE}Invoke @queen-metis for context, @prince-of-memory for state, @prince-of-code for building, @prince-of-git for commits."
    },
    "queen-metis": {
      "description": "👸 QUEEN METIS: Wisdom, context, self-improvement.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/queen-metis.md. I am Queen Metis. ${CONTEXT_PROMPT_LINE}I load context via @context-loader, validate via @context-checker. Read-first, speak-second."
    },
    "prince-of-memory": {
      "description": "🫅 PRINCE OF MEMORY: State, tasks, decisions.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/prince-of-memory.md. I manage @task-tracker and @state-writer."
    },
    "prince-of-code": {
      "description": "🫅 PRINCE OF CODE: Building, quality.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/prince-of-code.md. I delegate to @component-builder, @data-layer-builder, @page-assembler, @quality-gate."
    },
    "prince-of-git": {
      "description": "🫅 PRINCE OF GIT: Commit discipline.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/prince-of-git.md. I orchestrate @git-manager → @change-inspector → @quality-gate → @commit-executor."
    },
    "context-loader": {
      "description": "Reads memory files into structured summaries.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/context-loader.md. I serve @queen-metis. Read-only."
    },
    "context-checker": {
      "description": "Validates user journeys after changes.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/context-checker.md. I serve @queen-metis. Read-only."
    },
    "task-tracker": {
      "description": "Manages todo list.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/task-tracker.md. I serve @prince-of-memory."
    },
    "state-writer": {
      "description": "Updates state.md and decisions.md.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/state-writer.md. I serve @prince-of-memory."
    },
    "component-builder": {
      "description": "Creates/modifies UI components.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/component-builder.md. I serve @prince-of-code."
    },
    "data-layer-builder": {
      "description": "Creates/modifies data layer.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/data-layer-builder.md. I serve @prince-of-code."
    },
    "page-assembler": {
      "description": "Assembles full pages.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/page-assembler.md. I serve @prince-of-code."
    },
    "quality-gate": {
      "description": "Typecheck + build verification.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/quality-gate.md. I serve @prince-of-code. NEVER approve if checks fail."
    },
    "git-manager": {
      "description": "Orchestrates git workflow.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/git-manager.md. I serve @prince-of-git."
    },
    "change-inspector": {
      "description": "Analyzes and categorizes changes.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/change-inspector.md. I serve @prince-of-git."
    },
    "commit-executor": {
      "description": "Formats and executes commits.",
      "mode": "subagent",
      "prompt": "Read .opencode/agents/commit-executor.md. I serve @prince-of-git."
    }$PROJECT_AGENTS_JSON
  }
}
EOL
echo "   ✅ opencode.json generated with kingdom agents + project-specific agents"

# ─── Create Initial Memory Files ───────────────────────────
if [ ! -f "$OPENCODE_DIR/memory/state.md" ]; then
    cat > "$OPENCODE_DIR/memory/state.md" << EOL
# $PROJECT_NAME — Project State
**Last Updated:** $DATE_TAG
**Initialized by:** OpenCode Kingdom

## Build Status
- Typecheck: ⏳ Not yet run
- Build: ⏳ Not yet run

## Current Focus
- Initial setup
EOL
    echo "   ✅ memory/state.md created"
fi

if [ ! -f "$OPENCODE_DIR/memory/tasks.md" ]; then
    cat > "$OPENCODE_DIR/memory/tasks.md" << EOL
# Tasks — $PROJECT_NAME

## Current Sprint
- [ ] [P0] Initial project setup — verify everything works

## Completed
*(none yet)*
EOL
    echo "   ✅ memory/tasks.md created"
fi

if [ ! -f "$OPENCODE_DIR/memory/decisions.md" ]; then
    cat > "$OPENCODE_DIR/memory/decisions.md" << EOL
# Architecture Decisions — $PROJECT_NAME

## ADR-1: OpenCode Kingdom Integration
**Date:** $DATE_TAG
**Context:** Project initialized using OpenCode Kingdom.
**Decision:** Using kingdom agents for orchestration, project-specific agents for domain logic.
**Status:** Accepted
EOL
    echo "   ✅ memory/decisions.md created"
fi

# ─── Copy King Context File if provided ────────────────────
if [ -n "$CONTEXT_FILE" ] && [ -f "$CONTEXT_FILE" ]; then
    cp "$CONTEXT_FILE" "$OPENCODE_DIR/agents/${PROJECT_NAME}-context.md"
    echo "   ✅ Project context file copied"
fi

echo ""
echo "✅ Kingdom project initialized successfully!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Project: $PROJECT_NAME"
echo "Path:    $PROJECT_PATH"
echo ""
echo "📋 Next Steps:"
echo "   1. Edit opencode.json — add any project-specific agents"
echo "   2. Edit .opencode/memory/state.md — fill in your project details"
echo "   3. Edit .opencode/agents/${PROJECT_NAME}-context.md — tech stack, routes, patterns"
echo "   4. Start your first session!"
echo ""
echo "🔄 To sync kingdom updates later:"
echo "   bash $KINGDOM_DIR/scripts/sync-down.sh --path \"$PROJECT_PATH\""
