docker.plausible:
  docker_container.running:
    - image: plausible/analytics:latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: dev
    - ports:
        - "8000:8000"
