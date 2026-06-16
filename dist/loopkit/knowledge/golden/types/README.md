# golden/types/ — entity types, written down once they've earned it

A note here defines one **entity type** — a kind of thing the project tracks (`person`, `source`,
`initiative`, `decision`). It's golden: loaded first, never trimmed, and yours.

**Start empty.** A fresh project authors no types. Just give each note a sensible `type:` as you go.
When the same type keeps showing up and is worth pinning, write it down here — that's how a concept
gets defined once instead of reinvented on every ingest.

A type note is plain prose plus a little frontmatter — **not** a hand-maintained table of fields:

```markdown
---
type: type-definition
defines: source
statuses: [unread, reading, read, processed]   # optional — only if this type has a lifecycle
---

# source

Something we read or watched and want to remember — an article, a talk, a doc. Usually carries a
`status:` (the ladder above), an author, and a link. Links to the `knowledge` notes extracted from it.
```

The optional `statuses:` line is where a lifecycle's **order** lives, so a query can mean "everything
below `read`." Keep it to what the type actually needs; let it grow with use.

*(This README is part of the kit. The type notes you write next to it are yours — `sync` never
touches them.)*
