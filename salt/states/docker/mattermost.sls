docker.mattermost:
  docker_container.running:
    - image: mattermost/mattermost-team-edition:latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: dev
    - ports:
        - "8065:8065"
