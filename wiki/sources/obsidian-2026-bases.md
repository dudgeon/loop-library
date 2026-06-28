---
type: Source
title: 'Obsidian Bases — the `.base` database-view feature'
description: Obsidian's core "Bases" plugin (introduced in 1.9, 2026) and its `.base` file format — a YAML file that stores only view/query configuration (filters, formulas, per-property config, views) over notes whose data stays in Markdown + YAML frontmatter.
tags: [obsidian, knowledge-base, view, frontmatter, okf]
authors: [Obsidian (help.obsidian.md)]
published: '2026'
timestamp: 2026-06-28T00:00:00Z
resource: https://help.obsidian.md/bases
raw_mirror: ../../sources/obsidian-2026-bases.md
summary: Obsidian Bases is a core plugin (Obsidian 1.9, 2026) that renders any set of notes as a database-style view; a `.base` file is valid YAML holding only the view configuration (filters, formulas, per-property config, views) while the data stays in the notes' Markdown + YAML frontmatter.
provenance: extracted
---

> **Capture caveat.** Obsidian's official help pages and mirrors return HTTP 403 to this
> environment's fetcher, so the [raw mirror](../../sources/obsidian-2026-bases.md) was assembled
> from the official help text + the 1.9.0 changelog **as surfaced verbatim via web search**, with
> closely-corroborating secondary guides. Quotes below are attributed; treat exact wording as
> high-but-not-100%-confident pending a direct fetch.

# Obsidian Bases

**Bases** is a core Obsidian plugin (introduced in **Obsidian 1.9**, desktop early access
2025-05-21; List/Map views added in 1.10) that turns a set of notes into a database-style view.
It introduces the **`.base` file format**. The defining property: **the notes are the data; the
`.base` file is only the view configuration.**

# Key points
- **A `.base` is valid YAML, holding only view config.** *"Bases must be valid YAML conforming to
  the schema."* Sections: **filters** (recursive object, one of `and`/`or`/`not`), **formulas**
  (derived properties), **properties** (per-property config like `displayName`), **views** (named,
  each with a `type`).
- **Data stays in the notes.** *"All the data in a base is backed by your local Markdown files and
  properties stored in YAML."* The `.base` "only stores the view configuration… your actual data
  never leaves your Markdown notes." Delete the base and you lose only the view.
- **Three property kinds.** **note properties** = the note's YAML frontmatter, `note.author` or
  bare `author` (Markdown only); **file properties** = `file.*` (e.g. `file.mtime`), all file
  types; **formula properties** = computed in the `.base`.
- **View types.** Table + Cards (1.9); List + Map (1.10).
- **Edited via UI or by hand**, and embeddable in a `base` code block in a note.
- **Status:** "an early beta with expected changes"; planned plugin API + Publish support.

# Notable excerpts
- *"Bases is a new core plugin that lets you turn any set of notes into a powerful database. To
  support Bases, Obsidian is introducing the `.base` file format and syntax."* (Obsidian Help)
- *"All the data in a base is backed by your local Markdown files and properties stored in YAML."*
  (Obsidian Help)
- *"Note properties… are stored in the YAML frontmatter of each note. These properties can be
  accessed using the format `note.author` or simply `author` as a shorthand."* (Obsidian Help,
  *Bases syntax*)
- *"The `.base` file only stores the view configuration: filters, columns, sorting, and grouping.
  Your actual data never leaves your Markdown notes…"* (dsebastien.net, corroborating)

# Compiled into
- [OKF bundle ↔ Obsidian Bases](/comparisons/okf-bundle-vs-obsidian-base.md) — the corpus/container
  layer (bundle ≈ vault) vs. the view-over-frontmatter layer (`.base` ≈ a SQL `VIEW`); where this
  repo's OKF usage diverges from Obsidian conventions.
