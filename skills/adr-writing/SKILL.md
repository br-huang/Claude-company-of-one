---
name: adr-writing
description: 'Author an Architecture Decision Record under docs/projects/<project>/adr/. Only when a decision has cross-feature, immutable, long-lived consequences.'
---

# adr-writing

## Purpose

Capture a significant architectural decision as an immutable record. ADRs are
distinct from spec files: specs describe what one feature delivers; ADRs describe
a constraint future features will live under.

This skill is used only in `/think` docs-writing context, where direct writes to
DESIGN.md are the deliverable. `/dev` must not invoke this skill; mid-step `/dev`
skills read BRIEF.md only.

## Inputs

- `BRIEF.md` `## Current Contract` and clarified decision from `clarify`.
- Existing ADR index under `docs/projects/<project>/adr/`.

## Outputs

- `docs/projects/<project>/adr/NNN-<past-tense-title>.md` where NNN is zero-padded
  and strictly one greater than the current max.
- Updated `BRIEF.md` `## Active Specs → ADRs referenced` with the new path.

## Procedure

1. Confirm the decision is ADR-worthy: reversing it in 6 months would cost more
   than writing it now. If not, use a short note in DESIGN.md instead.
2. Compute next NNN by listing `docs/projects/<project>/adr/` and incrementing.
3. Use the project's existing ADR style (inspect NNN-1 first). At minimum include:
   Status, Date, Context, Decision, Consequences (+/-), Alternatives Considered, Non-Goals.
4. Mark Status as `Proposed` on first write. Flip to `Accepted` only after user review.
5. Reference the ADR from DESIGN.md where it constrains implementation.

## Failure modes

- Numbering collision (two ADRs picking the same NNN) → recompute immediately
  before write; never assume.
- Temptation to edit a past Accepted ADR → refuse. Add a new ADR that supersedes it,
  or add a `## Follow-up` amendment at the bottom of the existing one. ADRs are immutable.
- Decision is actually feature-scoped → drop it into DESIGN.md Alternatives instead.

## Does not do

- Does not modify Accepted ADRs in place.
- Does not write code or tests.
- Does not stand in for `spec-writing`.
