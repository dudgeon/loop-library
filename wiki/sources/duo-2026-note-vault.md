---
type: Source
title: Duo — OKF Note Vault (vault skill reference)
description: Duo's Note Vault is a folder of markdown work-notes (one graph model, two at-rest serializers — OKF and Obsidian) over which Duo adds a capture UI, search, and an agent layer driven by `duo vault` / `graph` / `base` verbs.
tags: [okf, knowledge-base, ingest, query, lint, agent-harness, provenance]
authors: [dudgeon (Duo)]
published: '2026'
timestamp: 2026-06-15T00:00:00Z
resource: https://github.com/dudgeon/duo
raw_mirror: ../sources/duo-2026-note-vault.md
---

# Duo — OKF Note Vault

The operating manual for Duo's **Note Vault** feature (skill epics ENH-208 · ENH-216). A vault
is a **folder of work-notes**: plain markdown + YAML frontmatter + folders + a link graph. Duo
layers **capture** (autocomplete, ⇧⌘N quick-capture, ⌘⇧F search palette, a type-picker,
`@today` tokens), **search**, and an **agent layer** (the assistant, via `duo vault` / `graph` /
`base` verbs) on top. Critically, the same notes/links/types form **one graph model** with **two
serializers**: an **OKF** format (the same Open Knowledge Format this library's `wiki/` conforms
to) and an **Obsidian** format. This makes Duo a productized runtime for exactly the substrate the
loop-library already uses — the basis for treating a loopkit fork as a latent Duo vault.

# Key points
- **One graph, two at-rest formats (ENH-216).** **OKF** mode — marker is a root `index.md` with
  `okf_version:` frontmatter; links at rest are standard markdown relative links
  `[Display](./note.md)`; listings are static generated `index.md` + `log.md`; every note carries
  `type:` and a **stable `id:`**. **Obsidian** mode — marker is a `.obsidian/` dir; links are
  `[[wikilinks]]`; rollups are live `.base` queries. If both markers exist, **`okf_version` wins**.
- **The `[[wikilink]]` gesture is input-only.** Typing `[[Name]]` picks or stubs a target; on
  resolve, OKF mode **rewrites it to a relative markdown link** (Obsidian mode keeps the wikilink).
  **No `[[wikilink]]` ever persists in OKF mode** — the at-rest form is GitHub-renderable rel-md.
- **Three layers, distinct owners:** *at rest* (markdown + frontmatter + folders + link graph;
  format conventions, zero invention) → *capture* (Duo UI) → *agent* (the assistant, via verbs).
- **The corpus is computed live, never cached** (`duo vault schema` — the "no-sidecar" rule): it
  reports types, entities, aliases, props-per-type, **observed enums**, and templates, and is the
  resolution table to read **before authoring a rollup or filing a note**. Note the hybrid: types
  are **declared** (via `templates/<type>.md`) but enum *values* are **observed** from usage.
- **Typed entities via templates.** Each `templates/<type>.md` declares filing rules (D19):
  parentless types (person, theme) file in a registry folder; parented types (milestone, meeting)
  file under a `filingParent:` attribute's folder; folder-note types (initiative) own a folder.
  **Folder layout is ergonomics only — every query is frontmatter-driven, so a note never loses
  its edges when it moves.** "+ new type…" simply writes a new template file (no verb).
- **Stable-`id` link integrity.** OKF notes get an `id:` at create time (D10). `duo vault mv`
  moves a note and rewrites inbound links; `duo vault relink` repairs out-of-band (Finder/git)
  moves by re-resolving each dangling link to its `id:` first, then slug — rewriting the
  unambiguous and **reporting** the ambiguous/broken (warn-don't-block). Auto-runs on vault open.
- **Capture is fast and lossy by design; processing is where it's filed and fixed.** The "process
  my vault" pass (P8) builds a live work-list (stale inbox notes, untyped notes, missing required
  fields, unresolved links, orphans) and acts **as reviewable suggestions** — CriticMarkup tracked
  edits, proposed moves, proposed connections — **never silently**, ending in a dated report note.
- **OKF uses static listings, not live rollups (D8).** `duo vault publish` (re)generates the
  plain-markdown `index.md` (a heading per type/group → `* [Title](rel) - desc` bullets) and
  `log.md` (`## YYYY-MM-DD`, newest-first) from the corpus; the root `index.md` frontmatter (the
  OKF marker) is preserved byte-identically. Obsidian mode instead uses `.base` rollups.
- **`promote`** splits a `## section` of a running doc into its own typed entity, leaving a link
  behind (a rel-md link in OKF, a wikilink in Obsidian) — never a transclusion.

# Notable excerpts
- "A **vault** is a folder of work-notes: plain markdown + YAML frontmatter + folders + a link
  graph. Duo adds capture, search, and an **agent layer** (you) on top."
- "The same notes/links/types form one graph; how a link is written to disk depends on the vault's
  format." (two serializers, one model)
- "No double-square-bracket link ever persists in OKF mode (D3)."
- "Folder layout is **ergonomics only** — every query is frontmatter-driven, so a note never loses
  its edges when it moves."
- "The corpus is computed live every time — never cache it to disk (no-sidecar rule)."
- "capture is fast and lossy by design; processing is where it gets filed and fixed."

# Compiled into
- [Duo Note Vault ↔ the wiki/loopkit construct](/comparisons/duo-vault-vs-wiki.md)
- [Loopkit on Duo — progressive enhancement by an optional host](/concepts/loopkit-on-duo.md)
