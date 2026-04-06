---
name: git-conventions
description: "Git workflow conventions for branch naming, commit messages, and merge strategies."
---

# Git Conventions

## Branch Naming

```
feature/{short-description}   — new features
fix/{short-description}        — bug fixes
refactor/{short-description}   — code restructuring
docs/{short-description}       — documentation changes
chore/{short-description}      — maintenance tasks
```

- Use lowercase with hyphens (kebab-case)
- Keep descriptions short (2-4 words)
- Examples: `feature/user-auth`, `fix/login-crash`, `refactor/simplify-api`

## Commit Messages

Format:
```
{type}({scope}): {description}

{optional body — explains what and why, not how}
```

Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `ci`

Rules:
- Subject line under 72 characters
- Use imperative mood ("add feature", not "added feature")
- No period at the end of the subject line
- Body wraps at 72 characters
- One logical change per commit

## Merge Strategy

- Squash merge feature/fix/refactor branches into the default branch
- Merge commit message summarizes the full change
- Delete the source branch after merge
- Never force-push to the default branch

## Safety

- Always verify tests pass before merging
- Never commit secrets, keys, or credentials
- Review `.gitignore` when adding new file types
- Tag releases with semantic versioning (vX.Y.Z)
