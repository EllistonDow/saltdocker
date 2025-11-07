#!/usr/bin/env python3
"""Fail if placeholder images remain."""
import sys
from pathlib import Path
TARGETS = [Path('docker'), Path('salt/states')]
needle = 'ghcr.io/example/'
bad = []
for root in TARGETS:
    if not root.exists():
        continue
    for path in root.rglob('*'):
        if not path.is_file():
            continue
        if path.suffix not in {'.yml', '.yaml', '.sls', '.py', '.sh'}:
            continue
        try:
            text = path.read_text()
        except UnicodeDecodeError:
            continue
        if needle in text:
            bad.append(path.as_posix())
if bad:
    print('Placeholder image references (ghcr.io/example) found in:')
    for path in bad:
        print(f' - {path}')
    sys.exit(1)
print('No placeholder images detected.')
