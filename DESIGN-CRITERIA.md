# Design

For the dictator. Apply after interviewing the user, when the goal is locked and you are making architectural decisions or writing an implementation plan for workers.

## Build

Propose the smallest coherent design that satisfies the current requirements.

Prefer:

- Direct control and data flow
- Explicit state ownership
- Existing repository patterns
- Standard language and library features

Avoid:

- Abstractions for hypothetical reuse
- New dependencies when existing tools are sufficient
- Infrastructure or configuration without a current requirement

## Subtract

For each component, abstraction, layer, dependency, and configuration option:

- Identify the requirement or constraint that justifies it
- Remove or merge it if the design can still satisfy the requirements clearly

## Verify

The design is complete when:

- Every remaining element has a current justification
- Data flow and state ownership can be explained directly
- Further removal would violate a requirement or make the design harder to understand