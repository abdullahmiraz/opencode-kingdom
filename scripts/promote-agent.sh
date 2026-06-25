#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# 👑 promote-agent.sh — Promote a Project Agent to the Kingdom
# ============================================================
# When you create a new agent during a project session that could
# be useful across multiple projects, this script promotes it
# to the kingdom. The agent gets reviewed for strength before promotion.
#
# Usage:
#   bash scripts/promote-agent.sh \\
#     --name "agent-name" \\
#     --role "king|knights" \\
#     --from "/path/to/project/.opencode/agents/agent-name.md"
#
# Example:
#   bash scripts/promote-agent.sh \\
#     --name "api-tester" \\
#     --role knights \\
#     --from "../my-project/.opencode/agents/api-tester.md"
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KINGDOM_DIR="$(dirname "$SCRIPT_DIR")"

AGENT_NAME=""
AGENT_ROLE=""
SOURCE_PATH=""
FORCE=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --name) AGENT_NAME="$2"; shift 2 ;;
        --role) AGENT_ROLE="$2"; shift 2 ;;
        --from) SOURCE_PATH="$2"; shift 2 ;;
        --force) FORCE=true; shift ;;
        *) echo "❌ Unknown option: $1"; exit 1 ;;
    esac
done

# ─── Validation ────────────────────────────────────────────

if [ -z "$AGENT_NAME" ] || [ -z "$SOURCE_PATH" ]; then
    echo "❌ ERROR: --name and --from are required"
    echo "Usage: bash scripts/promote-agent.sh --name \"agent-name\" --role knights --from /path/to/agent.md"
    exit 1
fi

if [ -z "$AGENT_ROLE" ]; then
    echo "🔍 Auto-detecting role..."
    # Check if agent has "king" or "knight" naming pattern or reports-to
    if grep -qi "reports to.*@prince\|serves @prince\|sub-agent of @prince" "$SOURCE_PATH" 2>/dev/null; then
        AGENT_ROLE="knights"
    elif grep -qi "sub-agent of @queen\|serves @queen" "$SOURCE_PATH" 2>/dev/null; then
        AGENT_ROLE="knights"
    elif grep -qi "always running\|always-run\|never stop" "$SOURCE_PATH" 2>/dev/null; then
        AGENT_ROLE="king"
    else
        echo "   Could not auto-detect. Defaulting to knights (sub-agent)."
        AGENT_ROLE="knights"
    fi
    echo "   Detected role: $AGENT_ROLE"
fi

if [ ! -f "$SOURCE_PATH" ]; then
    echo "❌ ERROR: Source file not found: $SOURCE_PATH"
    exit 1
fi

if [ "$AGENT_ROLE" != "king" ] && [ "$AGENT_ROLE" != "knights" ]; then
    echo "❌ ERROR: Role must be 'king' or 'knights'"
    exit 1
fi

# ─── Quality Check ─────────────────────────────────────────
echo ""
echo "👑 Agent Promotion Review"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Agent:  $AGENT_NAME"
echo "Role:   $AGENT_ROLE"
echo "Source: $SOURCE_PATH"
echo ""

# Read source file
CONTENT=$(cat "$SOURCE_PATH")
AGENT_LINES=$(echo "$CONTENT" | wc -l)

echo "📏 Size: $AGENT_LINES lines"

# Strength checks
STRENGTH_SCORE=0
STRENGTH_NOTES=""

echo "🔍 Running strength checks..."

# Check 1: Has clear purpose
if echo "$CONTENT" | grep -qi "I am\|I'm\|role\|purpose\|responsibilit"; then
    STRENGTH_SCORE=$((STRENGTH_SCORE + 2))
    echo "   ✅ Clear purpose defined"
else
    STRENGTH_NOTES="$STRENGTH_NOTES\n   ⚠️  No clear purpose statement"
fi

# Check 2: Has workflow/section
if echo "$CONTENT" | grep -qi "workflow\|flow\|how to\|steps\|when invoked\|procedure"; then
    STRENGTH_SCORE=$((STRENGTH_SCORE + 2))
    echo "   ✅ Workflow defined"
