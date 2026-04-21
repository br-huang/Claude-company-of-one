---
name: spec-writing
description: 'Author REQUIREMENTS.md + DESIGN.md + TODO.md for a feature. The three files are one contract; they ship together.'
---

# spec-writing

## Purpose

Produce the three-file feature spec under `docs/projects/<project>/specs/YYYY-MM-DD-<slug>/`.
REQUIREMENTS defines acceptance, DESIGN defines approach, TODO defines executable
checklist. They are a single contract.

## Inputs

- `BRIEF.md` `## Current Contract` + `## Assumptions`.
- Outputs from `research` (validated library facts) and `clarify` (resolved decisions).
- Existing spec in the same directory, if this is a revision.

## Outputs

- `docs/projects/<project>/specs/YYYY-MM-DD-<verb>-<slug>/REQUIREMENTS.md`
- `.../DESIGN.md` (with Non-Goals and Alternatives Considered sections — mandatory)
- `.../TODO.md` (checkbox list, one per acceptance criterion or design step)

Update `BRIEF.md` `## Active Specs` with the three paths.

## Procedure

1. Compute spec directory name: `<today-YYYY-MM-DD>-<imperative-verb>-<slug>`
   (e.g., `2026-04-21-add-spec-writing-skill`).
2. REQUIREMENTS.md — write numbered REQ-N items, each with an acceptance criterion
   testable in `verify`. One behavior per REQ.
3. DESIGN.md — Problem / Solution / Non-Goals / Alternatives Considered / Risks.
   Non-Goals is mandatory; empty Non-Goals means the design wasn't thought through.
4. TODO.md — one checkbox per REQ acceptance and per DESIGN deliverable. Checkboxes
   are what `update-docs` ticks post-execution.
5. Cross-reference: every REQ appears in TODO; every DESIGN step appears in TODO.

## Failure modes

- REQ without an acceptance criterion → reject; rewrite.
- DESIGN without Non-Goals → reject; Non-Goals is what prevents scope creep.
- TODO has items not traceable to REQ or DESIGN → reject; either drop them or
  raise a new REQ.
- More than ~10 REQs → the feature is too big; split before continuing.

## Does not do

- Does not write ADRs (that is `adr-writing`).
- Does not write code or tests.
- Does not edit CHANGELOG (that is `update-docs`).
- Does not auto-escalate to reviewer agent (`/think` never auto-escalates, ADR-001 D4).
