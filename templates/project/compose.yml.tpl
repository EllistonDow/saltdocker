version: '3.9'
services:
  {{service_name}}:
    image: {{image}}
    restart: unless-stopped
    env_file:
      - config/env/{{project}}.env
    environment:
      APP_ENV: {{default_env}}
    ports:
      - "{{port}}:{{port}}"
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.{{project}}.rule=Host(`{{traefik_host}}`)"
      - "traefik.http.routers.{{project}}.entrypoints={{traefik_entrypoint}}"
      - "traefik.http.services.{{project}}.loadbalancer.server.port={{port}}"
