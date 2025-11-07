# Project Catalog

Each Docker/Compose project is registered in `config/projects.yml` and surfaced through `saltdocker list`. Update the YAML when adding, modifying, or removing stacks.

## api
- Compose file: `docker/compose.api.yml`
- Salt states: `docker.api`, `traefik.api`
- Traefik host: `api.local.salt`
- Default environment: `dev`
- Scaling guardrails: 1–6 replicas (default 2)

## worker
- Compose file: `docker/compose.worker.yml`
- Salt states: `docker.worker`, `monitoring.worker`
- Default environment: `dev`
- Scaling guardrails: 1–10 replicas (default 1)

## gateway
- Compose file: `docker/compose.gateway.yml`
- Salt states: `traefik.gateway`, `observability.gateway`
- Default environment: `prod`
- Scaling guardrails: 1–2 replicas (default 1)

## payments
- Compose file: `docker/compose.payments.yml`
- Salt state: `docker.payments`
- Default environment: `dev` (supports dev/staging/prod via CLI flags)
- Scaling guardrails: 1–5 replicas (default 2)
- Traefik host: `pay.local.salt`

## mattermost
- Compose file: `docker/compose.mattermost.yml`
- Salt state: `docker.mattermost`
- Default environment: `dev` (dev/staging/prod available)
- Scaling guardrails: 1–3 replicas (default 1)
- Traefik host: `mm.local.salt`

## uptime
- Compose file: `docker/compose.uptime.yml`
- Salt state: `docker.uptime`
- Default environment: `dev` (dev/prod available)
- Scaling guardrails: 1–2 replicas (default 1)
- Traefik host: `status.local.salt`

## discourse
- Compose file: `docker/compose.discourse.yml`
- Salt state: `docker.discourse`
- Default environment: `dev` (dev/staging/prod available)
- Scaling guardrails: 1–3 replicas (default 1)
- Traefik host: `community.local.salt`

## docusaurus
- Compose file: `docker/compose.docusaurus.yml`
- Salt state: `docker.docusaurus`
- Default environment: `dev` (dev/prod available)
- Scaling guardrails: 1–4 replicas (default 1)
- Traefik host: `docs.local.salt`

## mastodon
- Compose file: `docker/compose.mastodon.yml`
- Salt state: `docker.mastodon`
- Default environment: `dev` (dev/staging/prod available)
- Scaling guardrails: 1–3 replicas (default 1)
- Traefik host: `mastodon.local.salt`

## saleor
- Compose file: `docker/compose.saleor.yml`
- Salt state: `docker.saleor`
- Default environment: `dev` (dev/staging/prod available)
- Scaling guardrails: 1–5 replicas (default 2)
- Traefik host: `shop.local.salt`

## medusajs
- Compose file: `docker/compose.medusajs.yml`
- Salt state: `docker.medusajs`
- Default environment: `dev` (dev/staging/prod available)
- Scaling guardrails: 1–4 replicas (default 1)
- Traefik host: `medusa.local.salt`

Add new sections following the same template when registering fresh projects.

Use `saltdocker init <project>` to scaffold compose/state/doc files and automatically append new entries to `config/projects.yml`. Commit both the generated assets and the updated YAML so the CLI and docs stay synchronized.

Remember to populate `config/env/<project>.env` (or render it via Salt pillars) before deploying stacks that depend on external databases or object storage.
