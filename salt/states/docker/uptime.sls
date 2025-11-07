{%- set uptime_env = pillar.get('services:uptime:env', pillar.get('env', 'dev')) -%}
{%- set uptime_host = pillar.get('services:uptime:host', 'status.saltdocker.tschenfeng.com') -%}
{%- set uptime_bind_host = pillar.get('services:uptime:bind_host', '0.0.0.0') -%}
{%- set uptime_port = pillar.get('services:uptime:port', 3001) -%}
{%- set uptime_timezone = pillar.get('services:uptime:tz', 'UTC') -%}
{%- set uptime_volume = pillar.get('services:uptime:volume', 'uptime_data') -%}
{%- set uptime_network = pillar.get('services:uptime:network', 'saltdocker_proxy') -%}
{%- set uptime_entrypoint = pillar.get('services:uptime:entrypoint', 'websecure') -%}
{%- set uptime_tls = pillar.get('services:uptime:tls', True) -%}

{{ uptime_network }}_network:
  docker_network.present:
    - name: {{ uptime_network }}
    - driver: bridge

{{ uptime_volume }}_volume:
  docker_volume.present:
    - name: {{ uptime_volume }}

docker.uptime:
  docker_container.running:
    - name: uptime
    - image: louislam/uptime-kuma:latest
    - restart_policy: unless-stopped
    - environment:
        APP_ENV: {{ uptime_env }}
        UPTIME_KUMA_HOST: {{ uptime_bind_host }}
        UPTIME_KUMA_PORT: {{ uptime_port }}
        TZ: {{ uptime_timezone }}
    - labels:
        traefik.enable: "true"
        traefik.http.routers.uptime.rule: "Host(`{{ uptime_host }}`)"
        traefik.http.routers.uptime.entrypoints: {{ uptime_entrypoint }}
        traefik.http.routers.uptime.tls: "{{ 'true' if uptime_tls else 'false' }}"
        traefik.http.routers.uptime.service: uptime
        traefik.http.services.uptime.loadbalancer.server.port: "3001"
        traefik.docker.network: {{ uptime_network }}
    - ports:
        - 3001
    - port_bindings:
        3001/tcp:
          HostPort: "{{ uptime_port }}"
    - networks:
        - {{ uptime_network }}
    - binds:
        - {{ uptime_volume }}:/app/data
    - require:
        - docker_network: {{ uptime_network }}_network
        - docker_volume: {{ uptime_volume }}_volume
