# Testing

For workers writing tests, and for the dictator when reviewing a diff.

## Build

Write the smallest set of tests that verifies the changed behaviour.

Prefer:

- Testing observable behaviour through public interfaces
- Covering the main path and each materially different outcome
- Adding a regression test for a bug being fixed
- Deterministic inputs and minimal setup
- Mocking only external or uncontrollable boundaries

Avoid:

- Testing private methods or internal call structure
- Duplicate cases that verify the same behaviour
- Hypothetical edge cases without a requirement or known failure
- Excessive fixtures, mocks, and shared setup
- Tests added only to increase coverage

## Subtract

For each test, fixture, mock, setup helper, and assertion:

- Identify the unique behaviour, material failure, or regression it verifies
- Remove it if that behaviour is already verified elsewhere

## Verify

The test suite is complete when:

- Each changed requirement is verified
- Each material failure path introduced by the change is verified
- Every remaining test protects a distinct behaviour or regression
- Further removal would leave required behaviour unverified