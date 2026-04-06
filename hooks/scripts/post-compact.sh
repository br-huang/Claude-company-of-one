#!/usr/bin/env bash
# Post-Compact Hook — Claude 一人公司
# Restores pipeline state and critical context after context compaction.

set -euo pipefail

PLUGIN_DATA="${CLAUDE_PLUGIN_DATA:-$HOME/.claude/plugin-data/claude-company-of-one}"
MEMORY_DIR="$PLUGIN_DATA/memory"

# Restore pipeline state if active
if [ -f "$PLUGIN_DATA/pipeline-state.json" ]; then
  echo "## Pipeline State Restored"
  echo "You were in the middle of a pipeline. Here is the saved state:"
  echo ""
  cat "$PLUGIN_DATA/pipeline-state.json"
  echo ""
  echo "Resume from the current stage. Do not repeat completed stages."
fi

# Reload high-confidence patterns (same logic as session-start)
for pattern_file in "$MEMORY_DIR/patterns"/*.md; do
  [ -f "$pattern_file" ] || continue

  confidence=$(grep -m1 "^confidence:" "$pattern_file" 2>/dev/null | awk '{print $2}' || echo "0")
  confidence_int=$(echo "$confidence" | awk '{printf "%d", $1 * 10}')

  if [ "$confidence_int" -ge 7 ]; then
    sed -n '/^---$/,/^---$/!p' "$pattern_file" | tail -n +1
    echo ""
  fi
done
