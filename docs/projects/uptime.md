# uptime 服务

Uptime Kuma 用于为各项目提供 HTTP/TCP/心跳监控。本仓库提供完全自动化的 Salt、Compose、Traefik、环境变量模板，确保 `git clone` 后即可复现以下结构。

## 组件一览
- Compose 文件：`docker/compose.uptime.yml`（仅作快速验证使用）
- Salt 状态：`salt/states/docker/uptime.sls`
- 默认环境模版：`config/env/uptime.env`（单一真相，CLI 会读取）
- Pillar 键：`services:uptime`（示例位于 `salt/pillars/projects.sls.example`）
- Traefik Host：默认 `status.saltdocker.tschenfeng.com`
- 共享网络：`saltdocker_proxy`（由 Salt state + CLI 自动创建）
- 依赖：`gateway`（CLI 会在部署前自动调用 `saltdocker deploy gateway --env <同一环境>`）
- `compose_enabled=false`：`saltdocker deploy` 只执行 Salt，避免与 Compose 重复管理。
- 健康检查：`config/projects.yml` 已声明 `health.containers = ["uptime"]`，因此 `saltdocker health uptime` 会直接通过 `docker inspect` 校验 Salt-only 容器。

## 配置步骤
1. **配置 env（推荐）**：编辑 `config/env/uptime.env`，常用键：
   ```ini
   APP_ENV=dev
   TZ=UTC
   UPTIME_KUMA_PORT=3001
   UPTIME_KUMA_HOST=0.0.0.0          # 容器监听地址
   UPTIME_PUBLIC_HOST=status.example.com  # Traefik/公网域名
   UPTIME_NETWORK=saltdocker_proxy
   UPTIME_ENTRYPOINT=websecure
   UPTIME_TLS=true
   ```
   `saltdocker deploy uptime ...` 会自动读取该文件，把值注入到临时 Pillar 并创建 Docker 网络/卷；因此无需手动修改 Pillar 文件。仍提供以下参考片段，以便想长期固化 Pillar 时复制：
   ```yaml
   services:
     uptime:
       env: dev            # 传入 APP_ENV
       host: status.saltdocker.tschenfeng.com
       bind_host: 0.0.0.0       # 可选，默认监听所有接口
        port: 3001
        tz: UTC
        volume: uptime_data
        network: saltdocker_proxy
        entrypoint: websecure
        tls: true
   ```
   Salt 状态会自动据此创建 Docker 卷 + 网络、注入环境变量、配置主机端口与 Traefik labels。
2. **本地/CI 环境变量**：同一 `config/env/uptime.env` 也被 Compose `env_file` 与 CLI 使用，确保“写一次，处处生效”。
3. **Traefik/域名**：Traefik 通过 Docker provider 自动读取容器上的 `traefik.*` label；修改 `UPTIME_PUBLIC_HOST` 或 Pillar 中的 `host` 即可换域名。`traefik/dynamic/services.yml` 仍保留兜底规则，可酌情同步。

## 部署与扩缩
- Salt 部署（推荐，也是 `saltdocker deploy` 的唯一动作）：
  ```bash
  saltdocker deploy uptime --env dev
  ```
  该命令会读取 Pillar，自动创建 `saltdocker_proxy` 网络、`uptime_data` 卷，并以 Traefik label + `restart: unless-stopped` 方式启动容器；由于 `compose_enabled=false`，不会触发 `docker compose up`。
- 手动扩缩：
  ```bash
  saltdocker scale uptime --service uptime --replicas 1
  ```
- 手动使用 Compose（仅限本地或测试）：
  ```bash
  docker compose -f docker/compose.uptime.yml up -d
  ```
  需要手动在 Compose 命令所在目录准备 `config/env/uptime.env`（相对路径为 `../config/env/uptime.env`），并确认 `saltdocker_proxy` 网络已存在（`saltdocker deploy uptime --dry-run` 或 `docker network create saltdocker_proxy`）。

## 运行检查
- 健康检查：`saltdocker health uptime --dry-run` 用于 CI，`saltdocker logs uptime --follow` 观察启动日志。
- 数据备份：`uptime_data` 为命名卷，可通过 `docker run --rm -v uptime_data:/data -v "$PWD:/backup" busybox tar czf /backup/uptime_data.tgz /data` 备份。

## CI 建议
参考 `docs/help/ci.md`，至少执行：
- `scripts/saltdocker list && scripts/saltdocker validate`
- `docker compose -f docker/compose.uptime.yml config`
- `salt-lint salt/states/docker/uptime.sls`
- `saltdocker deploy uptime --env dev --dry-run`（验证 Pillar 注入）

如需更多自动化示例，请在 PR 中同步更新本文档、`salt/pillars/projects.sls.example` 及 `config/projects.yml` 的 `networks` 字段，保持团队共识。
