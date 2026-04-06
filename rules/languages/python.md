---
name: python-rules
description: "Python-specific coding rules and conventions."
---

# Python Rules

## Type Hints
- Use type hints for all function signatures
- Use `from __future__ import annotations` for modern syntax
- Prefer `str | None` over `Optional[str]` (Python 3.10+)
- Use `TypedDict` for dictionary shapes
- Use `Protocol` for structural typing (duck typing with type safety)

## Patterns
- Follow PEP 8 style guidelines
- Use f-strings for string formatting
- Prefer list/dict/set comprehensions over `map`/`filter`
- Use `pathlib.Path` over `os.path`
- Use context managers (`with`) for resource management
- Prefer `dataclasses` or `pydantic` models over plain dicts

## Error Handling
- Use specific exception types, not bare `except:`
- Never catch `Exception` without re-raising or logging
- Use custom exception classes for domain errors
- Prefer `raise ... from ...` to preserve exception chains

## Project Structure
- Use `pyproject.toml` for project configuration
- Use virtual environments (`venv` or `uv`)
- Pin dependency versions in lock files
- Organize packages with `__init__.py`

## Testing
- Use `pytest` (not unittest)
- Use fixtures for test setup
- Use `pytest.raises` for exception testing
- Use `pytest.mark.parametrize` for test variations
- Mock external services with `pytest-mock` or `responses`
