---
name: research
description: 'External-knowledge gathering step — Web Search + Context7 docs lookup. Validates that the spec/plan reflects current library reality.'
---

# research

## Purpose

Gather up-to-date external knowledge needed for the current `/think` or `/dev` run.
Uses Web Search for ecosystem context and Context7 MCP for library/API docs, since
training-data cutoffs miss recent breaking changes.

## Inputs

- `BRIEF.md` `## Feature` + `## Current Contract`.
- `## Open Questions` that are knowledge gaps (not design questions — those go to `clarify`).
- Library / framework names named in the brief or spec.

## Outputs

- Research notes appended to `BRIEF.md` as sub-bullets under `## Assumptions` and
  `## Open Questions`. Each citation includes a URL or `context7:<library-id>` reference.

## Procedure

1. Identify unknowns with external answers: library version, API shape, deprecation,
   security advisory, ecosystem norm.
2. For each library: `mcp__plugin_context7_context7__resolve-library-id` →
   `mcp__plugin_context7_context7__query-docs`. Prefer this over Web Search for API docs.
3. For ecosystem norms / comparisons / recent incidents: Web Search with narrow queries.
4. Record each finding as one bullet: `{claim} — {source}`.
5. If research contradicts an assumption already in the brief, move that assumption
   from `## Assumptions` to `## Open Questions` and flag it for `clarify`.

## Failure modes

- Context7 has no entry for the library → fall back to official docs via Web Search,
  but never fabricate a version or API signature. Record `unknown — needs verification`
  if still uncertain.
- Context7 MCP tool is unavailable (plugin not installed, MCP offline) → record one
  bullet `context7 unavailable — used web search fallback` under `## Assumptions`,
  then proceed with Web Search. Do NOT block the run on missing tooling.
- A finding implies the spec is wrong → do not silently patch the spec; surface it
  and let `clarify` or `spec-writing` update the spec.

## Does not do

- Does not write code.
- Does not read MEMORY.md (use the brief's `## Relevant Memory` instead).
- Does not answer design-intent questions; those belong to `clarify`.
