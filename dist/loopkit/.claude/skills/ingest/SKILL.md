---
name: ingest
description: Add new material to this project's graph as a typed entity note — resolve the things it mentions to their canonical notes, link it with relative-markdown edges, and keep the index current. Use whenever the user shares or refers to something the project should remember — a call, a doc, a decision, a finding, a person, a link.
---

# ingest

Fold new material into `knowledge/` as a typed entity, wired into the graph. Read `CLAUDE.md` first
(it's the contract — §3 notes, §5 links, §6 resolution).

## Steps
1. Read `PROJECT.md` (goal, deliverables, what's golden), `knowledge/index.md`, and the `knowledge/templates/`
   notes so you know the types and definitions already in play.
2. **Resolve the entities it mentions** (§6) — turn vague references into canonical notes. When a Duo
   vault is present, read `duo vault schema` for types and aliases; otherwise resolve against existing
   notes, then `golden/`, then ask. Don't invent a more formal name you can't verify.
3. Decide where it belongs. Default: a new one-topic note in `knowledge/`. If it extends an existing
   entity, enrich that note (add to it, add a timeline line) instead of making a near-duplicate.
4. Write the note with the three-line floor — `summary:`, `type:` (a sensible kind), `source:` — plus
   whatever other attributes it needs. **Preserve any frontmatter key already there you don't
   recognize** (e.g. an `id:`); never mint an `id:` yourself.
5. **Link it** to related notes with relative-markdown edges — `[label](./other-note.md)`, never a
   `[[wikilink]]`, never an absolute path. If a link carries more than its label (a citation quote, who
   asked), put that in frontmatter next to it. Say in prose what the link means.
6. If one input decomposes into several notes, **copy the source/attribution edge onto each child** so
   each keeps its own back-reference.
7. Update `knowledge/index.md`.

## Don'ts
Don't dump raw material verbatim. Don't create near-duplicates. Don't touch `golden/` or locked files.
Don't strip a frontmatter key you didn't write. Don't author a type up front — types emerge, then get
written down (`CLAUDE.md` §4).
