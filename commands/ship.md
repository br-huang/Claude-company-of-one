---
name: ship
description: "Ship a change — feature, refactor, or planned work. Orchestrator sizes the task (Small/Medium/Large) and chains the right skills. Replaces v1's /develop + /review + /refactor + /plan."
---

# /ship — Unified Shipping Pipeline

One entry point for all shipping work. The orchestrator picks the path; you don't pick the command.

## Sizing (first decision)

Invoke the `orchestrator` skill. It classifies the task:

| Size       | Signals                             | Path                                                                      |
| ---------- | ----------------------------------- | ------------------------------------------------------------------------- |
| **Small**  | Single file, < 2 min, clear fix     | Just do it. No skills chained.                                            |
| **Medium** | 2–5 files, 5–15 min, one module     | `requirements` → `design-doc` (inline) → `tdd` → `reviewer` agent → merge |
| **Large**  | Cross-module, > 15 min, new feature | Full flow below                                                           |

## Medium Flow

1. `requirements` skill → 3–5 bullet clarification (inline; gate: user confirms)
2. `success-metric` skill → one-line measurable outcome
3. `design-doc` skill → inline: Problem / Solution / Non-Goals / Alternatives
4. `git-ops` skill → feature branch
5. `test-plan` skill → golden / edge / error / won't-test
6. `tdd` skill → RED → GREEN → REFACTOR
7. `reviewer` agent (spawned — fresh eyes) → 1 fix round max
8. `release-checklist` skill (pre-merge)
9. `git-ops` skill → squash-merge
10. `pipeline-gate` skill → finalize

## Large Flow

Initialize state:

```bash
bash hooks/scripts/lib/pipeline-state.sh init ship {feature} large 6
bash hooks/scripts/lib/brief-manager.sh init ship {feature} large
```

Then:

1. **Clarify** — `requirements` + `success-metric` skills → full REQUIREMENTS.md in specs dir
2. **Design** — `design-doc` skill → full DESIGN.md; if UI involved, `wireframe` skill
3. **Gate (HARD):** user approves design before implementation
4. **Plan** — `write-plan` skill → PLAN.md with file-level steps
5. **Implement** — `git-ops` branch + `execute-plan` + `tdd` skills
6. **Review** — `reviewer` agent (spawned, parallel to any remaining tests)
7. **Gate (HARD):** user approves review before merge
8. **Merge** — `release-checklist` + `git-ops` squash-merge
9. **Retro** — `pipeline-gate` skill runs `pipeline-complete.sh`

Max 2 hard gates: design approval, review approval.

## UI detection (Medium + Large)

Signals: frontend, UI, UX, layout, page, component, button, form, theme, responsive, CSS.

If detected → add `wireframe` skill before/during design step.

## What This Replaces

- `/develop` — now the Large path of `/ship`
- `/review` — now a step inside `/ship` (not a top-level command)
- `/refactor` — now just a Small or Medium `/ship` with no new feature
- `/plan` — now the planning phase inside Large `/ship`

## Small tasks

Small tasks should not invoke `/ship` at all — direct work is cheaper. The orchestrator detects Small and short-circuits. If the user explicitly runs `/ship` on a Small task, just do the task and return.

## Anti-patterns

- Running `/ship` for questions or explanations — answer inline
- Spawning the `reviewer` agent for Small tasks — wasteful; direct self-review is fine
- Skipping the design gate on Large tasks — the gate is the point
