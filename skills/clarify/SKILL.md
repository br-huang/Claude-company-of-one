---
name: clarify
description: 'Reverse-question the user until the feature intent is unambiguous. Drives brief Open Questions to empty before downstream skills run.'
---

# clarify

## Purpose

Resolve ambiguity in the current contract before any spec / code is produced.
Ask the user specific, answerable questions; record answers into the brief.

## Inputs

- `BRIEF.md` `## Open Questions`, `## Current Contract`, `## Assumptions`.
- User's natural-language intent for this run.

## Outputs

- `## Open Questions` reduced to empty (or only items explicitly deferred).
- `## Assumptions` expanded with each confirmed decision.
- `## Current Contract` rewritten if the clarification changed scope.

## Procedure

1. List every ambiguity in `## Current Contract` or `## Open Questions`.
2. Group related questions; ask at most 5 at a time.
3. For each question, offer 2–3 concrete options (A / B / C) rather than open-ended prose.
   This forces a decision.
4. After user answers, write each decision as one bullet under `## Assumptions` and
   remove the question from `## Open Questions`.
5. If an answer changes the scope, rewrite `## Current Contract` and highlight the delta.

## Failure modes

- User defers: keep the question in `## Open Questions` and add `DEFERRED — {reason}`.
  Do not let `/dev` enter Execute with a deferred question on a core behavior.
- User answers with "do what you think": refuse; propose 2–3 concrete options and
  ask again. ADR-001 D3's anti-self-deception applies to design too.
- More than 10 questions surface: the feature is too big; recommend splitting
  before `/think` continues.

## Does not do

- Does not research external facts (that is `research`).
- Does not write the spec artifact (that is `spec-writing`).
- Does not edit code.
