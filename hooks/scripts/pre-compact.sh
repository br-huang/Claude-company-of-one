#!/usr/bin/env bash
# Pre-Compact Hook — Claude 一人公司
# Saves pipeline state before context compaction so it can be restored.

set -euo pipefail

PLUGIN_DATA="${CLAUDE_PLUGIN_DATA:-$HOME/.claude/plugin-data/claude-company-of-one}"

# Ensure data directory exists
mkdir -p "$PLUGIN_DATA"

# The pipeline state is managed by the pipeline-gate skill via JSON file.
# This hook ensures the file is persisted (it should already be written by the skill).
# We output a reminder for the agent to save any in-memory state.

echo "Pre-compact: Ensure all pipeline state is saved to $PLUGIN_DATA/pipeline-state.json"
echo "If you have unsaved pipeline progress, write it now before compaction."
