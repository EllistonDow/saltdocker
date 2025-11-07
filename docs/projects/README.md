# 项目目录

所有 Docker/Compose 项目都定义在 `config/projects.yml`，并通过 `saltdocker list` 列出。新增或修改服务时记得同步这份 YAML。

> 说明：部分示例 Compose/Salt 文件仍使用 `ghcr.io/example/...` 之类的镜像占位符——这些是脚手架生成的默认值，实际部署前请替换成你们自己的镜像地址。

## api
- Compose 文件：`docker/compose.api.yml`
- Salt 状态：`docker.api`, `traefik.api`
- Traefik 域名：`api.local.salt`
- 默认环境：`dev`
- 扩缩边界：1–6 replicas (default 2)

## worker
- Compose 文件：`docker/compose.worker.yml`
- Salt 状态：`docker.worker`, `monitoring.worker`
- 默认环境：`dev`
- 扩缩边界：1–10 replicas (default 1)

## gateway
- Compose 文件：`docker/compose.gateway.yml`
- Salt 状态：`traefik.gateway`
- 默认环境：`prod`
- 扩缩边界：1–2 replicas (default 1)

## payments
- Compose 文件：`docker/compose.payments.yml`
- Salt 状态：`docker.payments`
- 默认环境：`dev` (supports dev/staging/prod via CLI flags)
- 扩缩边界：1–5 replicas (default 2)
- Traefik 域名：`pay.local.salt`

## mattermost
- Compose 文件：`docker/compose.mattermost.yml`
- Salt 状态：`docker.mattermost`
- 默认环境：`dev` (dev/staging/prod available)
- 扩缩边界：1–3 replicas (default 1)
- Traefik 域名：`mm.local.salt`

## uptime
- Compose 文件：`docker/compose.uptime.yml`
- Salt 状态：`docker.uptime`
- 默认环境：`dev` (dev/prod available)
- 扩缩边界：1–2 replicas (default 1)
- Traefik 域名：`status.local.salt`

## discourse
- Compose 文件：`docker/compose.discourse.yml`
- Salt 状态：`docker.discourse`
- 默认环境：`dev` (dev/staging/prod available)
- 扩缩边界：1–3 replicas (default 1)
- Traefik 域名：`community.local.salt`

## docusaurus
- Compose 文件：`docker/compose.docusaurus.yml`
- Salt 状态：`docker.docusaurus`
- 默认环境：`dev` (dev/prod available)
- 扩缩边界：1–4 replicas (default 1)
- Traefik 域名：`docs.local.salt`

## mastodon
- Compose 文件：`docker/compose.mastodon.yml`
- Salt 状态：`docker.mastodon`
- 默认环境：`dev` (dev/staging/prod available)
- 扩缩边界：1–3 replicas (default 1)
- Traefik 域名：`mastodon.local.salt`

## saleor
- Compose 文件：`docker/compose.saleor.yml`
- Salt 状态：`docker.saleor`
- 默认环境：`dev` (dev/staging/prod available)
- 扩缩边界：1–5 replicas (default 2)
- Traefik 域名：`shop.local.salt`

## medusajs
- Compose 文件：`docker/compose.medusajs.yml`
- Salt 状态：`docker.medusajs`
- 默认环境：`dev` (dev/staging/prod available)
- 扩缩边界：1–4 replicas (default 1)
- Traefik 域名：`medusa.local.salt`

Add new sections following the same template when registering fresh projects.

Use `saltdocker init <project>` to scaffold compose/state/doc files and automatically append new entries to `config/projects.yml`. Commit both the generated assets and the updated YAML so the CLI and docs stay synchronized.

Remember to populate `config/env/<project>.env` (or render it via Salt pillars) before deploying stacks that depend on external databases or object storage.
