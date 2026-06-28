# Changelog

All notable changes to karpathy-core. This project follows semantic versioning.

## 0.2.0 — 2026-06-28
**Sync is now a curation skill, not a deterministic script.** The old `scripts/sync.sh` overwrote every
`managed_files` path from origin, which nuked intentional local tweaks to machinery files — the wrong
model for an LLM-maintained kit.

- **Removed `scripts/sync.sh`** (and the empty `scripts/` dir).
- **Added the `sync` skill** (`.claude/skills/sync/SKILL.md`) — a fourth operation alongside
  ingest/query/distill: read what changed in canonical karpathy-core, reason about which upstream
  improvements are worth adopting *here*, and pull in only what the user approves — **merging, never
  clobbering, local tweaks**. Non-deterministic and suggest-only, like `distill`.
- **`loop.manifest.json`** keeps `managed_files`, reframed as "machinery the `sync` skill compares
  against upstream and may offer to update"; `scripts/sync.sh` dropped, `.claude/skills/sync/SKILL.md`
  added. Docs updated (`CLAUDE.md` §3/§7, `README.md`, `work/README.md`). Content contract unchanged —
  sync still touches nothing outside `managed_files`.

## 0.1.1 — 2026-06-20
- **Interaction style:** mid-task confirmations and choices (delete/merge in `distill`, where a note
  belongs, pinning to `golden/`) now use the structured **AskUserQuestion** prompt with concrete
  options rather than free-text questions (`CLAUDE.md` §10). Behavior-only; no change to the file
  contract or the loop. Applied across the kit family.

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
