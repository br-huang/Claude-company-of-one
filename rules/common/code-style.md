---
name: code-style
description: "Universal coding standards applied to all code changes regardless of language."
---

# Code Style Rules

These rules apply to ALL code written or modified by any agent in Claude 一人公司.

## Functions
- Functions should do one thing and do it well
- Keep functions under 50 lines; split if longer
- Use early returns over nested conditionals
- Maximum 3 levels of nesting; refactor if deeper

## Naming
- Use meaningful, descriptive names
- No abbreviations except universally understood ones (id, url, api, db)
- Boolean variables/functions start with is/has/can/should
- Constants in UPPER_SNAKE_CASE

## Code Cleanliness
- No dead code — delete it, don't comment it out
- No commented-out code blocks
- No TODO comments without an associated issue/ticket
- Remove unused imports and variables

## Comments
- Comments explain WHY, never WHAT
- If code needs a WHAT comment, the code should be rewritten to be self-documenting
- Document non-obvious business rules
- Document workarounds with a reference to the underlying issue

## Error Handling
- Handle errors at the appropriate level — not everywhere
- Never silently swallow errors
- Error messages should be actionable (what went wrong + what to do about it)
- Don't use exceptions for control flow

## Complexity
- Prefer simple, obvious code over clever code
- YAGNI — don't build what you don't need yet
- DRY — but only when the abstraction is genuinely reusable (three similar lines > premature abstraction)
- Prefer composition over inheritance
