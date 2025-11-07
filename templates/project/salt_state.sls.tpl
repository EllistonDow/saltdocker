{{state_name}}:
  docker_container.running:
    - image: {{image}}
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: {{default_env}}
    - ports:
        - "{{port}}:{{port}}"
