docker.docusaurus:
  docker_container.running:
    - image: ghcr.io/saltdocker/docusaurus:latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: dev
    - ports:
        - "3000:3000"
