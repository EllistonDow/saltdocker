docker.payments:
  docker_container.running:
  - image: ghcr.io/example/payments:v2
  - restart_policy: unless-stopped
  - environment:
      APP_ENV: dev
  - ports:
    - 8080:8080
