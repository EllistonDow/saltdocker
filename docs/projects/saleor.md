# saleor Service

- Compose file: `docker/compose.saleor.yml`
- Salt state: `docker.saleor`
- Default environment: `dev`
- Description: Saleor Commerce
- Env file: `config/env/saleor.env`

## Deployment

```bash
saltdocker deploy saleor --env dev
```

## Scaling

```bash
saltdocker scale saleor --service saleor --replicas 2
```
