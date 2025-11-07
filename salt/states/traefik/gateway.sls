traefik.gateway:
  file.directory:
    - name: /etc/traefik/dynamic
    - user: root
    - group: root
    - mode: "0755"
    - makedirs: True
