# Saltdocker CLI Cheatsheet

## Local vs Global Invocation
- Run from repo root with `./scripts/saltdocker <command>`.
- Add the scripts directory to your PATH (`export PATH=$PATH:/root/saltdocker/scripts`) or run `./scripts/saltdocker install-cli --destination /usr/local/bin/saltdocker` to create a symlink (use `--copy` if symlinks are blocked, `--force` to overwrite).

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

See `saltdocker --help` for the full command table with descriptions and examples.