else
    STRENGTH_NOTES="$STRENGTH_NOTES\n   ⚠️  No workflow section"
fi

# Check 3: Has rules/sections
if echo "$CONTENT" | grep -qi "^##.*rule\|^##.*constraint\|^##.*important\|rule:\|- Never\|- Always\|- Only"; then
    STRENGTH_SCORE=$((STRENGTH_SCORE + 2))
    echo "   ✅ Rules/constraints defined"
else
    STRENGTH_NOTES="$STRENGTH_NOTES\n   ⚠️  No rules section"
fi

# Check 4: Is generic (not project-specific)
if echo "$CONTENT" | grep -qi "rxpro\|{{project_name}}\|{{PROJECT_NAME}}\|this project specifically\|this repository only"; then
    STRENGTH_SCORE=$((STRENGTH_SCORE - 2))
    STRENGTH_NOTES="$STRENGTH_NOTES\n   ⚠️  Contains project-specific references — may not be generic enough"
fi

# Check 5: Has outputs/examples
if echo "$CONTENT" | grep -qi "output\|example\|format\|template\|report format"; then
    STRENGTH_SCORE=$((STRENGTH_SCORE + 1))
    echo "   ✅ Output format defined"
fi

# Check 6: Reasonable length
if [ "$AGENT_LINES" -ge 15 ] && [ "$AGENT_LINES" -le 100 ]; then
    STRENGTH_SCORE=$((STRENGTH_SCORE + 1))
    echo "   ✅ Good length ($AGENT_LINES lines)"
elif [ "$AGENT_LINES" -lt 15 ]; then
    STRENGTH_NOTES="$STRENGTH_NOTES\n   ⚠️  Very short ($AGENT_LINES lines) — may lack detail"
fi

echo ""
echo "📊 Strength Score: $STRENGTH_SCORE/10"

if [ -n "$STRENGTH_NOTES" ]; then
    echo -e "📝 Notes:$STRENGTH_NOTES"
fi

# ─── Decision ──────────────────────────────────────────────

echo ""
if [ "$STRENGTH_SCORE" -lt 5 ] && ! $FORCE; then
    echo "⛔ This agent scored $STRENGTH_SCORE/10 — below the kingdom threshold (5)."
    echo "   It may be too weak, too project-specific, or too incomplete."
    echo ""
    echo "   Options:"
    echo "   1. Improve the agent and try again"
    echo "   2. Use --force to promote anyway"
    echo ""
    echo "❌ Promotion cancelled."
    exit 1
fi

if [ -f "$KINGDOM_DIR/$AGENT_ROLE/$AGENT_NAME.md" ] && ! $FORCE; then
    echo "⚠️  An agent named '$AGENT_NAME' already exists in $AGENT_ROLE/."
    echo "   Use --force to overwrite."
    echo "❌ Promotion cancelled."
    exit 1
fi

# ─── Promote! ──────────────────────────────────────────────

DEST_PATH="$KINGDOM_DIR/$AGENT_ROLE/$AGENT_NAME.md"
cp "$SOURCE_PATH" "$DEST_PATH"

echo "✅ Agent promoted!"
echo "   From: $SOURCE_PATH"
echo "   To:   $DEST_PATH"
echo ""

# ─── Update Config if needed ───────────────────────────────
echo "🔧 Next steps:"
echo "   1. The agent file has been copied to $DEST_PATH"
echo "   2. To register it in the kingdom config, edit:"
echo "      $KINGDOM_DIR/opencode.kingdom.json"
echo "      Add an entry like:"
echo '      "'"$AGENT_NAME"'": {'
echo '        "description": "...",'
echo '        "mode": "subagent",'
echo '        "prompt": "Read agents/'"$AGENT_ROLE/$AGENT_NAME"'.md..."'
echo '      }'
echo ""
echo "   3. Run: bash scripts/sync-backup.sh"
echo "   4. Run: bash scripts/sync-down.sh (to push to all projects)"
echo ""
echo "   5. Commit and push the kingdom repo:"
echo "      cd $KINGDOM_DIR && git add -A && git commit -m \"kingdom: promote $AGENT_NAME agent\""
