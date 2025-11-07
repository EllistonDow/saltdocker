# Troubleshooting

## Salt-related
- `salt-call --local test.ping` – verify the minion can execute states locally.
- `saltdocker deploy <project> --dry-run` – preview Salt + Compose commands to confirm metadata is correct.
- When states fail, rerun with `-l debug` (e.g., `salt-call --local state.apply docker.api -l debug`).

## Docker/Compose
- `saltdocker status <project>` for a quick `docker compose ps` snapshot.
- `saltdocker logs <project> --follow` to stream logs; add `--service` to narrow scope.
- If Compose complains about missing files, check that `config/projects.yml` points to the intended path and that scaffolding (`saltdocker init`) ran successfully.
- Run `saltdocker validate` after large refactors to find missing compose/state/doc artifacts.
- Use `saltdocker health <project>` to fail fast when containers exit or report `unhealthy` statuses; pair with `--compose-override` if you test prod overrides locally.

## Metadata
- Run `yamllint config/projects.yml` after manual edits.
- Keep `docs/projects/<project>.md` updated so the menu and docs stay in sync.
- When removing projects, delete both the YAML entry and associated compose/state/doc files to prevent stale menu entries.
- Prefer `saltdocker prune <project>` to delete entries + artifacts atomically when sunsetting a service.
