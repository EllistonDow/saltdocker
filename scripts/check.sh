#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VENV_DIR="$REPO_ROOT/.venv"
if [ ! -d "$VENV_DIR" ]; then
  python3 -m venv "$VENV_DIR"
fi
# shellcheck disable=SC1090
source "$VENV_DIR/bin/activate"
pip install -q -r "$REPO_ROOT/requirements-dev.txt"
cd "$REPO_ROOT"
run_check() {
  local cmd="$1"
  printf '[check] %s\n' "$cmd"
  bash -c "$cmd"
  printf '[check] OK\n\n'
}
run_check "scripts/saltdocker list"
run_check "scripts/saltdocker validate"

mapfile -t COMPOSE_FILES < <(
  python - <<'PY'
import yaml, pathlib
cfg = yaml.safe_load(pathlib.Path('config/projects.yml').read_text())
for name, meta in cfg.get('projects', {}).items():
    if meta.get('compose_enabled', True):
        compose = meta.get('compose_file')
        if compose:
            print(pathlib.Path(compose).resolve())
PY
)
for file in "${COMPOSE_FILES[@]}"; do
  run_check "docker compose --project-directory $REPO_ROOT -f $file config > /tmp/$(basename $file).check"
done

mapfile -t SALT_FILES < <(
  python - <<'PY'
import yaml, pathlib
cfg = yaml.safe_load(pathlib.Path('config/projects.yml').read_text())
for meta in cfg.get('projects', {}).values():
    for state in meta.get('salt_states', []) or []:
        rel = pathlib.Path('salt/states') / (state.replace('.', '/') + '.sls')
        if rel.exists():
            print(rel.as_posix())
PY
)
if [ ${#SALT_FILES[@]} -gt 0 ]; then
run_check "salt-lint ${SALT_FILES[*]}"
fi

run_check "yamllint config/projects.yml"
run_check "python scripts/check_placeholders.py"
