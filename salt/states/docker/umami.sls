docker.umami:
  docker_container.running:
    - image: ghcr.io/umami-software/umami:postgresql-latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: dev
    - ports:
        - "3000:3000"
