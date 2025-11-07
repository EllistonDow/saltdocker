docker.discourse:
  docker_container.running:
    - image: bitnami/discourse:latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: dev
    - ports:
        - "8081:8081"
