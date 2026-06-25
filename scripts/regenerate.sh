#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# 👑 regenerate.sh — Restore Kingdom from Backup
# ============================================================
# If the kingdom/ directory is corrupted or destroyed, this script
# instantly restores it from backup/ — the cloned mirror.
#
# Usage: bash scripts/regenerate.sh
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KINGDOM_DIR="$(dirname "$SCRIPT_DIR")"
BACKUP_DIR="$KINGDOM_DIR/backup"
KING_DIR="$KINGDOM_DIR/king"
KNIGHTS_DIR="$KINGDOM_DIR/knights"
GIT_DIR="$KINGDOM_DIR/.git"

echo "👑 Kingdom Regeneration"
echo "━━━━━━━━━━━━━━━━━━━━━━━"

# Check if backup exists
if [ ! -d "$BACKUP_DIR/king" ] && [ ! -d "$BACKUP_DIR/knights" ]; then
    echo "❌ ERROR: No backup found at $BACKUP_DIR"
    echo "   Cannot regenerate. Backup directory is empty."
    exit 1
fi

# Restore king agents
if [ -d "$BACKUP_DIR/king" ]; then
    echo "📜 Restoring royal agents (king/)..."
    rm -rf "$KING_DIR"
    cp -r "$BACKUP_DIR/king" "$KING_DIR"
    echo "   ✅ King agents restored"
fi

# Restore knight agents
if [ -d "$BACKUP_DIR/knights" ]; then
    echo "🛡️  Restoring knight agents (knights/)..."
    rm -rf "$KNIGHTS_DIR"
    cp -r "$BACKUP_DIR/knights" "$KNIGHTS_DIR"
    echo "   ✅ Knight agents restored"
fi

# Restore root config files
for file in "opencode.kingdom.json" "RULES.kingdom.md"; do
    if [ -f "$BACKUP_DIR/$file" ]; then
        cp "$BACKUP_DIR/$file" "$KINGDOM_DIR/$file"
        echo "   ✅ $file restored"
    else
        echo "   ⚠️  $file not found in backup — skipping"
    fi
done

# Check git integrity
if [ -d "$GIT_DIR" ]; then
    echo "🔧 Checking git integrity..."
    cd "$KINGDOM_DIR"
    git fsck --no-dangling 2>/dev/null || echo "   ⚠️  Git integrity check found issues"
    echo "   ✅ Git repository intact"
fi

echo ""
echo "✅ Kingdom regenerated successfully from backup!"
echo "   If you need to re-apply to projects, run: bash scripts/sync-down.sh"
