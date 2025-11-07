{%- set saltdocker_root = pillar.get('saltdocker', {}).get('root', '/root/saltdocker') -%}
{%- set cli_src = saltdocker_root ~ '/scripts/saltdocker' -%}

saltdocker-cli-source:
  file.exists:
    - name: {{ cli_src }}

saltdocker-cli-installed:
  cmd.run:
    - name: "{{ cli_src }} install-cli --destination /usr/local/bin/saltdocker --copy --force"
    - unless: "cmp -s {{ cli_src }} /usr/local/bin/saltdocker"
    - require:
      - file: saltdocker-cli-source
