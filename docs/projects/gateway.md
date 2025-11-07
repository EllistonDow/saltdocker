# gateway Service

- Compose file: `docker/compose.gateway.yml`
- Salt states: `traefik.gateway`, `observability.gateway`
- Default environment: `prod`
- Description: Edge Traefik + support services

## Deployment

```bash
saltdocker deploy gateway --env prod
```

## Scaling

```bash
saltdocker scale gateway --service traefik --replicas 1
```
