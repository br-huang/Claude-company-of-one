---
name: tdd
description: 'Test-driven development cycle: RED → GREEN → REFACTOR. Every code change goes through it, including /debug regression tests.'
---

# tdd

## Purpose

Default execution loop for any code change in `/dev` and `/debug`. RED → GREEN →
REFACTOR, one behavior at a time. Produces tests that actually describe behavior
rather than lock in an implementation.

## Inputs

- `BRIEF.md` `## Current Contract` (what needs to work) and, for `/dev`, the
  `test-plan` output (what to cover).
- For `/debug`, `### Root Cause` from `debug-validate` — the regression test
  exercises the exact reproduction.

## Outputs

- New test file(s) added / modified, each corresponding to one behavior. `tdd`
  does not commit by itself; command/repo policy decides whether the Main Agent
  commits after docs update.
- Production code delivering the minimum to make each new test pass.
- Refactored code after green, tests still passing.

## Procedure

### RED

1. Write a test for ONE behavior. Name it `should X when Y`.
2. Use Arrange-Act-Assert layout.
3. Run it. Watch it fail. Confirm the failure message names the missing behavior,
   not a syntax error.

### GREEN

1. Write the minimum code to make that test pass. No generalization, no unrelated
   cleanup.
2. Run the test. It passes.

### REFACTOR

1. Improve names, remove duplication, simplify. Do NOT add new behavior.
2. Run tests after each edit. Keep the bar green.

Repeat until the test plan (or, for `/debug`, the regression test) is complete.

## Failure modes

- Code written before the test → delete the code, write the test first. No exceptions.
- Test passes on the first run (skipped RED) → the test is not exercising the change;
  rewrite it to fail first.
- Test name contains `and` → split into two tests.
- More than ~10 tests for one feature → feature is too big; route back to `spec-writing`.

## Does not do

- Does not decide which tests to write (that is `test-plan`).
- Does not run the final verification sweep (that is `verify`).
- Does not mock internal logic; mock only external services.
