#!/usr/bin/env bash
# sync.sh — update karpathy-core's machinery (the managed files) from origin, leaving your content alone.
#
# Overwrites ONLY the paths listed in loop.manifest.json -> managed_files. Your PROJECT.md,
# knowledge/, and work/ deliverables are never touched.
#
# Requires: bash, python3, and (for a remote origin) git.
# Origin resolution order: first argument, then $KARPATHY_CORE_ORIGIN, then the "origin" field in
# loop.manifest.json. Origin may be a git URL or a local path; karpathy-core may sit in a subdirectory
# of it (e.g. dist/karpathy-core).
set -euo pipefail
cd "$(dirname "$0")/.."
KIT="$(pwd)"

ORIGIN="${1:-${KARPATHY_CORE_ORIGIN:-$(python3 -c 'import json; print(json.load(open("loop.manifest.json")).get("origin",""))')}}"
if [ -z "$ORIGIN" ] || [[ "$ORIGIN" == TODO* ]]; then
  echo "No origin set. Pass one: scripts/sync.sh <git-url-or-path>" >&2
  echo "  or set \$KARPATHY_CORE_ORIGIN, or the \"origin\" field in loop.manifest.json" >&2
  exit 1
fi

tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
if [[ "$ORIGIN" == *://* ]] || [[ "$ORIGIN" == git@* ]] || [ -d "$ORIGIN/.git" ]; then
  echo "Cloning $ORIGIN ..."
  git clone --depth 1 "$ORIGIN" "$tmp/src" >/dev/null
  SRC="$tmp/src"
else
  SRC="$ORIGIN"
fi
# karpathy-core may live in a subdirectory of the origin
if [ ! -f "$SRC/loop.manifest.json" ] && [ -f "$SRC/dist/karpathy-core/loop.manifest.json" ]; then
  SRC="$SRC/dist/karpathy-core"
fi
[ -f "$SRC/loop.manifest.json" ] || { echo "Could not find karpathy-core in origin: $ORIGIN" >&2; exit 1; }

python3 - "$SRC" "$KIT" <<'PY'
import json, os, shutil, sys
src, kit = sys.argv[1], sys.argv[2]
managed = json.load(open(os.path.join(kit, "loop.manifest.json")))["managed_files"]
updated = skipped = 0
for rel in managed:
    s = os.path.join(src, rel)
    if not os.path.exists(s):
        print("  skip (not in origin):", rel); skipped += 1; continue
    d = os.path.join(kit, rel)
    os.makedirs(os.path.dirname(d), exist_ok=True)
    shutil.copy2(s, d); print("  updated", rel); updated += 1
print(f"\nDone: {updated} managed file(s) updated, {skipped} skipped.")
print("Your content (PROJECT.md, knowledge/, work/) was not touched.")
PY
