# payments Service

- Compose file: `docker/compose.payments.yml`
- Salt state: `docker.payments`
- Default environment: `dev`
- Description: Payments API

## Deployment

```bash
saltdocker deploy payments --env dev
```

## Scaling

```bash
saltdocker scale payments --service payments --replicas 2
```
