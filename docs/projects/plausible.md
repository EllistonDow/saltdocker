# plausible Service

- Compose file: `docker/compose.plausible.yml`
- Salt state: `docker.plausible`
- Default environment: `dev`
- Description: Plausible Analytics
- Env file: `config/env/plausible.env`

## Deployment

```bash
saltdocker deploy plausible --env dev
```

## Scaling

```bash
saltdocker scale plausible --service plausible --replicas 1
```
