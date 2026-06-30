---
contract_version: 2
---

# FOUNDATION.md — what loopkit is, and how to build on it

Read this if you're **building something richer on loopkit** — a domain system, a stakeholder map, a
source-to-knowledge pipeline, roadmaps. loopkit is the *foundation*: a small graph of typed,
resolved notes. Your richer agent is a thin layer of **policy** written **on** that foundation, not a
machine rebuilt **in** it. This file is the contract you're building against and the seam between
what loopkit owns and what's yours.

(`CLAUDE.md` is how the assistant operates the kit day to day; this file is the *why* and the *seam*,
for someone extending it. `contract_version: 2` above marks the contract tier — see *What changed in
contract v2* at the foot of this file, and `MIGRATION.md` for how an agent on an older vault adapts.)

---

## The model in one paragraph

A note is a **typed entity** — one thing, one file, with a `type:`. A link is an **edge** — plain
relative markdown that can carry a little data. **Entity resolution** turns a vague reference ("the
analytics tool") into the canonical note (`Amplitude`). Types start out informal and get **written
down** as they earn it. That's the whole foundation: typed nodes, edges, resolution, and a taxonomy
that grows with use. The at-rest form is **bare Google OKF v0.1 plus two small additions** — a shared
`id:` tag and a parent-derived folder path (both below) — so the folder is a clean OKF bundle *and* a
Duo OKF vault: a graph-aware host can file, heal, and traverse the same files natively, and any plain
OKF consumer can still read it.

---

## The contract (what every note and link obeys)

| Rule | What it means for you |
|---|---|
| **`type:` is the entity field** | Every note carries `summary:` + `type:` + `source:` as a floor. `type:` is what makes a note a node — and it's the field a Duo vault files and heals on. Build your kinds (`person`, `source`, whatever) as `type:` values. |
| **Frontmatter is a floor, not a ceiling** | Add any attributes you need (`status:`, `owner:`, `requested_by:`). loopkit won't define them — that's your policy. |
| **Never drop a key you didn't write** | Every rewrite (ingest/query/distill) preserves unknown frontmatter keys and body sections. This is what lets your layer attach data safely — a `status:` you add survives the next cleanup pass. Don't break this rule in anything you build. |
| **`id:` is a shared, tool-mintable integrity tag** *(changed in v2)* | Any conforming tool — the kit, a Duo vault, another OKF host — **may mint** an `id:` and **must preserve** one that is present: never silently dropped, never reused, never rewritten. Links heal by `id:` first, then by filename. The `id:` is a **contract, not an algorithm** — a short, opaque, URL-safe, *vault-unique* token. (Reference shape: Duo's 8-char base36, ~41 bits of entropy. A conforming tool need not use that exact scheme — only mint something that meets the floor: ≥ 8 URL-safe chars, unique within the vault, checked for collision at mint.) The `id:` exists so a note can move — including into the parent-derived folder path below — without breaking inbound links. |
| **Folders are derived from the parent edge** *(changed in v2)* | When a note has a `parent:` edge, it files **inside that parent's folder, recursively** — so the folder tree mirrors the parent/child graph (a work-breakdown). This is a **projection of one edge**, computed from the graph; the graph stays the single source of truth, and a re-parent or reorg moves files **loss-free via `id:`**. Parentless notes live in their flat type/registry folders. (This generalizes a Duo OKF vault's single-level folder-note filing to the full parent chain.) Secondary groupings are **`index.md` outlines**, never a second folder tree. |
| **Links are rel-md edges** | `[label](./note.md)` — never `[[wikilinks]]`, never `/absolute`. Renders on GitHub from any vendored path; matches the OKF at-rest form. An edge can carry a payload (a quote, a requester) in frontmatter next to it. |
| **Edges survive a split** | If you decompose one note into several, copy its source/attribution edge onto each child so each keeps its own back-reference. |
| **Reserved files stay reserved** | `index.md` / `log.md` are not entity nodes. A roll-up (a map, a drift list) is its own `type: index-view` note whose body is *regenerated and stamped*, never hand-cached. |

---

## The seam — what loopkit owns vs what's yours

loopkit ships the **mechanisms**; you bring the **vocabulary**. Here's where the line falls for the
common things you'll want to build:

| You want to build | The loopkit affordance you build it on |
|---|---|
| **A work-breakdown / org tree** | The parent-derived folder path: give notes a `parent:` edge and the folder tree materializes from it, loss-free on re-parent via `id:`. The graph is canonical; the folders are a browsable projection of it. |
| **Domains** (folders, per-area READMEs, capability flags) | Folders as a scoping unit; an `index.md` and optional README per directory; a `pattern:`/`lifecycle:` flag carried through as preserved frontmatter; arbitrary typed notes inside a folder. |
| **People / a stakeholder map** | Typed `person` notes; open attributes so *you* name `proximity:`; a `type: index-view` map node; a timeline section in a note's body. |
| **A source → knowledge lifecycle** | `source` and `knowledge` as distinct types; a **per-type ordered status ladder** (you name `unread → … → processed`); edges that carry a citation quote. |
| **Roadmaps / changelogs** | Typed sections on a folder note; a per-note timeline distinct from the evergreen body. |
| **Template propagation** | Types are notes in `knowledge/templates/` (below); add a `template_version:` payload on a derivation edge and a regenerated "drift" view. |
| **Multi-domain routing** | The attribution edge that survives a split (above), plus `id:`-driven moves so backfill relinks without severing edges. |

The single affordance most of these lean on: **edges carry data, and the graph knows its backlinks.**

---

## Types: emergent, then written down

Don't author a schema up front. Give notes a sensible `type:` as you go. When a type earns being
pinned, write it down as `knowledge/templates/<type>.md` (named for the type) — the folder a Duo vault
reads types from, and the kit's skills read too — plain prose plus a little frontmatter, *not* a
hand-maintained field grid. A type's **ordered status ladder** lives there too, and a type may name
the frontmatter key that is its **parent edge** (the one the derived folder path follows):

```markdown
---
type: source
statuses: [unread, reading, read, processed]   # only if this type has a lifecycle
---

# source
Something we read and want to remember. Carries a status (above), an author, a link.
```

They're yours — `sync` never touches them — and read by both Duo and the assistant (neither is locked
out; the assistant can refine a type). This is how a concept gets defined once instead of reinvented
on every pass — and it's where a query like "everything below `read`" finds its order.

