---
name: security-baseline
description: "Security baseline rules applied to all code to prevent common vulnerabilities."
---

# Security Baseline

## Secrets Management

- NEVER hardcode secrets, API keys, tokens, or passwords in source code
- NEVER commit `.env` files, credential files, or private keys
- Use environment variables or secret management services
- If a secret is accidentally committed, rotate it immediately (git history preserves it)

## Input Validation

- Validate ALL external input (user input, API responses, file contents)
- Validate at system boundaries, not deep in business logic
- Whitelist valid input rather than blacklisting invalid input
- Sanitize input before use in any interpreted context (SQL, HTML, shell)

## Injection Prevention

- **SQL**: Use parameterized queries / prepared statements — NEVER string concatenation
- **XSS**: Escape output in HTML contexts; use framework auto-escaping
- **Command injection**: Avoid shell execution with user input; use libraries with argument arrays
- **Path traversal**: Validate and normalize file paths; reject `..` sequences

## Authentication & Authorization

- Never implement custom crypto — use established libraries
- Hash passwords with bcrypt, scrypt, or argon2 (never MD5/SHA for passwords)
- Validate authorization on EVERY request, not just the UI
- Use least-privilege principle for all access

## Data Protection

- Never log sensitive data (passwords, tokens, PII)
- Error messages should not expose internal details (stack traces, SQL queries, file paths)
- Use HTTPS for all external communication
- Encrypt sensitive data at rest

## Dependencies

- Prefer well-maintained packages with active communities
- Check for known CVEs before adding dependencies
- Keep dependencies updated (but test after updating)
- Minimize dependency count — each dependency is an attack surface

## File Operations

- Validate file paths against traversal attacks
- Check file sizes before processing (prevent DoS)
- Validate file types (don't trust extensions alone)
- Use temp directories for ephemeral files; clean up after use
