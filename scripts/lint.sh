#!/usr/bin/env bash
# lint.sh — soft health checks over the wiki/ bundle (warnings only; always exits 0).
# Covers the cheap, mechanical part of the Lint operation (CLAUDE.md §3). The judgement
# calls — contradictions, provenance drift, missing pages — are for the agent to review.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
WIKI="wiki"

echo "== broken bundle-relative links =="
grep -rnoE '\]\(/[A-Za-z0-9._/-]+\.md' "$WIKI" --include='*.md' 2>/dev/null | while IFS= read -r line; do
  file=${line%%:*}
  target=$(printf '%s\n' "$line" | sed -E 's/.*\]\((\/[A-Za-z0-9._\/-]+\.md).*/\1/')
  [ -f "$WIKI$target" ] || echo "WARN: $file -> missing $target"
done

echo "== compiled pages missing summary: =="
find "$WIKI" -type f -name '*.md' ! -name index.md ! -name log.md | while IFS= read -r f; do
  type=$(awk 'NR==1{if($0!="---")exit;next}/^---[[:space:]]*$/{exit}/^type:/{sub(/^type:[[:space:]]*/,"");print;exit}' "$f")
  case "$type" in
    Loop|Pattern|Anti-pattern|Concept|Comparison)
      grep -qE '^summary:' "$f" || echo "WARN: $f ($type) missing summary:"
      ;;
  esac
done

echo "== orphan pages (no inbound bundle link) =="
find "$WIKI" -type f -name '*.md' ! -name index.md ! -name log.md | while IFS= read -r f; do
  id=${f#"$WIKI"}   # e.g. /loops/automation/ingest-query-lint.md
  grep -rqF "]($id" "$WIKI" --include='*.md' 2>/dev/null || echo "WARN: orphan (no inbound link): $id"
done

echo "== loop registry (loop/LOOPS.md) freshness =="
if [ -f scripts/gen-loops.py ]; then
  python3 scripts/gen-loops.py --check 2>&1 | sed 's/^/  /' || \
    echo "WARN: loop/LOOPS.md is stale or has an unregistered loop — run scripts/gen-loops.sh"
fi

echo "lint complete (warnings above are advisory)"
exit 0
