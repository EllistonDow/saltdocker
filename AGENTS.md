# Repository Guidelines

## Project Structure & Module Organization
Place runtime code inside `src/`, organized by feature (for example, `src/orchestrator/` for Salt runners and `src/api/` for lightweight services). Salt state files belong under `salt/states/` and companion pillars under `salt/pillars/`. Docker build assets (Dockerfiles, entrypoints, compose overrides) stay in `docker/`, while operational assets (Helm charts, Terraform, k8s manifests) live in `deploy/`. Keep reusable scripts in `scripts/` and document any data fixtures or mock payloads inside `tests/fixtures/` so agents can discover them quickly.

## Build, Test, and Development Commands
Use `make bootstrap` after cloning to install Python tooling, Salt dependencies, and pre-commit hooks. Run `docker compose up api worker` for the default dev stack, and `docker compose -f docker/compose.test.yml run --rm test-runner` for CI-parity checks. Execute Salt locally with `salt-call --local state.apply <state_name>` when validating new states, or use `scripts/saltdocker deploy <project>` to run the curated Salt + Compose workflow. Package and publish containers via `make image TAG=feature-123` followed by `make push TAG=feature-123` once tests pass.

## Coding Style & Naming Conventions
Follow Black + isort formatting for Python, enforced through `make lint`. YAML (Salt, Docker, Helm) must be 2-space indented with keys sorted for determinism. Name Salt states using `role.feature` (e.g., `api.bluegreen`) and Docker images `org/service:tag`. New modules should expose typed interfaces and log via the shared `logging_config.py` helper. Shell scripts must be POSIX sh with `set -euo pipefail` at the top.

## Testing Guidelines
Unit tests live in `tests/unit/` and mirror the `src/` tree, while integration tests use `pytest` + `testinfra` inside `tests/integration/`. Name tests `test_<behavior>` and tag smoke paths with `@pytest.mark.smoke` so `pytest -m smoke` stays fast. Target ≥85% line coverage (`pytest --cov=src --cov-report=xml`). For Salt states, add idempotence checks in `tests/yaml/` and run `salt-lint`. Update `tests/fixtures/` when changing default pillars.

## Commit & Pull Request Guidelines
Write commits in imperative tense with a scoped prefix, e.g., `salt: tighten api state`. Group related file changes together; avoid “misc fixes”. Every PR should include: summary, testing notes (commands run, exit status), linked issue or task ID, and screenshots/log excerpts for UI or observability changes. Request at least one reviewer familiar with the touched area and wait for CI green before merging.

## Security & Configuration Tips
Store secrets in `.sls` vault references or environment variables managed by `docker/.env.example`; never commit plaintext secrets. Rotate service tokens quarterly and document rotations in `docs/security.md`. When adding network-facing services, include threat notes in the PR and ensure `docker/compose.prod.yml` sets least-privilege ports.

## Agent Toolkit
`scripts/saltdocker` is the canonical entrypoint for orchestrating stacks—use `list`, `deploy`, `status`, `logs`, `validate`, `bump-image`, `prune`, and `init` before writing ad-hoc compose commands. Supporting docs live under `docs/help/` (menu, troubleshooting, CI, security), while per-project briefs sit in `docs/projects/`. Keep these references current whenever you scaffold, rename, or retire a service so future agents can self-serve quickly.

Environment templates live in `config/env/`. Copy them, inject secrets, or render them through Salt pillars before running `saltdocker deploy`. Never commit real secrets back into git—use placeholders locally and rely on Vault/ext_pillar for production.
