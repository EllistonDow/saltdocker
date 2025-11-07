# medusajs Service

- Compose file: `docker/compose.medusajs.yml`
- Salt state: `docker.medusajs`
- Default environment: `dev`
- Description: MedusaJS Commerce
- Env file: `config/env/medusajs.env`

## Deployment

```bash
saltdocker deploy medusajs --env dev
```

## Scaling

```bash
saltdocker scale medusajs --service medusajs --replicas 1
```
