# gateway 服务

- Compose 文件：`docker/compose.gateway.yml`
- Salt 状态：`traefik.gateway`
- 默认环境：`prod`
- 描述：Traefik 反向代理入口
- Env 文件：`config/env/gateway.env`（配置 `TRAEFIK_ACME_EMAIL`）

## 部署

```bash
saltdocker deploy gateway --env prod
```

默认开启 HTTP→HTTPS 重定向与 ACME TLS-ALPN 证书签发，只需在 `config/env/gateway.env` 中填好邮箱即可。

## 扩缩

```bash
saltdocker scale gateway --service traefik --replicas 1
```
