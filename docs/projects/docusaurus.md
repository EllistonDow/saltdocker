# docusaurus Service

- Compose file: `docker/compose.docusaurus.yml`
- Salt state: `docker.docusaurus`
- Default environment: `dev`
- Description: Docusaurus Docs

## Deployment

```bash
saltdocker deploy docusaurus --env dev
```

## Scaling

```bash
saltdocker scale docusaurus --service docusaurus --replicas 1
```
