---
name: typescript-rules
description: "TypeScript-specific coding rules and conventions."
---

# TypeScript Rules

## Type Safety
- Enable `strict: true` in tsconfig.json
- Avoid `any` — use `unknown` and narrow with type guards
- Prefer interfaces for object shapes, type aliases for unions/intersections
- Use `readonly` for properties that shouldn't change
- Use `as const` for literal constants

## Patterns
- Prefer `const` over `let`; never use `var`
- Use optional chaining (`?.`) and nullish coalescing (`??`)
- Prefer `async/await` over raw Promises
- Use `Map`/`Set` over plain objects for dynamic keys
- Prefer `for...of` over `forEach` (allows `break` and `await`)

## Error Handling
- Use typed error classes for domain errors
- Prefer `Result<T, E>` patterns for expected failures over thrown exceptions
- Always type catch block errors: `catch (error: unknown)`

## Imports
- Use named imports over default imports
- Group imports: external → internal → relative
- No circular dependencies

## Testing
- Use `describe`/`it` structure with behavior-descriptive names
- Type test data explicitly — don't rely on inference for test fixtures
- Use `jest.mock` or `vi.mock` sparingly; prefer dependency injection
