# Saltdocker Menu

Use `saltdocker` to orchestrate Docker Compose stacks plus Salt states.

## Core Commands

- `saltdocker menu` – quick reference (this file).
- `saltdocker list` – show every registered project from `config/projects.yml`.
- `saltdocker describe <project>` – dump metadata (compose file, Salt states, environments, scaling limits).
- `saltdocker deploy <project> [--env staging]` – run Salt states then `docker compose up -d`.
- `saltdocker scale <project> --service api --replicas 3` – enforce scaling limits.
- `saltdocker remove <project> [--purge-volumes]` – shut down stack and optionally delete volumes.
- `saltdocker status <project>` – show `docker compose ps` output for quick health checks.
- `saltdocker logs <project> [--service api] [--follow]` – stream container logs through compose.
- `saltdocker init <project>` – scaffold compose/state/doc files and inject metadata into `config/projects.yml`.
- `saltdocker validate` – confirm compose/state/doc assets exist for every registered project.
- `saltdocker prune <project>` – remove a project from metadata and optionally delete files.
- `saltdocker bump-image <project> --image ghcr.io/...` – update Compose + Salt state image tags in one command.
- `saltdocker bump-image-bulk --set api=ghcr.io/... --set worker=...` – mass-update multiple services at once.
- `saltdocker health <project>` – run `docker compose ps --format json` and fail if containers are exited/unhealthy.

## Usage Examples

```bash
saltdocker list
saltdocker deploy api --env staging
saltdocker scale worker --service worker --replicas 4
saltdocker remove gateway --purge-volumes --dry-run
saltdocker status api
saltdocker logs api --service api --tail 50 --follow
saltdocker init payments --description "Payments API" --image ghcr.io/org/pay:latest --traefik-host pay.example.com
saltdocker validate
saltdocker prune payments --keep-files
saltdocker bump-image payments --image ghcr.io/org/payments:v2
saltdocker bump-image-bulk --set api=ghcr.io/org/api:v2 --set worker=ghcr.io/org/worker:v2
saltdocker health gateway --compose-override docker/compose.prod.yml
```

## Troubleshooting

- Run `saltdocker describe <project>` to confirm compose files and Salt state names.
- Ensure `salt-call` and `docker compose` are available on `$PATH` before running deploy/remove/scale.
- Use `--dry-run` to preview commands before touching infrastructure.
- Inspect the rendered metadata file `config/projects.yml` under version control to keep the menu accurate.
- When scaffolding, pass `--force-files` or `--force-config` only if you really want to overwrite existing assets; both options are skipped by default to keep changes intentional.
- `--env-var KEY=VALUE` injects temporary environment overrides into Compose commands; `--compose-override docker/compose.prod.yml` layers additional files the same way CI/CD would.
