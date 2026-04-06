#!/usr/bin/env bash
# Session Start Hook — Claude 一人公司
# Loads project context and high-confidence patterns into the session.

set -euo pipefail

PLUGIN_DATA="${CLAUDE_PLUGIN_DATA:-$HOME/.claude/plugin-data/claude-company-of-one}"
MEMORY_DIR="$PLUGIN_DATA/memory"

# Ensure memory directory exists
mkdir -p "$MEMORY_DIR/patterns" "$MEMORY_DIR/decisions" "$MEMORY_DIR/retros"

# Output project context if it exists
if [ -f "$MEMORY_DIR/project-context.md" ]; then
  echo "## Project Context (from memory)"
  cat "$MEMORY_DIR/project-context.md"
  echo ""
fi

# Load high-confidence patterns (confidence >= 0.7)
PATTERN_COUNT=0
for pattern_file in "$MEMORY_DIR/patterns"/*.md; do
  [ -f "$pattern_file" ] || continue

  # Extract confidence from frontmatter
  confidence=$(grep -m1 "^confidence:" "$pattern_file" 2>/dev/null | awk '{print $2}' || echo "0")

  # Compare as integers (multiply by 10 to avoid float comparison)
  confidence_int=$(echo "$confidence" | awk '{printf "%d", $1 * 10}')

  if [ "$confidence_int" -ge 7 ]; then
    if [ "$PATTERN_COUNT" -eq 0 ]; then
      echo "## Active Patterns (high confidence)"
    fi
    # Output pattern content (skip frontmatter)
    sed -n '/^---$/,/^---$/!p' "$pattern_file" | tail -n +1
    echo ""
    PATTERN_COUNT=$((PATTERN_COUNT + 1))
  fi
done

if [ "$PATTERN_COUNT" -gt 0 ]; then
  echo "($PATTERN_COUNT high-confidence patterns loaded)"
fi

# Check for active pipeline state
if [ -f "$PLUGIN_DATA/pipeline-state.json" ]; then
  echo ""
  echo "## Active Pipeline State"
  echo "A pipeline was in progress. Review the state and consider resuming."
  cat "$PLUGIN_DATA/pipeline-state.json"
fi
