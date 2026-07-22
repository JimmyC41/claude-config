# Coding

For workers implementing code, and for the dictator when reviewing a diff.

## Build

Write the simplest correct implementation of the requested behaviour.

Prefer:

- Direct and explicit control flow
- Existing repository patterns
- Standard language and library features
- Validation at external or untrusted boundaries

Avoid:

- Speculative abstractions or flexibility
- Defensive branches for states excluded by existing contracts
- Error handling that cannot recover, translate, or add necessary context
- Comments that restate the code
- Unrelated refactoring

## Subtract

For each helper, abstraction, branch, guard, catch, comment, and dependency:

- Identify the requirement, failure mode, or clarity benefit that justifies it
- Remove it if the implementation remains correct and at least as clear without it

## Verify

The implementation is complete when:

- The main path is direct and easy to trace
- Every branch and error path has a current justification
- Comments explain non-obvious reasons or constraints, not what the code does
- Further removal would break required behaviour or reduce clarity