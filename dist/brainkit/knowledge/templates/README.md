# templates/ — your entity types (and where Duo reads them)

A note here defines one **entity type** — a kind of thing the project tracks (`person`, `source`,
`meeting`, `task`). The file is named for the type (`source.md` defines `source`). This is the folder a
Duo OKF vault reads type templates from, so writing a type here makes it real to **Duo** (its
type-picker, `duo vault stub`, filing rules) *and* to the kit's own skills at once — one scheme, not
two.

**brainkit ships a few starters** — `source`, `meeting`, `note`, `decision`, `person`, `task` — so a
fresh fork isn't empty. **They're yours:** refine them to your world, add attributes, add new types as
the project teaches you what it tracks. They're **seed-once** — shipped in this fork and *not* among the
kit's managed files, so `sync` never overwrites your evolved versions (the tradeoff: a starter-type fix
in a later kit release won't reach an existing vault — the price of you owning them). Both Duo and the
kit's skills read them; the assistant can propose adding or refining a type.

A type is plain prose plus a little frontmatter (the default a new note of that type starts from) —
**not** a hand-maintained table of fields:

```markdown
---
type: source
statuses: [unread, reading, read, processed]   # optional — only if this type has a lifecycle
timeline: true                                  # optional — only if this kind carries a dated history
---

# source
Something we read or watched and want to remember...
```

The optional `statuses:` line is where a lifecycle's **order** lives (so a query can mean "everything
below `read`"); `timeline: true` marks a kind that carries a machine-owned `## Timeline` (`CLAUDE.md`
§8). Keep each to what the type needs; let it grow with use.

*(This README is part of the kit — `sync` keeps it current. The type notes beside it are yours.)*
