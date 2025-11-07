# worker Service

- Compose file: `docker/compose.worker.yml`
- Salt states: `docker.worker`, `monitoring.worker`
- Default environment: `dev`
- Description: Async job runner consuming internal queues

## Deployment

```bash
saltdocker deploy worker --env dev
```

## Scaling

```bash
saltdocker scale worker --service worker --replicas 1
```
