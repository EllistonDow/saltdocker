docker.api:
  docker_container.running:
    - image: ghcr.io/example/api:latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: {{ pillar.get('env', 'dev') }}
    - ports:
        - "9000:9000"
