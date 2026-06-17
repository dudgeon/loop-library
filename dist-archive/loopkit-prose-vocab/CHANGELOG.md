# Changelog

All notable changes to loopkit. This project follows semantic versioning.

## 0.2.0 — 2026-06-15
Resolve-once vocabulary + Duo-optional.

- **Resolve-once vocabulary** — an optional plain-language golden note
  `knowledge/golden/vocabulary.md` describing the recurring things a project tracks. `query` resolves
  `kind:` labels and terms against it (so a concept like "initiative" is defined once, and a value
  like internal/external stays a property, not its own `kind:`); `distill` suggests pinning recurring
  kinds and flags drift — suggest-only, the user pins. It is **prose, never a schema or table**.
- **Relative-markdown link convention** — notes link with `[label](./note.md)`; no `[[wikilinks]]`,
  no absolute `/paths`. Readable on GitHub and portable.
- **Preserve unknown frontmatter keys** — when editing a note, keep keys you didn't write (e.g. an
  `id:` a tool like Duo added) instead of stripping them.
- **Optional: open in Duo** — a fork can be opened as a Duo OKF Note Vault for capture, search, and
  link-repair. **Opt-in only** (a marker the assistant adds to `knowledge/index.md` on request); the
  kit never depends on Duo and every operation still runs without it.

A fresh fork is unchanged — no `vocabulary.md`, no marker, no new files; these features appear only
as you use them. Deferred (not implemented): ingest-time resolution and automatic `inbox/` scanning —
`ingest` stays light; resolution is at `query` / `distill` time.

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
