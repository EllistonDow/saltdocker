# uptime Service

- Compose file: `docker/compose.uptime.yml`
- Salt state: `docker.uptime`
- Default environment: `dev`
- Description: Uptime Kuma
- Env file: `config/env/uptime.env`

## Deployment

```bash
saltdocker deploy uptime --env dev
```

## Scaling

```bash
saltdocker scale uptime --service uptime --replicas 1
```
