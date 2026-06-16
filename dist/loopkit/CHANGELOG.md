# Changelog

All notable changes to loopkit. This project follows semantic versioning.

## 0.2.0 — 2026-06-16 (candidate)
**The graph release.** loopkit becomes the entity-graph foundation a richer work agent is built *on*,
not *in*. **Candidate** — pending real-use validation.

- **Typed entities.** Notes are typed nodes: `type:` replaces the free-text `kind:` (it's what a Duo
  vault files and heals on). The three lines (`summary:` / `type:` / `source:`) are a **floor, not a
  ceiling** — a note carries whatever else it needs.
- **Preserve unknown frontmatter keys.** No rewrite (ingest/query/distill) ever drops a key it didn't
  write — a Duo `id:`, an app's `status:`/`owner:`. This is what lets a richer layer attach data safely.
- **Links are edges that can carry data.** Plain relative-markdown (`[label](./note.md)`) — never
  `[[wikilinks]]`, never `/absolute`. `source:` is the floor; a link can carry a payload (a quote, a
  requester). Edges are **copied onto each child** when a note is split.
- **Entity resolution** — vague reference → canonical note — runs in **both `ingest` and `distill`**,
  deferring to `duo vault schema` when a vault is present, else in-fork → golden → ask.
- **Types emerge, then get written down** as type templates under `knowledge/templates/` — the folder
  a Duo vault reads types from, treated as golden (locked, never synced). A type's ordered status
  ladder lives there too. A fresh fork ships zero types and stays flat.
- **Ships as a Duo vault.** `knowledge/index.md` carries the OKF marker, so a downloaded fork is
  already a vault — just select it in Duo. Inert and GitHub-clean for everyone else.
- **Derived views** (a stakeholder map, a drift list) are `type: index-view` notes, regenerated and
  stamped — never hand-cached. Reserved `index.md`/`log.md` stay reserved.

- **Ships `FOUNDATION.md`** — a self-contained foundation contract so people and agents building a
  richer layer on top can grok the model and the seam without leaving the kit.

Replaces the parked, unmerged v0.2.0 prose-vocabulary candidate (PR #6), which under-read the goal.

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
