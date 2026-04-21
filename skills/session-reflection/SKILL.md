---
name: session-reflection
description: '/dev post-step: 9-question retro including Q9 prediction accuracy (ADR-002). Triggers reconstruction drill only for diverged core items.'
---

# session-reflection

## Purpose

`/dev`'s reflection artifact (ADR-001 D7). Nine questions: eight standard retro,
one prediction-accuracy audit per ADR-002 D3. Output is appended to the brief and
produces any reconstruction drills needed.

## Inputs

- `BRIEF.md` `## Human-Owned Core` with `Final implementation` already filled by `verify`.
- Diff for this session.
- TODO.md and CHANGELOG.md (already updated by `update-docs`).

## Outputs

- Appended block in `BRIEF.md` containing the 9 answers.
- For each diverged core item, `Reconstruction required: yes` flipped on and the
  Reconstruction Drill section filled (by user, with Main Agent help).
- No new file; session reflection stays inside the brief before archive.

## Procedure

Ask and record answers for all nine questions:

1. **What did we change?** (one-paragraph factual summary)
2. **How was it implemented?** (key design decisions, surprises)
3. **Are we satisfied with the implementation?** (yes/no + reason)
4. **Are the tests meaningful?** (map Test Plan → tests written)
5. **Did we respect the spec?** (any silent drift? any ADR-worthy amendment?)
6. **TODO / CHANGELOG updated?** (confirm `update-docs` ran)
7. **Best practices followed?** (TDD cycle, small diffs, commit hygiene)
8. **What problems surfaced?** (blockers, rework, flaky tests)
9. **Prediction accuracy (ADR-002 Q9):** For each `Human-Owned Core` item, compare
   `User prediction` with `Final implementation`. Main Agent fills initial judgment
   (`aligned | diverged | partially-aligned`) with a one-line reason; user confirms or
   corrects. Write result to that item's `Prediction result` field.

After Q9:

- For each item with `Prediction result = diverged` OR `partially-aligned` without a
  clear reason OR `User selected option ≠ Final implementation` OR new core behavior
  that was not predicted: set `Reconstruction required: yes` and invoke the four-part
  drill (invariant restated / pseudocode / edge case / regression test).
- Route pseudocode through `spec-conformance` reconstruction judge for mechanical
  comparison — don't let the LLM soften `diverged`.

## Failure modes

- Any of Q1–Q9 left blank → FAIL. Nine means nine.
- Drill triggered but skipped → blocks `/dev` completion; cannot archive brief.
- LLM softens `diverged` to "mostly aligned" → override and keep `diverged`. ADR-002
  explicitly forbids softening.

## Does not do

- Does not run on `/review` or `/debug` or `/think` (ADR-001 D7).
- Does not judge the quality of the user's drill answers as a score — only the
  invariant match.
- Does not cross-session track prediction-accuracy statistics (ADR-002 Non-Goal).
