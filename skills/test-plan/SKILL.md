---
name: test-plan
description: "Decide WHAT to test before writing tests. Output: golden / edge / error / won't-test. Feeds tdd."
---

# test-plan

## Purpose

Pre-code step in `/dev`. Partition the coverage space into four buckets so `tdd`
knows which tests to write. "Won't test" is mandatory — the explicit boundary
prevents both overtesting and silent gaps.

## Inputs

- `BRIEF.md` `## Current Contract`, `### Requirements Summary`,
  `### Design Summary`, `### TODO In Scope`, and `## Human-Owned Core`
  (already populated by `explain-60-40` earlier in `/dev`).
- Do NOT re-read REQUIREMENTS.md / DESIGN.md directly. The brief is the contract.

## Outputs

- Appended block in `BRIEF.md`:

```
## Test Plan
### Golden path
- ...
### Edge cases
- ...
### Error paths
- ...
### Won't test (and why)
- ...
```

## Procedure

1. Golden path first. If it is unclear, the feature is not ready — route back to `clarify`.
2. Edge cases: boundary, empty, max, concurrency, malformed input. Cap at 5. More
   than 5 = too many modes in one feature; split it.
3. Error paths: for each expected failure mode, describe the error the user sees.
4. Won't test: for each deliberate omission, cite the reason
   (covered-by-types / trivial / integration-tested-elsewhere / 60%-boilerplate).
5. Name tests by behavior, not by function: `it_sends_email_on_signup`.

## Failure modes

- Empty `Won't test` → incomplete plan. Boundary must be explicit.
- Edge-case count > 5 → scope signal; push back to `spec-writing` before continuing.
- Planning > 10 tests total for one feature → feature is too big.

## Does not do

- Does not write tests (that is `tdd`).
- Does not run tests (that is `verify`).
- Does not substitute for `tdd`'s RED step; planning a test is not writing it.
