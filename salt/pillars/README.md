# Pillar Overview

- Copy `projects.sls.example` to `projects.sls` and replace placeholder secrets with your real values.
- Mount the pillar through `top.sls` so minions handling Docker deployments receive the `services:*` keys.
- Keep real secrets out of git; rely on Vault/Consul ext_pillar for production.
