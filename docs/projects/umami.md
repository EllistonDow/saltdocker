# umami Service

- Compose file: `docker/compose.umami.yml`
- Salt state: `docker.umami`
- Default environment: `dev`
- Description: Umami Analytics
- Env file: `config/env/umami.env`

## Deployment

```bash
saltdocker deploy umami --env dev
```

## Scaling

```bash
saltdocker scale umami --service umami --replicas 1
```
