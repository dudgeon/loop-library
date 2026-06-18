#!/usr/bin/env bash
# sync.sh — update brainkit's machinery (the managed files) from origin, leaving your content alone.
#
# Overwrites ONLY the paths listed in loop.manifest.json -> managed_files, each matched as a LITERAL
# path (no globbing). Your PROJECT.md, knowledge/ (your notes, golden/, your type templates, the
# starter index.md), and work/ deliverables are never touched.
#
# Requires: bash, python3, and (for a remote origin) git.
# Origin resolution order: first argument, then $BRAINKIT_ORIGIN, then the "origin" field in
# loop.manifest.json. Origin may be a git URL or a local path; brainkit may sit in a subdirectory
# of it (e.g. dist/brainkit). Point origin at brainkit's OWN repo — never loopkit, or this would
# copy loopkit's skills over brainkit's.
set -euo pipefail
cd "$(dirname "$0")/.."
KIT="$(pwd)"

ORIGIN="${1:-${BRAINKIT_ORIGIN:-$(python3 -c 'import json; print(json.load(open("loop.manifest.json")).get("origin",""))')}}"
if [ -z "$ORIGIN" ] || [[ "$ORIGIN" == TODO* ]]; then
  echo "No origin set. Pass one: scripts/sync.sh <git-url-or-path>" >&2
  echo "  or set \$BRAINKIT_ORIGIN, or the \"origin\" field in loop.manifest.json" >&2
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
# brainkit may live in a subdirectory of the origin
if [ ! -f "$SRC/loop.manifest.json" ] && [ -f "$SRC/dist/brainkit/loop.manifest.json" ]; then
  SRC="$SRC/dist/brainkit"
fi
[ -f "$SRC/loop.manifest.json" ] || { echo "Could not find brainkit in origin: $ORIGIN" >&2; exit 1; }

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
