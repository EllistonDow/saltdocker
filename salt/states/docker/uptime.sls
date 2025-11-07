docker.uptime:
  docker_container.running:
    - image: louislam/uptime-kuma:latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: dev
    - ports:
        - "3001:3001"
