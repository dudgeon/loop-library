# Changelog

All notable changes to karpathy-core. This project follows semantic versioning.

## 0.1.0 — 2026-06-15
First release.

- The **ingest → query → distill** loop over a single **knowledge base** of plain markdown.
- **Golden (locked) context** in `knowledge/golden/`, with a "pin this" promotion path.
- **Multiple deliverables** in `work/`, each splittable into sections that can be locked
  (`locked: true`) and finalized one at a time.
- Skills: `ingest`, `query`, `distill`. Setup and golden-pinning are `CLAUDE.md` rules, not skills.
- Self-contained: no dependency on any external knowledge base or parent repo.
- `loop.manifest.json` + `scripts/sync.sh` keep the kit's machinery updatable without touching your
  content.

Known limitations (v0): nothing runs on a schedule — you invoke the operations. Golden/locked
protection is by convention + git review, not a hard mechanical lock. Forking into a repo that
already has a `CLAUDE.md` requires a manual merge.

_2026-06-18 (docs): clarified that `sync` overwrites the machinery doc `knowledge/golden/README.md`;
your golden notes beside it are untouched. The manifest note previously implied all of `knowledge/`
was untouched. (Surfaced by brainkit's foreclosure pass.)_
