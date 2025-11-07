docker.payments:
  docker_container.running:
    - image: ghcr.io/saltdocker/payments:v2
  - restart_policy: unless-stopped
  - environment:
      APP_ENV: dev
  - ports:
    - 8080:8080
