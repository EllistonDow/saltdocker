docker.worker:
  docker_container.running:
    - image: ghcr.io/saltdocker/worker:latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: {{ pillar.get('env', 'dev') }}
        QUEUE_URL: {{ pillar.get('queue_url', 'redis://redis:6379/0') }}
