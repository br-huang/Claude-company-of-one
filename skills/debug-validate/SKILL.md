---
name: debug-validate
description: '/debug step: test one hypothesis at a time. Hard rule: no shotgun debugging — no concurrent changes across hypotheses.'
---

# debug-validate

## Purpose

Burn down the hypothesis list from `debug-hypotheses` one at a time. Confirm or
refute with an actual experiment before moving to the next. This is the skill that
prevents the "change three things, see which one worked" antipattern.

## Inputs

- `BRIEF.md` `## Hypotheses` section.
- The reproduction case from the brief.
- Code / tests / logs for the suspected area.

## Outputs

- `BRIEF.md` `## Hypotheses` updated in place:
  - Each H section gets a `Result:` line: `confirmed | refuted | inconclusive`.
  - `Notes:` field with the exact command output or diff used to conclude.
- A single `### Root Cause` subsection once a hypothesis is confirmed, referencing
  which H it was and the supporting evidence.

## Procedure

1. Pick the highest-confidence, cheapest-to-validate hypothesis.
2. Run its `Validation` step from `debug-hypotheses` verbatim. Do not skip ahead to
   fixing. Do not change more than one variable.
3. Record the result on that hypothesis. If `confirmed`, stop and write `### Root Cause`.
4. If `refuted`, move to the next hypothesis. If `inconclusive`, refine the
   hypothesis (tighter experiment) or split it, then re-validate.
5. Never modify multiple suspected areas simultaneously. If the user pushes for
   speed, refuse and cite ADR-001's "no routing / no shortcut" posture.

## Failure modes

- User asks you to "just try fixing all three" → refuse. Shotgun debugging
  invalidates the evidence chain and reintroduces the same class of bug later.
- All 5 hypotheses refuted → return to `debug-hypotheses` and enumerate a fresh
  round; do not fabricate a 6th.
- `inconclusive` twice in a row on the same H → refine the experiment or drop it;
  infinite loops are a smell.

## Does not do

- Does not fix the bug. Fix happens in `tdd` (regression test first) after `### Root Cause` is written.
- Does not skip hypotheses for speed.
- Does not merge into `debug-hypotheses`; enumeration and validation are separate
  for audit trail reasons.
