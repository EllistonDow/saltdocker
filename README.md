# Saltdocker Toolkit

Opinionated helper scripts and docs for running modular Docker/Docker Compose projects managed by Salt.

## Quickstart
1. Install dependencies (Python 3.10+, PyYAML, Salt, Docker Compose v2).
2. Run the CLI from repo root with `./scripts/saltdocker list` (or add `scripts/` to your `PATH`).
3. Copy env templates from `config/env/*.env` and fill in secrets (or render via Salt pillars).
4. Deploy a stack: `./scripts/saltdocker deploy api --env staging --pillar domain=staging.example.com`.
5. Tail logs or check status with `./scripts/saltdocker logs api --follow` and `./scripts/saltdocker status api`.
6. Run `./scripts/saltdocker health api` after deployments to ensure containers are healthy.
7. Audit metadata anytime via `./scripts/saltdocker validate` (or `./scripts/saltdocker menu` for a cheat sheet).
8. 完成需求后执行 `./scripts/check.sh`，自动跑 lint/validate/compose config，确保代码随时可合并。
9. 需要提交+推送时用 `./scripts/git-release.sh "feat: xxx"`：它会调用 `scripts/check.sh`、`git add -A`、根据 commit message 推断 tag bump（`feat` → 次版本、`breaking!` → 主版本、其他 → 补丁）并 `git push`。可用 `BUMP=minor ./scripts/git-release.sh` 强制级别，或用 `DRY_RUN=1` 仅预览。

## CLI Usage
- Local invocation: `./scripts/saltdocker <command>` works anywhere because the script uses absolute paths under `/root/saltdocker`.
- Install globally: `./scripts/saltdocker install-cli --destination /usr/local/bin/saltdocker` (or add `scripts/` to your `PATH`). Use `--copy` if symlinks are restricted and `--force` to overwrite an existing binary.
- Menu/help: `./scripts/saltdocker --help` now prints a quick-reference table; `./scripts/saltdocker menu` renders the same table plus the registered project list.
- Provision sudo users: `./scripts/saltdocker add-sudo-user deployer --ssh-key ~/.ssh/id_rsa.pub --force` (must run as root; add `--passwordless-sudo` to drop a `/etc/sudoers.d/` entry, `--sudoers-dir` to override the drop-in path).
- Manage fleet installs via Salt: include the `tooling.saltdocker_cli` state and set pillar `saltdocker:root: /opt/saltdocker` (or whichever clone path) to keep `/usr/local/bin/saltdocker` pointing at the repo automatically.
- Need completions or shell aliases? Add `alias saltdocker=./scripts/saltdocker` to your shell profile or export `PATH=$PATH:/root/saltdocker/scripts`.

## Scaffolding New Projects
Use `scripts/saltdocker init payments --description "Payments API" --image ghcr.io/org/pay:latest --traefik-host pay.example.com` to:
- Create `docker/compose.payments.yml` from templates.
- Generate `salt/states/docker/payments.sls`.
- Write `docs/projects/payments.md`.
- Append metadata to `config/projects.yml` (with scaling limits, environments, and optional Traefik hints).

Override defaults with flags like `--service-name`, `--port`, `--env staging --env prod`, `--default-scale 2`, `--max-scale 5`, or `--compose-file docker/custom.yml`. Use `--force-files`/`--force-config` cautiously.

## Maintenance Commands
- `scripts/saltdocker validate` – ensure compose/state/doc files exist for every catalog entry.
- `scripts/saltdocker prune <project>` – remove a project from `config/projects.yml` and optionally delete its artifacts.
- `scripts/saltdocker bump-image <project> --image ghcr.io/...` or `bump-image-bulk --set project=image` – update image tags across Compose + Salt states.
- `scripts/saltdocker health <project>` – fail fast if any container is exited/unhealthy.
- Supply env overrides via `--env-var KEY=VALUE` or compose overrides with `--compose-override docker/compose.prod.yml` when running deploy/remove/scale/status/logs/health.

## Repository Layout
- `scripts/saltdocker` – CLI entrypoint.
- `config/projects.yml` – canonical project catalog used by the CLI and docs.
- `templates/project` – source templates for Compose, Salt states, and docs.
- `docs/` – help menus, troubleshooting, per-project briefs, and module notes.
- `salt/`, `docker/`, `traefik/` – contain states, compose files, and dynamic routing examples.
- `config/env/` – env templates consumed by Compose (generate real values with Salt pillars or secrets tooling).

See `docs/help/security.md` for secret-handling expectations, `docs/help/ci.md` for a sample pipeline, `docs/help/services.md` for dependency notes, and `docs/help/traefik.md` for routing/TLS guidance.

Refer to `AGENTS.md` for contribution norms and coding conventions.
