# FOUNDATION.md — what loopkit is, and how to build on it

Read this if you're **building something richer on loopkit** — a domain system, a stakeholder map, a
source-to-knowledge pipeline, roadmaps. loopkit is the *foundation*: a small graph of typed,
resolved notes. Your richer agent is a thin layer of **policy** written **on** that foundation, not a
machine rebuilt **in** it. This file is the contract you're building against and the seam between
what loopkit owns and what's yours.

(`CLAUDE.md` is how the assistant operates the kit day to day; this file is the *why* and the *seam*,
for someone extending it.)

---

## The model in one paragraph

A note is a **typed entity** — one thing, one file, with a `type:`. A link is an **edge** — plain
relative markdown that can carry a little data. **Entity resolution** turns a vague reference ("the
analytics tool") into the canonical note (`Amplitude`). Types start out informal and get **written
down** as they earn it. That's the whole foundation: typed nodes, edges, resolution, and a taxonomy
that grows with use. Everything renders on GitHub, and the folder is already a Duo OKF vault, so a
graph-aware host can file, heal, and traverse the same files natively.

---

## The contract (what every note and link obeys)

| Rule | What it means for you |
|---|---|
| **`type:` is the entity field** | Every note carries `summary:` + `type:` + `source:` as a floor. `type:` is what makes a note a node — and it's the field a Duo vault files and heals on. Build your kinds (`person`, `source`, whatever) as `type:` values. |
| **Frontmatter is a floor, not a ceiling** | Add any attributes you need (`status:`, `owner:`, `requested_by:`). loopkit won't define them — that's your policy. |
| **Never drop a key you didn't write** | Every rewrite (ingest/query/distill) preserves unknown frontmatter keys and body sections. This is what lets your layer attach data safely — a `status:` you add survives the next cleanup pass. Don't break this rule in anything you build. |
| **`id:` is optional, never minted by loopkit** | If a Duo vault minted a stable `id:`, it's preserved; links heal by it. Headless, links resolve by filename. Don't mint your own — let the vault own identity. |
| **Links are rel-md edges** | `[label](./note.md)` — never `[[wikilinks]]`, never `/absolute`. Renders on GitHub from any vendored path; matches the OKF at-rest form. An edge can carry a payload (a quote, a requester) in frontmatter next to it. |
| **Edges survive a split** | If you decompose one note into several, copy its source/attribution edge onto each child so each keeps its own back-reference. |
| **Reserved files stay reserved** | `index.md` / `log.md` are not entity nodes. A roll-up (a map, a drift list) is its own `type: index-view` note whose body is *regenerated and stamped*, never hand-cached. |

---

## The seam — what loopkit owns vs what's yours

loopkit ships the **mechanisms**; you bring the **vocabulary**. Here's where the line falls for the
common things you'll want to build:

| You want to build | The loopkit affordance you build it on |
|---|---|
| **Domains** (folders, per-area READMEs, capability flags) | Folders as a scoping unit; an `index.md` and optional README per directory; a `pattern:`/`lifecycle:` flag carried through as preserved frontmatter; arbitrary typed notes inside a folder. |
| **People / a stakeholder map** | Typed `person` notes; open attributes so *you* name `proximity:`; a `type: index-view` map node; a timeline section in a note's body. |
| **A source → knowledge lifecycle** | `source` and `knowledge` as distinct types; a **per-type ordered status ladder** (you name `unread → … → processed`); edges that carry a citation quote. |
| **Roadmaps / changelogs** | Typed sections on a folder note; a per-note timeline distinct from the evergreen body. |
| **Template propagation** | Types are golden notes (below); add a `template_version:` payload on a derivation edge and a regenerated "drift" view. |
| **Multi-domain routing** | The attribution edge that survives a split (above), plus `id:`-driven moves so backfill relinks without severing edges. |

The single affordance most of these lean on: **edges carry data, and the graph knows its backlinks.**

---

## Types: emergent, then written down

Don't author a schema up front. Give notes a sensible `type:` as you go. When a type earns being
pinned, write it down as `knowledge/templates/<type>.md` — where a Duo vault reads types, treated as
golden — plain prose plus a little frontmatter, *not* a hand-maintained field grid. A type's **ordered status ladder** lives
there too:

```markdown
---
type: type-definition
defines: source
statuses: [unread, reading, read, processed]   # only if this type has a lifecycle
---

# source
Something we read and want to remember. Carries a status (above), an author, a link.
```

Because it's golden, it's loaded first, never trimmed, and the user owns it. This is how a concept
gets defined once instead of reinvented on every pass — and it's where a query like "everything below
`read`" finds its order.

---

## What loopkit deliberately does NOT do (so you know what's yours)

- **It doesn't name enum values.** Status ladders, proximity bands, change taxonomies — yours.
- **It doesn't fix a resolution order.** It resolves (in ingest *and* distill), deferring to the
  vault's live table when present; *which* sources in *what* order is your policy to override.
- **It doesn't decide staging, domains, or lifecycles.** Whether capture is automatic, how domains
  nest, what a source's lifecycle is — all yours.
- **It doesn't hand-author or cache a schema.** Typed notes are fine; a `## Fields` grid the user
  babysits, or a machine-cached "observed values" file, is not.
- **It doesn't tie identity to folder layout.** Edges are `id:`-driven (or filename), so you can
  reorganize folders without breaking the graph.

---

## How to extend without breaking the foundation

1. **Own the mechanism, not the vocabulary.** Adding a specific lifecycle or tier? Put it in *your*
   layer (a golden type note, an app convention), not in the kit's contract.
2. **Preserve unknown keys** in anything that rewrites notes. This is the rule the whole layered model
   rests on.
3. **Keep links rel-md** and let derived views regenerate; don't introduce a second link index or a
   hand-cached roll-up.
4. **Write types down in `knowledge/templates/`** (a Duo vault's type location, treated as golden),
   never as a top-level schema file.
5. **Let the vault own identity and resolution** when it's present; keep no parallel index.

Stay inside those five and your richer agent composes cleanly on top — and a loopkit fork stays a
clean, GitHub-readable, Duo-openable graph the whole way up.
