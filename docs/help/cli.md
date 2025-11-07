# Saltdocker CLI Cheatsheet

## Local vs Global Invocation
- Run from repo root with `./scripts/saltdocker <command>`.
- Add the scripts directory to your PATH (`export PATH=$PATH:/root/saltdocker/scripts`)，或直接执行 `sudo salt-call --local state.apply tooling.saltdocker_cli pillar='{"saltdocker":{"root":"$(pwd)"}}'`（等效于 `saltdocker install-cli --destination /usr/local/bin/saltdocker --copy --force`）。

## Everyday Commands
| Command | Purpose | Example |
| --- | --- | --- |
| `list` | Show registered projects | `saltdocker list` |
| `describe <project>` | Print metadata | `saltdocker describe api` |
| `deploy <project>` | Run Salt + Compose up | `saltdocker deploy payments --env staging` |
| `logs <project>` | Tail compose logs | `saltdocker logs api --follow` |
| `health <project>` | Assert containers healthy | `saltdocker health api` |
| `validate` | Verify compose/state/doc triplets | `saltdocker validate` |
| `menu` | Render the built-in cheat sheet | `saltdocker menu` |
| `add-sudo-user <name>` | Create/ensure sudo-enabled local user (root only；默认免密码 sudo) | `sudo saltdocker add-sudo-user deployer --ssh-key ~/.ssh/id_rsa.pub` |
| `git push [msg]` | 自动运行检查、commit、tag、push | `saltdocker git push "feat: tidy docs" --bump minor` |

See `saltdocker --help` for the full command table with descriptions and examples.
