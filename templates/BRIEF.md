# BRIEF: {feature or topic}

> Single source of truth for the current command run. Skills read only this file.
> Managed by `read-brief` (load) and `write-brief` (update). See ADR-001 D1/D2.

## Feature

{feature slug, one-sentence intent}

## Command

{/think | /dev | /review | /debug} — invoked {UTC timestamp}

## Active Specs

- REQUIREMENTS: {path or "N/A"}
- DESIGN: {path or "N/A"}
- TODO: {path or "N/A"}
- ADRs referenced: {list of ADR paths}

### Requirements Summary

<!-- Filled by read-brief. Downstream skills use this instead of re-reading REQUIREMENTS.md. -->

- REQ-1: {testable requirement}
  - Acceptance: {observable acceptance criterion}

### Design Summary

<!-- Filled by read-brief. Downstream skills use this instead of re-reading DESIGN.md. -->

- Approach: {implementation approach in 3-7 bullets}
- Non-goals: {explicit boundaries}
- Risk boundaries: {security, data, migration, or operational boundaries}

### TODO In Scope

<!-- Filled by read-brief from TODO.md. Only include items relevant to this run. -->

- [ ] {TODO item}

## Relevant Memory

<!-- One bullet per MEMORY item classified `used`. See ADR-001 D3. -->

- {memory item} — `used`

## Ignored Memory

<!--
ADR-001 D3: every loaded MEMORY item must be classified exactly once.
If no items were ignored, write:
  No ignored memory entries; every loaded memory item is used.
Do not leave this section empty.
-->

- {memory item} — `ignored:stale | ignored:unrelated | ignored:contradicted-by-spec | ignored:out-of-scope`

## Assumptions

- {explicit assumption the session is operating under}

## Open Questions

- {unresolved question for user, if any}

## Current Contract

{The exact behavior this session must preserve or deliver. One paragraph, non-negotiable.}

---

## Human-Owned Core

<!--
ADR-002: populated by `explain-60-40` before Execute.
`User prediction` and `User selected option` are MANDATORY before /dev enters Execute.
-->

### Core Item 1: {name}

- Invariant to preserve:
- Riskiest edge case:
- LLM proposed approach:
- User prediction: <!-- required before Execute -->
- User selected option: <!-- required before Execute -->
- Final implementation: <!-- filled after Execute -->
- Prediction result: <!-- aligned | diverged | partially-aligned — filled after Verify -->
- Reconstruction required: <!-- yes | no — per ADR-002 D4 trigger rules -->

#### Reconstruction Drill (only if required)

1. Invariant in your own words:
2. Core logic as pseudocode:
3. Edge case that changed your understanding:
4. Regression test that protects it:
