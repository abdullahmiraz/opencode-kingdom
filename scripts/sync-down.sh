#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# 👑 sync-down.sh — Push Kingdom Updates to All Projects
# ============================================================
# Updates all registered projects' .opencode/agents/ with the
# latest kingdom agents. Preserves project-specific agents.
#
# Usage:
#   bash scripts/sync-down.sh                    # Sync all registered projects
#   bash scripts/sync-down.sh --path /path/to/project  # Sync specific project
#   bash scripts/sync-down.sh --dry-run           # Preview without changes
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KINGDOM_DIR="$(dirname "$SCRIPT_DIR")"

DRY_RUN=false
SPECIFIC_PATH=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --path) SPECIFIC_PATH="$2"; shift 2 ;;
        --dry-run) DRY_RUN=true; shift ;;
        *) echo "❌ Unknown option: $1"; exit 1 ;;
    esac
done

echo "👑 Kingdom Sync — Push Updates to Projects"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if $DRY_RUN; then
    echo "🏃 Dry-run mode — no changes will be made"
fi

# ─── Collect Projects ──────────────────────────────────────

PROJECT_PATHS=()

if [ -n "$SPECIFIC_PATH" ]; then
    # Specific project
    SPECIFIC_PATH="$(cd "$SPECIFIC_PATH" 2>/dev/null && pwd || echo "$SPECIFIC_PATH")"
    if [ -f "$SPECIFIC_PATH/.opencode/kingdom/kingdom-link.txt" ]; then
        PROJECT_PATHS+=("$SPECIFIC_PATH")
    else
        echo "❌ No kingdom link found at $SPECIFIC_PATH"
        echo "   Run init-project.sh first."
        exit 1
    fi
else
    # Scan for projects — check common locations
    SCAN_DIRS=(
        "$HOME"
        "$HOME/projects"
        "$HOME/code"
        "$HOME/dev"
        "$HOME/work"
        "$(pwd)"
    )
    
    for scan_dir in "${SCAN_DIRS[@]}"; do
        if [ -d "$scan_dir" ]; then
            while IFS= read -r -d '' linkfile; do
                project_dir="$(dirname "$(dirname "$linkfile")")"
                PROJECT_PATHS+=("$project_dir")
            done < <(find "$scan_dir" -maxdepth 5 -path "*/.opencode/kingdom/kingdom-link.txt" -print0 2>/dev/null || true)
        fi
    done
    
    # Remove duplicates
    IFS=$'\n' PROJECT_PATHS=($(printf "%s\n" "${PROJECT_PATHS[@]}" | sort -u))
    unset IFS
fi

