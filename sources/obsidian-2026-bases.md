# Obsidian Bases — the `.base` database-view feature

> **Capture note (not part of the original).** Obsidian's official help pages
> (`help.obsidian.md/bases`, `help.obsidian.md/bases/syntax`) and their mirrors return HTTP 403
> to this environment's web fetcher, so this mirror is assembled from the official help text and
> the official 1.9.0 changelog **as surfaced verbatim via web search**, plus closely-corroborating
> secondary guides. Verbatim quotes are attributed inline. Captured 2026-06-28. Canonical URL:
> https://help.obsidian.md/bases. This follows repo precedent for sources whose origin is
> unreachable from this env (see the Ouimet sources in `wiki/log.md`).

---

## What Bases is

Bases is a **core plugin** introduced in **Obsidian 1.9.0** (desktop early access, 2025-05-21;
"available to everyone with Obsidian 1.9"). It turns a set of notes into a database-style view.

> "Bases is a new core plugin that lets you turn any set of notes into a powerful database. To
> support Bases, Obsidian is introducing the `.base` file format and syntax." — Obsidian Help,
> *Introduction to Bases*

> "Introducing Bases, a new core plugin that lets you turn any set of notes into a powerful
> database. Now available to everyone with Obsidian 1.9!" — @obsdmd announcement

Bases lets you create custom views to visualize and interact with data already in your vault:
filter notes by their properties, and define formulas to derive dynamic properties.

## Where the data lives (the load-bearing point)

The notes are the data; the `.base` file is only the **view/query configuration**. Your content
never moves into the base.

> "All the data in a base is backed by your local Markdown files and properties stored in YAML."
> — Obsidian Help

> "The `.base` file only stores the view configuration: filters, columns, sorting, and grouping.
> Your actual data never leaves your Markdown notes, which keeps it plain-text, portable, and safe
> even if you delete the base." — dsebastien.net (corroborating guide)

> "Your data stays plain-text. Delete the base tomorrow and you lose nothing but the view. Every
> note and every property is still sitting in your vault as Markdown." — dsebastien.net

## The `.base` file format

> "Bases must be valid YAML conforming to the schema defined below." — Obsidian Help, *Bases syntax*

A `.base` file is YAML. It can be edited via the app UI or by hand, and embedded in a `base`
code block inside a note. Its sections:

- **filters** — global filters apply to all views in the base. A filter is a recursive object with
  exactly **one** key: `and`, `or`, or `not`.
- **formulas** — calculated properties derived from other properties.
- **properties** — per-property configuration (e.g. a `displayName` used for table column headers);
  it's up to each view how to use these.
- **views** — one or more named views, each with a `type` (see below) and its own config.

### Property types

> "Note properties are only available for Markdown files, and are stored in the YAML frontmatter
> of each note. These properties can be accessed using the format `note.author` or simply `author`
> as a shorthand." — Obsidian Help, *Bases syntax*

- **note properties** — the note's YAML frontmatter; `note.<name>` (or bare `<name>`). Markdown
  files only.
- **file properties** — `file.<name>` (e.g. `file.name`, `file.mtime`); available for **all** file
  types, including attachments. *"File properties refer to the file currently being tested or
  evaluated."*
- **formula properties** — computed values defined in the `.base` file's `formulas` section.

### View types

- **Table** and **Cards** — shipped in Obsidian 1.9.
- **List** and **Map** — added in Obsidian 1.10.

Bases is described as "an early beta with expected changes and improvements over the coming
months"; planned: more view types, a plugin API, and Publish support.

---

## Source URLs (canonical, 403 from this env)

- Introduction to Bases — https://help.obsidian.md/bases (mirror: https://obsidian.md/help/bases)
- Bases syntax — https://help.obsidian.md/bases/syntax (mirror: https://obsidian.md/help/bases/syntax)
- Obsidian 1.9.0 changelog (Bases launch) — https://obsidian.md/changelog/2025-05-21-desktop-v1.9.0/
- Obsidian 1.10.0 (List/Map views) — https://www.neowin.net/news/obsidian-1100-released-with-new-features-and-improvements-for-bases/

## Corroborating secondary guides

- dsebastien.net — "How I Turned 20,000 Notes Into Live Dashboards With Obsidian Bases" —
  https://www.dsebastien.net/how-i-turned-20-000-notes-into-live-dashboards-with-obsidian-bases/
- got.md — "Obsidian Bases: The Complete Guide to Database Views (2026)" — https://got.md/obsidian-bases/
- obsibrain.com — "Obsidian Bases: How to Build No-Code Databases in Your Vault" —
  https://www.obsibrain.com/blog/obsidian-bases-guide
