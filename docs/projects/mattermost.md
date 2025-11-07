# mattermost Service

- Compose file: `docker/compose.mattermost.yml`
- Salt state: `docker.mattermost`
- Default environment: `dev`
- Description: Mattermost Team Edition
- Env file: `config/env/mattermost.env`

## Deployment

```bash
saltdocker deploy mattermost --env dev
```

## Scaling

```bash
saltdocker scale mattermost --service mattermost --replicas 1
```
