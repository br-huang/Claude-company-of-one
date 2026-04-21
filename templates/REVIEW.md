# REVIEW: {feature or topic}

> Three-layer adversarial review record. Not QA — an anti-self-deception ritual.
> See ADR-001 D4 and /review command definition.

## Verdict

**{APPROVED | CHANGES REQUESTED | BLOCKED}**

- Review mode: `spec | implementation`
- Date: {UTC timestamp}
- Main Agent: {session id}
- Reviewer Agent: {session id}

---

## Layer 1: Spec Conformance

> Run by Main Agent. Hard block on failure — no Layer 2/3.

### Result

**{PASS | FAIL}**

### Traceability Matrix

| Spec Item                     | Implementation Evidence | Test Evidence | Status |
| ----------------------------- | ----------------------- | ------------- | ------ |
| REQ-1: {acceptance criterion} | {file:line or commit}   | {test path}   | ✅/❌  |
| TODO item: {required}         | {file:line}             | {test path}   | ✅/❌  |

### Scope Drift

<!-- Implementation touches outside spec, non-goal violations, silent additions. -->

- {finding or "None"}

### Documentation Consistency

<!-- Deterministic checks from docs-check.sh + spec-conformance-check.sh -->

- CHANGELOG updated & consistent with diff: {yes/no}
- TODO checkboxes consistent with delivered code: {yes/no}
- DESIGN matches implementation approach (or ADR explains delta): {yes/no}

### Hard Block Triggered

<!-- If any of the ADR-001 D4 hard-block conditions fire, list them here and STOP. -->

- {blocker or "None"}

---

## Layer 2: Red Team Review

> Run by reviewer agent reading ONLY REVIEW_INPUT.md. Does not edit code.
> Skipped if Layer 1 FAIL.

### Confirmed Findings

<!-- Evidence-backed issues. -->

#### R1. {short title}

- File: {file:line}
- Category: {spec / correctness / security / style / operational}
- Severity: {critical | high | medium | low}
- Evidence: {specific code snippet or test that demonstrates the issue}
- Impact: {what breaks / what is exposed}

### Plausible Risks

<!-- Realistic risks needing verification. NOT padded to hit a count. -->

#### P1. {short title}

- Suspected issue: {description}
- How to verify: {concrete next step}
- If confirmed, would be: {severity}

### Attack Surfaces Checked

<!-- What the reviewer inspected even if nothing was found. -->

- {surface 1}: clean
- {surface 2}: clean

### Hard Block Triggered (Layer 2)

<!-- Only these five categories auto-block, per ADR-001 D4 / spec-conformance rules. -->

- Secret exposure: {y/n}
- Injection vulnerability with evidence: {y/n}
- Auth/permission bypass: {y/n}
- Destructive data loss path: {y/n}
- Remote code execution path: {y/n}

---

## Layer 3: Critique Dialogue

> Main Agent MUST respond to every Layer 2 finding. Dispositions are
> mandatory; `rejected` requires evidence.

| Finding | Disposition                                          | Developer Response / Evidence | Resolution       |
| ------- | ---------------------------------------------------- | ----------------------------- | ---------------- |
| R1      | accepted / rejected / deferred / needs-user-decision | {rationale}                   | {commit or TODO} |
| P1      | ...                                                  | ...                           | ...              |

### needs-user-decision Budget

<!-- Max 2 per session per /review run. Escalate to user explicitly. -->

- Count: {n}/2

---

## Blocker Classification

| Class        | Items from above                                    | Action                     |
| ------------ | --------------------------------------------------- | -------------------------- |
| Hard Block   | Spec Conformance FAIL / Layer 2 critical categories | Blocks commit              |
| Soft Block   | Layer 2 high-severity plausible risks               | Requires user confirmation |
| Non-blocking | Style, alt. implementation, future extensibility    | Recorded; does not block   |

## Final Decision

{One short paragraph from the developer: accept verdict, merge readiness,
any follow-up TODOs. Not a victory lap — the record of what was accepted.}

## Follow-up TODOs

- [ ] {item carried forward to TODO.md or a new issue}
