# templates/ — your entity types (and where Duo reads them)

A note here defines one **entity type** — a kind of thing the project tracks (`person`, `source`,
`initiative`). The file is named for the type (`source.md` defines `source`). This is the folder a
Duo OKF vault reads type templates from, so writing a type here makes it real to **Duo** (its
type-picker, `duo vault stub`, filing rules) *and* to the kit's own skills at once — one template
scheme, not two.

They're **yours, and both Duo and the kit's skills read them** — Duo files and stubs new notes from
them, the skills resolve notes and catch type drift against them. `sync` doesn't touch the type notes
you write — they're your content (only this `README.md` is kit machinery, kept current by `sync`).
They aren't locked: the assistant can propose adding or refining a
type as the project teaches you what its types are.

**Start empty.** A fresh project authors no types. Give each note a sensible `type:` as you go; when a
type keeps showing up and is worth pinning, write it down here — so the project defines a concept once
instead of reinventing it.

A type is plain prose plus a little frontmatter (the default a new note of that type starts from) —
**not** a hand-maintained table of fields:

```markdown
---
type: source
statuses: [unread, reading, read, processed]   # optional — only if this type has a lifecycle
---

# source
Something we read or watched and want to remember — an article, a talk, a doc. Usually carries a
`status:` (from the ladder above), an author, and a link to the notes drawn from it.
```

The optional `statuses:` line is where a lifecycle's **order** lives, so a query can mean "everything
below `read`." Keep it to what the type needs; let it grow with use.

*(This README is part of the kit. The type notes you write next to it are yours — `sync` never
touches them.)*
