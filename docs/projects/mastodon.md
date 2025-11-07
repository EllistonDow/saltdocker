# mastodon Service

- Compose file: `docker/compose.mastodon.yml`
- Salt state: `docker.mastodon`
- Default environment: `dev`
- Description: Mastodon Social
- Env file: `config/env/mastodon.env`

## Deployment

```bash
saltdocker deploy mastodon --env dev
```

## Scaling

```bash
saltdocker scale mastodon --service mastodon --replicas 1
```
