# CI Integration

Use a lightweight pipeline to keep metadata and docs healthy:

```yaml
name: saltdocker
on:
  push:
  pull_request:
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      - run: pip install -r requirements-dev.txt
      - run: scripts/check.sh
```

Add additional jobs for integration tests, Salt `state.apply --test` dry-runs, or Compose smoke tests as the repo matures. Gate merges on a green pipeline plus reviewer approval.
