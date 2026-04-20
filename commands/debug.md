---
name: debug
description: 'Systematic debugging: reproduce → diagnose → fix → verify → postmortem. No guessing. Uses the debugger agent for isolated root cause analysis, then skills for the rest.'
---

# /debug — Systematic Debugging

Root cause analysis first, fix second, postmortem third. The `debugger` agent runs in isolated context (fresh eyes for diagnosis); everything else is skills.

## Flow

### 1. Reproduce + Diagnose (agent: `debugger`)

Spawn the **debugger** agent. It reproduces, traces, hypothesizes, and returns a root cause.

**Output:** `DIAGNOSIS.md` in the feature spec directory, with:

- Minimal reproduction case
- Root cause (with evidence)
- Blast radius
- Recommended fix

### 2. Diagnosis gate (HARD)

Present the diagnosis summary to the user.

> Stage 2 Complete: Diagnosis
> Root cause: {1-sentence summary}
> Blast radius: {affected areas}
> Recommended fix: {1-sentence}
>
> Reply **'approved'** to proceed, or give alternative direction.

Do not proceed until the user confirms. Fixing the wrong root cause creates new bugs.

### 3. Fix (no agent — direct execution)

- Invoke `git-ops` skill → create `fix/{bug-slug}` branch
- Invoke `tdd` skill → failing test (RED) → minimum fix (GREEN) → refactor
- Commit: `fix({scope}): {description}`

### 4. Verify (skills)

- Invoke `test-verify` skill → confirm original repro now passes + full suite green + blast-radius tests
- If verify fails: return to step 1 (rediagnose) or step 3 (incomplete fix)

### 5. Postmortem (auto-triggered)

Always invoke the `postmortem` skill on completion.

- Skip the written postmortem only for trivial bugs (typo, one-off, < 5 min fix)
- Otherwise produce `POSTMORTEM.md` (blameless; timeline, root cause, action items)

### 6. Merge (skill)

- Invoke `release-checklist` skill (pre-merge section)
- Squash-merge to target branch via `git-ops`
- Clean up fix branch

## Pipeline Complete

> ✓ /debug complete
>
> Bug: {title}
> Root cause: {summary}
> Branch: merged to {target}
> Artifacts: DIAGNOSIS.md, POSTMORTEM.md (if written)

## Notes

- Only one agent spawned: `debugger` (step 1). Everything else is skills — major token savings vs v1.
- Postmortem is no longer conditional on a subagent deciding; it's the default, with a well-defined skip rule.
- If the task turns out to be a refactor rather than a bug, redirect to `/ship`.
