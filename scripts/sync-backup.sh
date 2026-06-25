#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# 👑 sync-backup.sh — Mirror Kingdom to Backup
# ============================================================
# Creates/updates an exact clone of kingdom/ in backup/.
# This is the kingdom's regeneration source.
#
# Usage:
#   bash scripts/sync-backup.sh              # Full mirror
#   bash scripts/sync-backup.sh --cron       # Quiet mode for cron/GitHub Action
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KINGDOM_DIR="$(dirname "$SCRIPT_DIR")"
BACKUP_DIR="$KINGDOM_DIR/backup"

QUIET=false
[[ "${1:-}" == "--cron" ]] && QUIET=true

$QUIET || echo "👑 Kingdom Backup — Mirror to backup/"
$QUIET || echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Verify kingdom directory exists and has content
if [ ! -d "$KINGDOM_DIR/king" ] || [ ! -d "$KINGDOM_DIR/knights" ]; then
    $QUIET || echo "❌ ERROR: Kingdom directories incomplete at $KINGDOM_DIR"
    exit 1
fi

# Clean backup and re-copy
$QUIET || echo "📦 Backing up king/ agents..."
rm -rf "$BACKUP_DIR/king"
cp -r "$KINGDOM_DIR/king" "$BACKUP_DIR/king"
$QUIET || echo "   ✅ $(find "$KINGDOM_DIR/king" -name '*.md' | wc -l) agent files"

$QUIET || echo "📦 Backing up knights/ agents..."
rm -rf "$BACKUP_DIR/knights"
cp -r "$KINGDOM_DIR/knights" "$BACKUP_DIR/knights"
$QUIET || echo "   ✅ $(find "$KINGDOM_DIR/knights" -name '*.md' | wc -l) agent files"

# Backup root config files
for file in "opencode.kingdom.json" "RULES.kingdom.md"; do
    if [ -f "$KINGDOM_DIR/$file" ]; then
        cp "$KINGDOM_DIR/$file" "$BACKUP_DIR/$file"
        $QUIET || echo "   ✅ $file backed up"
    fi
done

# Backup scripts (so regenerate.sh is always available even if scripts/ is wiped)
if [ -d "$KINGDOM_DIR/scripts" ]; then
    rm -rf "$BACKUP_DIR/scripts"
    cp -r "$KINGDOM_DIR/scripts" "$BACKUP_DIR/scripts"
    $QUIET || echo "   ✅ Scripts backed up"
fi

# Backup projects registry
if [ -d "$KINGDOM_DIR/projects" ]; then
    rm -rf "$BACKUP_DIR/projects"
    cp -r "$KINGDOM_DIR/projects" "$BACKUP_DIR/projects"
    $QUIET || echo "   ✅ Project registry backed up"
fi

# Write backup manifest
MANIFEST="$BACKUP_DIR/BACKUP_MANIFEST.txt"
cat > "$MANIFEST" << EOL
KINGDOM BACKUP MANIFEST
Backup Date: $(date -u '+%Y-%m-%d %H:%M:%S UTC')
Kingdom Version: 1.0.0

Contents:
- king/   : $(find "$KINGDOM_DIR/king" -name '*.md' | wc -l) royal agent files
- knights/: $(find "$KINGDOM_DIR/knights" -name '*.md' | wc -l) knight agent files
- Root config: opencode.kingdom.json, RULES.kingdom.md
- scripts/: regenerate.sh, init-project.sh, sync-down.sh, sync-backup.sh, promote-agent.sh
- projects/: Project registry (overlays, overlays)
EOL

$QUIET || echo ""
$QUIET || echo "✅ Backup complete!"
$QUIET || echo "   Backup location: $BACKUP_DIR"
$QUIET || echo "   To restore: bash scripts/regenerate.sh"

# If .git exists, suggest adding to git
if [ -d "$KINGDOM_DIR/.git" ]; then
    cd "$KINGDOM_DIR"
    # Check if backup/ is gitignored
    if [ -f ".gitignore" ] && grep -q "^backup/" ".gitignore" 2>/dev/null; then
        : # already ignored — good
    else
        $QUIET || echo ""
        $QUIET || echo "💡 Tip: Add 'backup/' to .gitignore — backup is a local mirror, not for git"
    fi
fi
