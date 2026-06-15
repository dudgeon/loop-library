#!/usr/bin/env bash
# conformance.sh — strict OKF v0.1 conformance for the wiki/ bundle.
# Enforces the three checks in CLAUDE.md §6. Exits non-zero on any failure.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
WIKI="wiki"
errors=0
err() { echo "FAIL: $*"; errors=$((errors + 1)); }

# Print the frontmatter block (between the first two '---' lines). Exit 1 if absent.
fm() { awk 'NR==1{if($0!="---") exit 1; next} /^---[[:space:]]*$/{exit} {print}' "$1"; }
# Print the value of a top-level frontmatter key.
fmval() { fm "$1" | awk -v k="^$2:" '$0 ~ k {sub(/^[^:]*:[[:space:]]*/,""); print; exit}'; }

# Check 2: bundle-root index declares okf_version.
if [ -f "$WIKI/index.md" ]; then
  grep -qE '^okf_version:[[:space:]]*"?[0-9]' "$WIKI/index.md" \
    || err "$WIKI/index.md missing okf_version"
else
  err "$WIKI/index.md missing (the bundle needs a root index)"
fi

while IFS= read -r f; do
  base=$(basename "$f")
  [ "$base" = "index.md" ] && continue
  [ "$base" = "log.md" ] && continue

  # Check 1: parseable frontmatter with a non-empty type.
  if ! fm "$f" >/dev/null 2>&1; then err "$f has no frontmatter block"; continue; fi
  type=$(fmval "$f" type)
  if [ -z "$type" ]; then err "$f missing non-empty 'type'"; continue; fi

  # Check 3: compiled pages must cite sources and carry a # Citations section.
  case "$type" in
    Loop|Pattern|Anti-pattern|Concept|Comparison)
      src=$(fmval "$f" sources)
      { [ -z "$src" ] || [ "$src" = "[]" ]; } && err "$f ($type) missing 'sources:'"
      grep -qE '^#+[[:space:]]+Citations' "$f" || err "$f ($type) missing '# Citations' section"
      ;;
  esac
done < <(find "$WIKI" -type f -name '*.md')

if [ "$errors" -eq 0 ]; then echo "OK: conformance passed"; exit 0; fi
echo "conformance: $errors error(s)"; exit 1
