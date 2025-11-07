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
      - run: pip install pyyaml yamllint
      - run: scripts/saltdocker list
      - run: scripts/saltdocker validate
      - run: scripts/saltdocker health gateway --dry-run
      - run: yamllint config/projects.yml
```

Add additional jobs for integration tests or Salt dry-runs as the repo matures. Gate merges on a green pipeline plus reviewer approval.
