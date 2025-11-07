docker.medusajs:
  docker_container.running:
    - image: medusajs/medusa:latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: dev
    - ports:
        - "9000:9000"
