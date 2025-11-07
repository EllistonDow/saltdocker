# Module Notes

- **Salt states** live under `salt/states/<domain>.sls` with the naming scheme captured in `config/projects.yml`.
- **Traefik snippets** belong in `traefik/dynamic/<project>.yml` and are referenced by the same project keys.
- **Monitoring hooks** (Prometheus, Alertmanager, log shippers) should expose a reusable state (e.g. `monitoring.worker`) so multiple projects can reuse the pattern.
- **Templates** for new modules go in `templates/module/` (create this directory when the first template ships) and should include Compose + Salt skeletons plus documentation pointers.
- **CLI scaffolding** via `saltdocker init` populates Compose/Salt/doc files using `templates/project/`. Update those templates when module expectations change so every new project inherits the improvements automatically.
- **Validation** – `saltdocker validate` ensures module docs + states exist. Run it whenever you touch `config/projects.yml` to catch mismatches early.

Document any shared assumptions (ports, secrets, required grains/pillars) directly inside each module file and cross-link back to this note for discoverability.
