---
name: debug-hypotheses
description: '/debug step: enumerate 3–5 plausible root causes with explicit uncertainty labels. No padding.'
---

# debug-hypotheses

## Purpose

First analytical step of `/debug`. Turn a user-reported symptom into a small set of
candidate root causes, each with a cheap validation path. This is the hypothesis
menu that `debug-validate` then burns down one at a time.

## Inputs

- `BRIEF.md` `## Current Contract` (which in `/debug` is the reproduction +
  symptom description).
- Git log for the relevant area (recent changes are prior-probability high).
- Any test output or stack traces in the brief.

## Outputs

- `BRIEF.md` appended block `## Hypotheses` with 3–5 items:

```
### H1. {one-sentence hypothesis}
- Evidence for:
- Evidence against:
- Confidence: high | medium | low
- Validation: {one concrete command, file inspection, or test to confirm/refute}
```

## Procedure

1. Partition the possibility space: data, environment, recent code change, library
   bug, integration contract, concurrency, caching. Pick the 3–5 with actual
   evidence from the reproduction.
2. For each hypothesis, write both evidence-for and evidence-against. An asymmetric
   list (only supporting evidence) is confirmation bias — rewrite it.
3. Rank by a cheap-first rule: prefer hypotheses whose validation takes minutes,
   not hours. `debug-validate` will test them in that order.
4. Explicitly label low-confidence ones `low`. Do not pad to 5 if you only have 3.

## Failure modes

- Fewer than 3 real hypotheses → the problem isn't understood yet; do more
  reproduction before moving on.
- More than 5 → split the investigation; a 7-way fan-out becomes shotgun debugging.
- A hypothesis with no `Validation` step → reject; every hypothesis needs a test.

## Does not do

- Does not fix anything.
- Does not run validations (that is `debug-validate`).
- Does not file a TODO or CHANGELOG entry; `/debug` does that via `update-docs` after fix.
