{%- set saltdocker_root = pillar.get('saltdocker', {}).get('root', '/root/saltdocker') -%}

saltdocker-cli-symlink:
  file.symlink:
    - name: /usr/local/bin/saltdocker
    - target: {{ saltdocker_root }}/scripts/saltdocker
    - makedirs: True
    - force: True
