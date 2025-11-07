# Security & Configuration Checklist

1. **Secrets** – Store secrets in Vault (preferred) or encrypted Pillars. Reference them via `{{ pillar.get('secrets:db_password') }}` and never write cleartext values into Compose or Salt state files; the `config/env/*.env` templates are placeholders only.
2. **Traefik** – Keep TLS certificates and ACME storage outside the repo. Mount secrets through Docker/Swarm/K8s secret stores, not baked into images.
3. **Salt Targeting** – Restrict high-risk states (Traefik, Observability) with grains targeting so only edge nodes receive them.
4. **Docker Socket Exposure** – Only Traefik or trusted controllers should mount `/var/run/docker.sock`, and the state should enforce `mode: 0440` when possible.
5. **Image Provenance** – Use `saltdocker bump-image` alongside signed container images (Cosign, Notary) and document the signature policy per service.
6. **Audit Trails** – Run `saltdocker validate` in CI, emit results to build logs, and archive rendered `config/projects.yml` diffs for traceability.
7. **Rotation** – Schedule quarterly reviews of Vault leases, API keys, and Traefik static credentials; log rotations in `docs/security.md` with dates and owners.
