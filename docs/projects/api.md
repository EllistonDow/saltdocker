# api Service

- Compose file: `docker/compose.api.yml`
- Salt states: `docker.api`, `traefik.api`
- Default environment: `dev`
- Description: Public REST gateway with Traefik exposure

## Deployment

```bash
saltdocker deploy api --env dev
```

## Scaling

```bash
saltdocker scale api --service api --replicas 2
```
