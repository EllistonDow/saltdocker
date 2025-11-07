observability.gateway:
  docker_container.running:
    - image: ghcr.io/example/observability:latest
    - restart_policy: unless-stopped