if [ ${#PROJECT_PATHS[@]} -eq 0 ]; then
    echo "❌ No kingdom-linked projects found."
    exit 1
fi

echo "Found ${#PROJECT_PATHS[@]} project(s) to sync"
echo ""

# ─── Sync Each Project ─────────────────────────────────────
SYNCED_COUNT=0
SKIPPED_COUNT=0

for PROJECT_PATH in "${PROJECT_PATHS[@]}"; do
    echo "────────────────────────────────────────────"
    echo "📁 Project: $(basename "$PROJECT_PATH")"
    echo "   Path: $PROJECT_PATH"
    
    OPENCODE_DIR="$PROJECT_PATH/.opencode"
    
    # Read kingdom version
    KINGDOM_VERSION="unknown"
    if [ -f "$OPENCODE_DIR/kingdom/kingdom-link.txt" ]; then
        KINGDOM_VERSION=$(grep "KINGDOM_VERSION" "$OPENCODE_DIR/kingdom/kingdom-link.txt" | cut -d':' -f2 | xargs || echo "unknown")
    fi
    echo "   Current kingdom version: $KINGDOM_VERSION"
    
    # Check if project has local-only agents (files that exist in project but NOT in kingdom)
    # We preserve these
    LOCAL_AGENTS=""
    for agent_file in "$OPENCODE_DIR/agents/"*.md; do
        agent_name="$(basename "$agent_file")"
        # Check if this agent exists in kingdom
        if [ ! -f "$KINGDOM_DIR/king/$agent_name" ] && [ ! -f "$KINGDOM_DIR/knights/$agent_name" ]; then
            LOCAL_AGENTS="$LOCAL_AGENTS $agent_name"
            echo "   🏘️  Keeping local agent: $agent_name"
        fi
    done
    
    if $DRY_RUN; then
        echo "   🔄 Would update kingdom agents"
        echo "   🔄 Would preserve $([ -n "$LOCAL_AGENTS" ] && echo "$LOCAL_AGENTS" || echo "no local agents")"
        echo "   ⏭️  Skipped (dry-run)"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
        continue
    fi
    
    # ─── Sync King Agents ─────────────────────────────────
    if [ -d "$KINGDOM_DIR/king" ]; then
        for king_file in "$KINGDOM_DIR/king/"*.md; do
            king_name="$(basename "$king_file")"
            # Don't overwrite local-only agents
            if [[ ! " $LOCAL_AGENTS " =~ " $king_name " ]]; then
                cp "$king_file" "$OPENCODE_DIR/agents/$king_name"
            fi
        done
        echo "   ✅ Royal agents synced"
    fi
    
    # ─── Sync Knight Agents ───────────────────────────────
    if [ -d "$KINGDOM_DIR/knights" ]; then
        for knight_file in "$KINGDOM_DIR/knights/"*.md; do
            knight_name="$(basename "$knight_file")"
            # Don't overwrite local-only agents
            if [[ ! " $LOCAL_AGENTS " =~ " $knight_name " ]]; then
                cp "$knight_file" "$OPENCODE_DIR/agents/$knight_name"
            fi
        done
        echo "   ✅ Knight agents synced"
    fi
    
    # ─── Sync RULES.md if not customized ──────────────────
    if [ -f "$OPENCODE_DIR/RULES.md" ]; then
        # Check if the RULES.md has been customized (diff from kingdom)
        if [ -f "$KINGDOM_DIR/RULES.kingdom.md" ]; then
            KINGDOM_RULES_HASH=$(md5sum "$KINGDOM_DIR/RULES.kingdom.md" | cut -d' ' -f1)
            PROJECT_RULES_HASH=$(md5sum "$OPENCODE_DIR/RULES.md" | cut -d' ' -f1)
            if [ "$KINGDOM_RULES_HASH" != "$PROJECT_RULES_HASH" ]; then
                echo "   ⚠️  RULES.md appears customized — not overwriting"
                echo "   💡 To update: manually merge changes from $KINGDOM_DIR/RULES.kingdom.md"
            fi
        fi
    fi
    
    # Update kingdom link with new version
    DATE_TAG=$(date +%Y-%m-%d)
    cat > "$OPENCODE_DIR/kingdom/kingdom-link.txt" << EOL
KINGDOM_VERSION: 1.0.0
LINKED_DATE: $DATE_TAG
KINGDOM_PATH: $KINGDOM_DIR
REGENERATE_CMD: bash $KINGDOM_DIR/scripts/regenerate.sh
SYNC_CMD: bash $KINGDOM_DIR/scripts/sync-down.sh
EOL
    
    echo "   ✅ Kingdom link updated"
    echo "   ✅ Project synced"
    SYNCED_COUNT=$((SYNCED_COUNT + 1))
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Sync complete!"
echo "   Synced: $SYNCED_COUNT project(s)"
echo "   Skipped: $SKIPPED_COUNT (dry-run)"
echo ""
if [ $SYNCED_COUNT -gt 0 ]; then
    echo "📋 Projects updated:"
    for p in "${PROJECT_PATHS[@]}"; do
        echo "   • $(basename "$p")"
    done
fi
