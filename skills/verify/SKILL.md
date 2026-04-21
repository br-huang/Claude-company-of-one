---
name: verify
description: 'Post-code check: run tests + confirm TODO acceptance items map to passing tests; applies a security lens but is not a separate scan.'
---

# verify

## Purpose

Close the loop between spec and code. Run the test suite, then match TODO/REQ
acceptance criteria to actual passing tests. `verify` ≠ `tdd`: tdd writes one test
at a time; verify inspects the whole delivered state before `update-docs`.

## Inputs

- `BRIEF.md` `## Current Contract`, `### Requirements Summary`, and
  `### TODO In Scope` (requirement list, acceptance criteria, and scoped TODOs
  already folded in by `read-brief`).
- `BRIEF.md` `## Test Plan` (produced earlier by `test-plan` and `tdd`).
- The actual test command(s) for the project (derive from `package.json`,
  `project.json`, `mise.toml`, or ask user if unclear).
- Does NOT re-open REQUIREMENTS.md / TODO.md itself; the brief is authoritative.

## Outputs

- Pass/fail summary written to the brief under `## Assumptions` as
  `verify: all REQs mapped to passing tests` or a list of gaps.
- If gaps found, items appended to `## Open Questions` for follow-up.

## Procedure

1. Run unit tests via `pnpm nx test <project>` (or equivalent). Capture result.
2. Run e2e/integration tests if the project defines them.
3. For every REQ summarized in the brief's `### Requirements Summary`, locate at least one
   test exercising its acceptance.
4. For every TODO item the brief records as in-flight for this run, confirm the
   code actually delivers it.
5. Apply the security lens (absorbed from the retired `security-scan` skill):
   - new user-input boundaries without validation?
   - new secrets / env vars / tokens in committed code?
   - new file-path / shell-exec / SQL construction from user data?
     Flag findings as plausible risks, not confirmed vulns, unless the evidence is explicit.
6. If any check fails, leave the work incomplete; do NOT proceed to `update-docs`.

## Failure modes

- Test command fails due to missing runtime → stop and surface the mise/pnpm issue
  rather than marking verify pass.
- REQ has no test coverage → gap; append to `## Open Questions`. User decides
  whether to add a test now or defer.
- Security lens produces > 3 findings → likely systemic; recommend a full `/review`.

## Does not do

- Does not write new tests (that is `tdd`).
- Does not decide WHAT to test (that is `test-plan`).
- Does not tick TODO boxes (that is `update-docs`).
- Does not replace `/review` Layer 2 red-team analysis.
