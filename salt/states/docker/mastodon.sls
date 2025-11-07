docker.mastodon:
  docker_container.running:
    - image: ghcr.io/mastodon/mastodon:latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: dev
    - ports:
        - "3000:3000"
