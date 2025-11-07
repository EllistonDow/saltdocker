# {{project}} Service

- Compose file: `{{compose_file}}`
- Salt state: `{{salt_state}}`
- Default environment: `{{default_env}}`
- Description: {{description}}
- Env file: `config/env/{{project}}.env`

## Deployment

```bash
saltdocker deploy {{project}} --env {{default_env}}
```

## Scaling

```bash
saltdocker scale {{project}} --service {{service_name}} --replicas {{default_scale}}
```
