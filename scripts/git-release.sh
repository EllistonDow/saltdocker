#!/usr/bin/env bash
set -euo pipefail
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "[release] Not a git repository" >&2
  exit 1
fi
if ! git remote get-url origin >/dev/null 2>&1; then
  echo "[release] 'origin' remote not found" >&2
  exit 1
fi
if [ -z "$(git status --porcelain)" ]; then
  echo "[release] No changes to commit." >&2
  exit 0
fi
MESSAGE=${1:-"chore: auto release $(date -u +%Y-%m-%dT%H:%M:%SZ)"}
SKIP_CHECKS=${SKIP_CHECKS:-0}
DRY_RUN=${DRY_RUN:-0}
if [ "$SKIP_CHECKS" != "1" ]; then
  echo "[release] Running scripts/check.sh ..."
  ./scripts/check.sh
else
  echo "[release] SKIP_CHECKS=1 -> skipping quality checks"
fi
if [ "$DRY_RUN" = "1" ]; then
  echo "[release] DRY_RUN=1 -> skipping commit/tag/push"
  exit 0
fi

git add -A
if git diff --cached --quiet; then
  echo "[release] Nothing staged after checks. Exiting." >&2
  exit 0
fi
git commit -m "$MESSAGE"
latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1) 2>/dev/null || true)
determine_bump() {
  if [ -n "${BUMP:-}" ]; then
    echo "$BUMP"
    return
  fi
  msg="${MESSAGE,,}"
  if [[ $msg == breaking!* || $msg == *"breaking change"* ]]; then
    echo "major"
  elif [[ $msg == feat:* || $msg == feature:* ]]; then
    echo "minor"
  else
    echo "patch"
  fi
}
next_tag() {
  local tag="$1"
  local bump="$2"
  if [[ $tag =~ ^v([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
    local major=${BASH_REMATCH[1]}
    local minor=${BASH_REMATCH[2]}
    local patch=${BASH_REMATCH[3]}
    case "$bump" in
      major)
        major=$((major + 1))
        minor=0
        patch=0
        ;;
      minor)
        minor=$((minor + 1))
        patch=0
        ;;
      *)
        patch=$((patch + 1))
        ;;
    esac
    echo "v${major}.${minor}.${patch}"
  else
    echo "v0.1.0"
  fi
}
BUMP_KIND=$(determine_bump)
NEW_TAG=$(next_tag "$latest_tag" "$BUMP_KIND")
git tag -a "$NEW_TAG" -m "$MESSAGE"
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "[release] Pushing branch '$current_branch' ..."
git push origin "$current_branch"
echo "[release] Pushing tag '$NEW_TAG' ..."
git push origin "$NEW_TAG"
echo "[release] Done => $NEW_TAG"
