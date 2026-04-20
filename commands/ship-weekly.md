---
name: ship-weekly
description: "Weekly shipping ritual. Scan the last 7 days of commits, draft a CHANGELOG entry, summarize what did and did not ship, and pick next week's top priority. Duolingo-inspired. Run once a week."
---

# /ship-weekly — Weekly Shipping Ritual

Not a report. A forcing function. Invokes the `weekly-ship` skill against the current project.

## Flow

1. Determine project scope — default to the current working directory's project
2. Invoke `weekly-ship` skill — produces the three outputs (what shipped / what didn't / next week's top 1)
3. If the current project has a `CHANGELOG.md`, append/merge into `## [Unreleased]`
4. Optionally pipe the "what shipped" list into the `changelog-launch-post` skill to draft launch copy
5. Save "next week top 1" to `${COMPANY_OF_ONE_PLUGIN_DATA}/weekly-ship/{YYYY-MM-DD}.md`

## When to Run

- Friday afternoon or any fixed weekly time
- Before a product demo to a stakeholder
- When the user says "what did I actually do this week?"

## Output Length

Short. The entire ritual output should fit in one screen. If it doesn't, the week had too many parallel threads and that itself is the finding.

## Notes

- This is intentionally a distinct command (not part of `/ship`) because it operates across a time window, not a task
- Does not spawn any agent — skill-only
- Runs safely on a clean tree; makes no code changes by default (only writes to CHANGELOG and plugin data dir)
