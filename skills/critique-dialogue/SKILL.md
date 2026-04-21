---
name: critique-dialogue
description: '/review Layer 3: Main Agent responds to every Layer 2 finding with a disposition. Hard cap 2 needs-user-decision per /review run.'
---

# critique-dialogue

## Purpose

Layer 3 of `/review`. Closes the adversarial loop: Main Agent must file a
disposition for every Layer 2 finding, including `Plausible Risks`. No silent
dismissals.

## Inputs

- `REVIEW.md` Layer 2 section (buckets written by the reviewer agent).
- `BRIEF.md` — Main Agent's working context (unlike Layer 2, Layer 3 may use it).
- Git diff or code file:line referenced by each finding.

## Outputs

- `REVIEW.md` Layer 3 section: one row per finding in the Critique Dialogue table
  with Disposition + Developer Response + Resolution.
- Any accepted-and-fixed findings produce code edits or new TODO items (written via
  `update-docs`, not here).
- `needs-user-decision Budget` counter updated. Hard cap: 2 per `/review` run.

## Procedure

1. For every finding and plausible risk in Layer 2, assign exactly one disposition:
   - `accepted` — will fix; describe the fix or commit reference.
   - `rejected` — requires evidence, not preference; cite file:line or a spec clause.
   - `deferred` — accepted in principle, tracked as a new TODO or follow-up issue.
   - `needs-user-decision` — user must pick. Capped at 2 per run.
2. If `needs-user-decision` count would exceed 2, collapse the lowest-severity
   one into `deferred` with a follow-up TODO.
3. For every `accepted`, either produce the fix in-session (and re-run `verify`)
   or write the follow-up TODO.
4. For every `rejected`, include at least one piece of evidence (code cite, test
   cite, or explicit spec clause). "Not a real issue" is not a disposition.

## Failure modes

- Any finding left with no disposition → FAIL; re-run until closed.
- `needs-user-decision` > 2 → FAIL; collapse per step 2.
- `rejected` without evidence → FAIL; either gather evidence or promote to `deferred`.

## Does not do

- Does not edit Layer 2 findings; the reviewer agent owns Layer 2.
- Does not decide the final merge verdict; the Verdict line in REVIEW.md does.
- Does not run `session-reflection`; `/review` has no session-reflection step (ADR-001 D7).
