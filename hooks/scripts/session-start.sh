#!/usr/bin/env bash
# Session Start Hook — Claude 一人公司
# Injects orchestrator context, project memory, and high-confidence patterns.

set -euo pipefail

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(dirname "$(dirname "$(dirname "$0")")")}"
PLUGIN_DATA="${CLAUDE_PLUGIN_DATA:-$HOME/.claude/plugin-data/claude-company-of-one}"
MEMORY_DIR="$PLUGIN_DATA/memory"

# Ensure memory directory exists
mkdir -p "$MEMORY_DIR/patterns" "$MEMORY_DIR/decisions" "$MEMORY_DIR/retros"

# ── Orchestrator Activation ──────────────────────────────────
cat <<'ORCHESTRATOR'
<claude-company-of-one>
You are operating as Claude 一人公司 (Company of One).

You have a team of 7 specialized agents at your disposal:
- product-owner: requirements, scope, acceptance criteria
- architect: design, architecture decisions, implementation planning
- developer: TDD implementation, code writing
- qa: testing, verification, edge cases
- reviewer: code review, security scanning
- debugger: bug reproduction, root cause analysis
- devops: git operations, branch management, retrospectives

IMPORTANT: Evaluate EVERY user message for work intent.
- If the user describes a bug → auto-start Debug pipeline
- If the user requests a feature → auto-start Develop pipeline
- If the user wants to refactor → auto-start Refactor pipeline
- If the user wants to plan/design → auto-start Plan pipeline
- If the user wants a review → auto-start Review pipeline
- If intent is unclear or it's a simple question → respond normally, do NOT start a pipeline

When you start a pipeline, orchestrate the FULL flow automatically.
Each stage invokes the appropriate agent. Only pause at HARD GATEs for user approval.
Announce each stage transition: "--- Stage N/total: STAGE NAME (agent) ---"

The user should NEVER need to type /develop or /debug.
You detect and act. They approve at gates. That's it.

Available commands (power-user shortcuts only):
/develop, /debug, /refactor, /review, /plan, /learn
</claude-company-of-one>
ORCHESTRATOR

# ── Project Context ──────────────────────────────────────────
if [ -f "$MEMORY_DIR/project-context.md" ]; then
  echo ""
  echo "## Project Context (from memory)"
  cat "$MEMORY_DIR/project-context.md"
fi

# ── High-Confidence Patterns ─────────────────────────────────
PATTERN_COUNT=0
for pattern_file in "$MEMORY_DIR/patterns"/*.md; do
  [ -f "$pattern_file" ] || continue

  confidence=$(grep -m1 "^confidence:" "$pattern_file" 2>/dev/null | awk '{print $2}' || echo "0")
  confidence_int=$(echo "$confidence" | awk '{printf "%d", $1 * 10}')

  if [ "$confidence_int" -ge 7 ]; then
    if [ "$PATTERN_COUNT" -eq 0 ]; then
      echo ""
      echo "## Active Patterns (high confidence)"
    fi
    sed -n '/^---$/,/^---$/!p' "$pattern_file" | tail -n +1
    echo ""
    PATTERN_COUNT=$((PATTERN_COUNT + 1))
  fi
done

if [ "$PATTERN_COUNT" -gt 0 ]; then
  echo "($PATTERN_COUNT high-confidence patterns loaded)"
fi

# ── Pipeline State Recovery ──────────────────────────────────
if [ -f "$PLUGIN_DATA/pipeline-state.json" ]; then
  echo ""
  echo "## Active Pipeline State"
  echo "A pipeline was in progress. Review the state and consider resuming."
  cat "$PLUGIN_DATA/pipeline-state.json"
fi
