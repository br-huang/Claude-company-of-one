---
name: testing-standards
description: "Testing standards for test structure, naming, coverage, and quality."
---

# Testing Standards

## Test Structure

- Test files co-located with source OR in parallel `__tests__/` / `tests/` directory
- Follow project's existing convention for test file location
- One test file per source file (for unit tests)
- Integration tests in a dedicated directory

## Test Naming

Tests describe behavior, not implementation:
```
✓ "should return empty array when no items match filter"
✓ "should throw ValidationError when email is invalid"
✗ "test filterItems function"
✗ "test case 1"
```

Pattern: `should {expected behavior} when {condition}`

## Test Body

Use Arrange-Act-Assert (AAA) structure:
```
// Arrange — set up test data and preconditions
// Act — execute the code under test
// Assert — verify the result
```

Keep each section short and focused. If Arrange is long, extract a helper.

## Test Quality

- Each test verifies ONE behavior
- Tests are independent — no shared mutable state, no execution order dependency
- Tests are deterministic — same result every run
- No logic in tests (no if/else, loops, or try/catch)
- Test the behavior, not the implementation

## What to Test

- Happy path (expected inputs → expected outputs)
- Edge cases (empty, null, boundary values, max size)
- Error paths (invalid inputs → appropriate errors)
- Integration points (API calls, database queries, file I/O)

## What NOT to Test

- Private implementation details (test through the public API)
- Third-party library internals
- Trivial getters/setters with no logic
- Framework code (e.g., don't test that React renders a div)

## Mocking

- Mock external services (APIs, databases, file systems)
- Do NOT mock internal logic (test the real code)
- Prefer fakes over mocks when possible (in-memory DB > mock DB)
- Keep mocks minimal — only mock what you must
