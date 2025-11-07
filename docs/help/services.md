# Service Dependency Matrix

| Service    | Dependencies                             | Secrets/Env File                |
|----------- |------------------------------------------|---------------------------------|
| Mattermost | Postgres, MinIO                          | `config/env/mattermost.env`     |
| Mastodon   | Postgres, Redis                          | `config/env/mastodon.env`       |
| Saleor     | Postgres, Redis, Celery worker           | `config/env/saleor.env`         |
| MedusaJS   | Postgres, Redis, background worker       | `config/env/medusajs.env`       |
| Discourse  | Postgres, Redis                          | `config/env/discourse.env`      |
| Uptime     | Volume-backed sqlite                     | `config/env/uptime.env`         |
| Docusaurus | Builder (Node) + nginx static host       | n/a                             |

- Compose files declare volumes for data durability; ensure host paths or Docker volumes are backed up.
- Environment templates live in `config/env/`. Copy them, fill secrets, or use Salt pillars to render them before running `saltdocker deploy`.
- When adding new services, document dependencies here so operators know which databases/message queues must be provisioned.
