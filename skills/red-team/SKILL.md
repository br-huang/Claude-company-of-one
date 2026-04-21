---
name: red-team
description: '/review Layer 2: adversarial review by reviewer agent reading ONLY REVIEW_INPUT.md. Three output buckets; security is a lens, not a separate skill.'
---

# red-team

## Purpose

Layer 2 of `/review`. Invoked by the `reviewer` agent (never by Main Agent
directly). The reviewer agent runs with fresh context and ONLY reads
`REVIEW_INPUT.md` plus the specific files it references. This prevents Main Agent
self-deception (ADR-001 D4).

## Inputs

- `REVIEW_INPUT.md` at the spec directory.
- Files, line ranges, or test outputs explicitly cited by REVIEW_INPUT.md.

## Outputs

Return Layer 2 markdown with three buckets. The Main Agent writes it into
`REVIEW.md`; the reviewer agent does not edit files.

1. **Confirmed Findings** — evidence-backed issues (file:line + snippet + impact).
2. **Plausible Risks** — realistic risks needing verification, labeled `risk to verify`.
3. **Attack Surfaces Checked** — explicit inventory of what was inspected and came
   back clean, so the reader sees the boundary of the review.

## Procedure

1. Read REVIEW_INPUT.md in full. Note `review_mode`, Known Deviations, Questions
   for Reviewer, Out of Scope.
2. Load only the referenced artifacts. Do NOT crawl the repo, do NOT read
   BRIEF.md, do NOT read chat history.
3. Check each attack surface through the red-team lens:
   - correctness / off-by-one / null / race
   - spec conformance gaps (anything Layer 1 might have missed)
   - security: secret exposure, injection, auth/authz bypass, destructive data
     loss, RCE path (these five categories are the auto-hard-block list, ADR-001 D4)
   - operational: rollback, migration ordering, observability gaps
4. Label every entry. Anti-padding clause: **Do not invent findings. If a
   suspected issue is not supported by evidence, label it as `risk to verify`,
   not `finding`.**
5. Emit the three buckets as markdown. Empty `Confirmed Findings` is fine; do not manufacture one.

## Failure modes

- No evidence for a suspected issue → must be in `Plausible Risks`, not `Confirmed`.
- Review drifts into style bikeshedding → drop to `Attack Surfaces Checked` with
  `no material issue`, not a finding.
- Reviewer wants to read BRIEF.md or chat history → refuse. That defeats Layer 2.

## Does not do

- Does not edit code.
- Does not write Layer 1 (that is `spec-conformance`).
- Does not write Main Agent dispositions (that is `critique-dialogue`).
- Does not auto-escalate severity to hit a count.
