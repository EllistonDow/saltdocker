# discourse Service

- Compose file: `docker/compose.discourse.yml`
- Salt state: `docker.discourse`
- Default environment: `dev`
- Description: Discourse Community
- Env file: `config/env/discourse.env`

## Deployment

```bash
saltdocker deploy discourse --env dev
```

## Scaling

```bash
saltdocker scale discourse --service discourse --replicas 1
```
