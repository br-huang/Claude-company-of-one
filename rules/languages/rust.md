---
name: rust-rules
description: "Rust-specific coding rules and conventions."
---

# Rust Rules

## Ownership & Borrowing
- Prefer borrowing (`&T`) over ownership when the function doesn't need to own the data
- Use `Clone` sparingly — prefer references
- Use `Cow<'_, str>` when a function might or might not need to allocate
- Avoid `unsafe` unless absolutely necessary; document why and what invariants are maintained

## Error Handling
- Use `Result<T, E>` for recoverable errors, `panic!` only for unrecoverable bugs
- Use `thiserror` for library error types, `anyhow` for application error types
- Use `?` operator for error propagation
- Provide context with `.context()` or `.with_context()`

## Patterns
- Prefer iterators over manual loops
- Use `Option` methods (`map`, `and_then`, `unwrap_or`) over `match` for simple cases
- Use `impl Trait` for return types when the concrete type is complex
- Prefer `&str` over `String` in function parameters
- Use builders for complex struct construction

## Project Structure
- Follow Cargo conventions for workspace and package layout
- Use `mod.rs` or `{module_name}.rs` consistently (prefer the latter)
- Feature flags for optional functionality
- Separate library (`lib.rs`) and binary (`main.rs`) crates

## Testing
- Use `#[cfg(test)]` module in the same file for unit tests
- Use `tests/` directory for integration tests
- Use `assert_eq!` / `assert_ne!` with descriptive messages
- Use `proptest` or `quickcheck` for property-based testing
- Use `mockall` sparingly; prefer trait-based dependency injection
