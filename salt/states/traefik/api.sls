traefik.api:
  file.managed:
    - name: /etc/traefik/dynamic/api.yml
    - source: salt://traefik/dynamic/api.yml
    - user: root
    - group: root
    - mode: "0640"
