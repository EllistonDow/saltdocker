docker.saleor:
  docker_container.running:
    - image: saleor/saleor:latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: dev
    - ports:
        - "8000:8000"
