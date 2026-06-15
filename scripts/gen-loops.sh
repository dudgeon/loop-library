#!/usr/bin/env bash
# gen-loops.sh — regenerate loop/LOOPS.md from loop/loops.registry.json (+ wiki type:Loop pages).
# Pass --check to verify it is up to date (non-zero exit if stale) instead of writing.
set -euo pipefail
cd "$(dirname "$0")/.."
exec python3 scripts/gen-loops.py "$@"