---

## What loopkit deliberately does NOT do (so you know what's yours)

- **It doesn't name enum values.** Status ladders, proximity bands, change taxonomies — yours.
- **It doesn't fix a resolution order.** It resolves (in ingest *and* distill), deferring to the
  vault's live table when present; *which* sources in *what* order is your policy to override.
- **It doesn't decide staging, domains, or lifecycles.** Whether capture is automatic, how domains
  nest, what a source's lifecycle is — all yours.
- **It doesn't hand-author or cache a schema.** Typed notes are fine; a `## Fields` grid the user
  babysits, or a machine-cached "observed values" file, is not.
- **It doesn't tie identity to folder layout.** Identity is the `id:` (or filename), **never the
  path** — which is exactly what makes the parent-derived folder path safe: re-parenting or
  reorganizing moves files but never breaks the graph, because edges heal by `id:`.

---

## How to extend without breaking the foundation

1. **Own the mechanism, not the vocabulary.** Adding a specific lifecycle or tier? Put it in *your*
   layer (a type template, an app convention), not in the kit's contract.
2. **Preserve unknown keys** in anything that rewrites notes. This is the rule the whole layered model
   rests on.
3. **Keep links rel-md** and let derived views regenerate; don't introduce a second link index or a
   hand-cached roll-up.
4. **Write types down in `knowledge/templates/`** (a Duo vault's type location, read by Duo and the
   skills), never as a top-level schema file.
5. **Let the vault own identity and resolution** when it's present; mint an `id:` only at create or
   explicit backfill, preserve any you find, and keep no parallel index.

Stay inside those five and your richer agent composes cleanly on top — and a loopkit fork stays a
clean, GitHub-readable, Duo-openable graph the whole way up.

---

## What changed in contract v2

Contract v2 relaxes **exactly two** of the rules above; everything else is unchanged (see the
invariant ledger in `DESIGN.md` for the full before/after).

1. **`id:` became a shared, tool-mintable tag** (was: "optional, never minted by loopkit"). The kit
   may now mint one — needed so a note can move into the parent-derived path with links healing
   id-first.
2. **Folders are now derived from the parent edge by default** (was: a flat bag where folders carried
   only ownership/lifecycle meaning). The folder tree is a projection of the parent/child graph; the
   graph is still canonical and identity is still independent of the path.

Both additions are **at-rest OKF-conformant**: the `id:` is just another frontmatter key, and the
derived path is ordinary nested directories — a plain OKF consumer reads the bundle either way.
Together they make loopkit a **documented dialect of bare Google OKF v0.1**: the shared `id:` tag plus
each tool's filing/listing conventions. A Duo vault and a brainkit vault are both valid bare OKF v0.1
that interoperate at rest.
