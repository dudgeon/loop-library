# loopkit — the entity-graph foundation (on a Duo OKF vault)

loopkit should be the thin, vendorable foundation that a richer work agent is built **on**: typed
entities as nodes, relative-markdown links as edges that can carry a little data, entity resolution
as a real step, and a taxonomy that starts empty and gets written down only once it's earned. Every
piece leans on something a Duo OKF vault already provides instead of hand-rolling it, and every piece
still renders on GitHub and still works with no `duo` binary present. The rule that keeps it honest:
**loopkit owns the mechanisms; everything richer is policy written on top, never machinery rebuilt
inside.**

> **Status — draft, not shipped.** This is research input, not authorization. Every change it implies
> under `dist/loopkit` is gated by [`CLAUDE.md` §8](../CLAUDE.md) (validated · very-high confidence ·
> explicit human go/no-go). The shipped baseline is **v0.1.0 on `main`**.
>
> **What this replaces.** An earlier draft reduced entities to one prose `vocabulary.md` and refused
> a `type:` field ([PR #6 / v0.2.0](https://github.com/dudgeon/loop-library/pull/6), parked). That
> framing collapsed the very distinctions a foundation needs. This supersedes it.
>
> **Honesty up front.** A foreclosure review (one skeptic per future work-agent-harness piece) found
> **nothing flat-out ruled out**, but it found four mechanisms this design *needs* and hasn't
> designed yet, and two file-layout collisions. They're called out plainly in **Still to design** and
> **Open decisions** — don't read the settled parts as if those were settled too.

---

## Problem

The shipped kit stores knowledge as a flat bag of prose notes — each a `summary:` line, a `kind:`
label, and a `source:` line. That's a good note-taker. It's the wrong *foundation*. There's no typed
entity, no stable identity that survives a move, no difference between a node and the link pointing at
it, and no resolved registry of who's who. You can't build a stakeholder map, a source-to-knowledge
lifecycle, or template propagation on top of a paragraph.

What a foundation needs that the flat bag doesn't have:

1. **Typed entities** — `source`, `knowledge`, and `person` are different kinds of thing, not one
   prose file with a freeform label.
2. **Stable identity** — an `id:` that survives a note being renamed or moved, so its links don't
   break.
3. **Edges that can carry a little data** — a citation's key quote, who requested the work, the
   template version a note came from. A bare link holds none of that.
4. **Resolution** — turning "the analytics tool" into the canonical `Amplitude` note, reliably.
5. **A way for structure to emerge and then be written down** — without forcing a schema to be
   authored up front, before anyone knows what the types are.

There's a trap on the way to fixing this, and the earlier draft fell in: reintroducing a hand-authored
schema grid — a `## Types` / `## Fields` table the user babysits, or a cached "observed values" file
that goes stale the moment a note changes. The fix isn't to hand-roll a replacement for the vault's
entity structure. It's to **lean on the vault**, which already gives you typed entities, stable ids,
templates, filing rules, a live resolution table, and a link graph — and to expose exactly those as
loopkit's primitives.

---

## What loopkit is — and what it is not

loopkit is the entity-graph foundation. Typed entities are nodes. Relative-markdown links are edges.
Resolution is a step. The taxonomy starts empty and gets written down as it's needed.

loopkit is **not** work-agent-harness (WAH). WAH has domains with their own roadmaps and changelogs, a
stakeholder map with proximity tiers, a source-synthesis lifecycle, hub-and-spoke meeting timelines,
and template-propagation with its own change taxonomy. None of that belongs in loopkit. WAH hand-rolled
every one of those pieces precisely because it had no vault underneath — its own resolution order, its
own typed-file conventions, its own link graph, its own attribution edges, its own maturity ladders.
loopkit's job is to *be* that underneath, so the next WAH is a thin layer of policy written **on**
loopkit, not a machine rebuilt **in** it.

The thing this spec exists to prevent is **foreclosure** — a foundation choice that quietly rules out
a future WAH piece. So the design pairs each primitive loopkit owns with the application piece it has
to keep buildable, and spends a section on what loopkit refuses to decide.

---

## Design principles

**1. Own the mechanism, not the vocabulary.** loopkit ships the *configurable enum* — it doesn't name
the rungs. It ships the *open attribute* — it doesn't define `proximity`. It ships the *edge that can
carry data* — it doesn't decide what `requested_by` means. Whenever you're tempted to write down a
specific value, ask whether it's a mechanism (yours) or a policy (the application's). When in doubt,
it's policy.

**2. Lean on the vault, don't rebuild it.** A Duo OKF vault already gives you typed entities
(`type:` + a stable `id:`), templates as the type system, filing rules that don't tie identity to
location, a live schema you can query for types and aliases and observed values, and a link graph with
backlinks. A loopkit fork *is* a Duo vault in waiting — same OKF-at-rest contract the loop-library
wiki uses. So target that contract. Don't build a second backlink index, a second resolution table, or
a second template scheme.

**3. Less expressive than WAH, on purpose.** A foundation earns its keep by being small enough to
build many different applications on. Resist baking in "the one obvious lifecycle" — the obvious one is
usually WAH's, and WAH is one application of many.

**4. GitHub-clean and self-contained, always.** Every link is a plain relative-markdown link —
`[label](./note.md)` — that renders on GitHub from any vendored sub-path. Never `[[wikilinks]]`, never
`/absolute` paths. A fresh fork has no `duo` binary, no parent repo, no wiki to depend on. The vault,
when present, is an enhancement, never a requirement.

**5. Never drop what you don't recognize.** Any rewrite path — ingest, query, distill — must carry
through every frontmatter key, and every body section, it doesn't recognize. A Duo-minted `id:`, an
application's `proximity:`, a `status:` enum, a `## Timeline` section — all survive untouched. A
rewrite that can silently drop an unknown key is the quiet version of banning the feature: it lets you
build the layer, then deletes its data on the next pass. This is the single most important affordance
in the spec, and it does not exist on `main` today.

---

## The primitives loopkit owns (and what each leans on)

| Primitive | What it is | Leans on (vault-native) |
|---|---|---|
| **Typed entity node** | One markdown file per entity, carrying `type:` and a stable `id:`. Kinds like `source`, `knowledge`, `person`, `project`, `topic` are first-class — not collapsed into prose. | Every OKF note carries `type:` + an `id:` minted at create time; the `id:` keeps links intact on a move. |
| **Open frontmatter, preserved on rewrite** | Nodes carry whatever typed attributes the application needs. Keys loopkit doesn't recognize are never dropped (Principle 5). | The seam every application attribute (`status`, `proximity`, `requested_by`, `template_version`) and a Duo `id:` attach through, without loopkit knowing they exist. |
| **Rel-md link graph** | Edges are `[label](./note.md)` at rest — GitHub-clean, never a wikilink, never absolute. The vault exposes the same links as a navigable graph. | `duo graph backlinks` / `orphans`; the `[[wikilink]]` authoring gesture is rewritten to rel-md on resolve; `duo vault mv` / `relink` keep links safe by `id:` on a move. |
| **Edges can carry data** | A link in the body, a little structured data in frontmatter, and a sentence nearby saying what the link means. | The same graph the vault traverses; the payload rides frontmatter so it renders on GitHub *and* queries as a typed edge. |
| **Resolution + aliases** | Turn a vague reference into the canonical note, helped by aliases on the entity. | `duo vault schema` is the live resolution table — types, entities, aliases, observed values; aliases converge "the analytics tool" onto `Amplitude`. |
| **Types get written down as templates** | When a kind has earned its keep, you write `templates/<type>.md`. loopkit ships **zero** type files — only the convention for adding them. | Duo templates declare a type and its filing rule. This is loopkit's emergent-then-encoded taxonomy, expressed the vault's way. |

A fresh fork starts flat and untyped — today's `summary` / `type` / `source` notes still render and
work, with no taxonomy authored up front. Structure is written down *later*. Types are *declared* (by
writing a template); their values are *observed* (read live from the vault), never frozen into a file.

> **Don't absorb WAH's vocabulary.** The attribute names above (`requested_by`, `template_version`,
> `proximity`, `status`) and the idea of citation / attribution / derivation edges are **illustrative
> only** — they show the *shape* of what open frontmatter and payload-bearing edges allow. loopkit
> defines none of them. They're WAH policy, named here so the mechanism is legible, not shipped.

---

## Entity resolution

Resolution is a real step loopkit cares about, because nearly every application piece depends on
turning a vague reference into a canonical note. WAH wrote a whole resolution-order subroutine by hand;
loopkit shouldn't make the next application do that again.

**When a vault is present, the vault resolves.** `duo vault schema` *is* the resolution table — types,
entities, aliases, observed values, computed fresh every time, never cached. loopkit defers to it and
keeps no parallel index of its own (Principle 2).

**When there's no vault, loopkit falls back** to the notes in the fork, then the golden set, then
asking the user. That's the whole of the headless story — and it must not *persist* a computed graph
or table; recompute when needed.

**Borrow WAH's posture, not its ladder.** Prefer a vague-but-correct name over a confident-but-invented
one; never hallucinate a more formal-sounding name. *Which* sources to consult and in what order is
application policy — WAH's "context files → domain files → web → ask" is one good order, shown as an
example, not baked in (see Q4).

---

## The note / frontmatter / link contract

- **Required baseline (renders flat on GitHub).** Every note carries three lines: a one-line
  `summary:`, a `type:` (today this field is `kind:` — see Q1), and a `source:`. A fresh fork that
  writes nothing else still renders and operates.
- **Carried through, never authored by loopkit.** An `id:` and any application attribute. Preserve-
  unknown-keys (Principle 5) is what makes this safe.
- **The three lines are a floor, not a ceiling.** A node may carry more typed attributes; the contract
  is the minimum, not the maximum.
- **Links are edges, rel-md only.** `[label](./note.md)`. distill keeps a grep check: rewrite any
  `[[wikilink]]` to rel-md, reject any `/absolute` path.
- **No sidecar.** When a vault is present, read its schema live. When headless, recompute by judgment.
  Never persist an "observed values" file or a schema grid.
- **Headless degradation.** Every operation completes with no `duo` binary. Baseline renders on GitHub;
  resolution falls back as above.

---

## How a fresh fork stays light

The foundation has to be invisible to someone who just wants to take notes. A fresh fork starts flat
and untyped, with no taxonomy authored up front, no template files, no `id:` required. Three things
keep it from drowning in machinery:

- **Ship zero type files.** loopkit carries the convention for adding a type, not a single type.
- **The only hard rule stays the small note contract.** "Split into labelled folders if a real need
  shows up" remains the guidance; nothing forces a folder scheme.
- **Leave a home for an encoded taxonomy when it's earned.** `knowledge/golden/` already holds
  definitions, is loaded first, and is never trimmed. A *user-authored* `taxonomy.md` is welcome there
  when volume warrants. The no-sidecar rule bans a machine-maintained, live-caching corpus — not a
  user's taxonomy doc.

---

## The foundation ↔ application seam — what loopkit owns vs leaves open

Each future WAH piece has to stay a thin policy layer that reads and writes the primitives above. The
table names, for each, the loopkit affordance it needs.

| Future WAH piece | The loopkit affordance that keeps it buildable |
|---|---|
| **Domains** (folders, per-domain READMEs, capability flags) | Folders as a scoping unit; an `index.md` and optional README per directory; a `pattern:` / `lifecycle:` flag carried through as preserved frontmatter; arbitrary typed nodes inside a folder. |
| **Stakeholders** (proximity + a cross-domain map) | Typed `person` nodes; open attributes so `proximity:` is never named by loopkit; a maintained map view; a per-node timeline section in the body. |
| **Source lifecycle** | `source` and `knowledge` as distinct types; a per-type **ordered status enum** (loopkit owns the mechanism; the app names `unread → … → processed`); citation edges carrying a key quote. |
| **Roadmaps / changelog** | Arbitrary typed sections on a folder node; a per-node timeline distinct from the evergreen body. |
| **Template propagation** | Templates as objects; a derivation edge carrying a `template_version`; a derived "drift" view (nodes whose version is behind the template). |
| **Multi-domain routing** (one input fans out to many notes) | An attribution edge that **survives a one-note→many-notes split** — the source reference rides as a real edge so each child keeps its own back-reference — plus `id:`-driven moves so backfill relinks without severing edges. |

The affordance that unlocks most of these is **edges that carry data, plus a graph that knows its
backlinks.** A bare link graph forecloses citations, stakeholder loop-back, and version drift all at
once — which is why "edges can carry data" is a primitive, not a convention.

---

## What loopkit deliberately does NOT do (and why that keeps the door open)

- **It doesn't name the enum values.** Ladders like `unread → … → processed` or `draft → solid →
  canonical`, proximity bands, change taxonomies — all application policy. loopkit ships the
  configurable-ordered-enum mechanism so a query can mean "below canonical." Two applications can put
  two different ladders on the same node type.
- **It doesn't collapse entities into prose, and it doesn't ban "databases."** Typed nodes, `id:`, and
  open frontmatter stay. The one true point in the old "no databases" stance is narrow and kept: the
  user never *hand-authors a schema grid*. Typed `person` notes are fine; a `## Fields` table the user
  babysits is not.
- **It doesn't make filing layout into identity.** Folder layout is ergonomics; every edge is
  `id:`-driven, so a note keeps its edges when it moves. Domains can be reorganized without breaking
  the graph.
- **It doesn't decide staging.** Whether capture is automatic, how lossy it is, where archives go —
  that's application policy. loopkit only says the inbox is staging, not a domain.
- **It doesn't bake WAH's half-decided specs.** The strategy/execution/feedback model, roadmap and
  changelog schemas, a CriticMarkup dialect, the source-synthesis scope contract — those live in a WAH
  draft that's still full of open questions. Baking them in would foreclose the alternatives that draft
  hasn't chosen yet.

---

## Mechanisms — now designed (2026-06-16)

The four gaps the foreclosure review flagged, resolved consistent with the decisions below:

1. **A status ladder's order lives in its golden type-template.** When a type is written down (Q6),
   its template frontmatter carries a small *ordered* list — `statuses: [unread, reading, read,
   processed]`. That's a user-authored ordered list, not a machine-cached corpus, so it's golden, not
   a sidecar. "Below canonical" reads the order from there.
2. **An edge survives a split because the split path copies it.** Preserve-unknown-keys protects a
   single rewrite; for a one-note→many-notes fan-out, `ingest` / `distill` **copy the source/
   attribution edge onto each child** as an explicit step. Decompose a note → every child inherits the
   edge.
3. **Derived views are stamped, regenerated artifacts** — the `duo vault publish` model. A stakeholder
   map or drift view is a real `type: index-view` node (so it can carry an `id:` and links), but its
   body is *regenerated* from the graph and stamped (generated-at + source-hash), never hand-maintained
   and never a live cache. The no-sidecar rule bans machine-cached *corpora*, not regenerated *views* —
   the same line Duo draws between its live schema and its stamped publish output.
4. **When a vault is present, the vault resolves — loopkit keeps no parallel index.** `duo vault
   schema` is the resolution table; loopkit reads it and persists no aliases/graph of its own. Headless,
   it falls back to in-fork nodes → golden → ask, still persisting nothing. Precedence: vault first.

---

## Decisions — resolved 2026-06-16

Walked with the human via lettered questions. All seven are settled and **built** into the v0.2.0
candidate (a §8 decision the human authorized).

| # | Decision | Resolution |
|---|---|---|
| **Q1** | `type:` vs `kind:` | **Adopt `type:`.** Fold the old free-text `kind:` into it (`type: finding`); migrate existing notes. The field Duo files (D19) and heals (id-relink) on — the foundation turns on it. |
| **Q2** | `id:` when headless | **Optional, slug-fallback.** loopkit never mints; a fresh fork stays light; Duo mints on first contact and preserve-unknown-keys carries it after. Links resolve by slug until then. |
| **Q3** | `source:` → edge | **Keep `source:` as the floor; add an optional payload-bearing edge alongside it.** Nothing breaks; the richer citation/attribution edge is there when an app needs attribution to survive a split. |
| **Q4** | Resolution | **Ship the mechanism + an illustrative, overridable order — and run resolution in *both* `ingest` and `distill`.** Resolve a vague reference to its canonical node at capture *and* at cleanup, not only at read time. |
| **Q5** | `index.md` / `log.md` | **Stay reserved** (no `id:`, no app frontmatter). Derived views (a stakeholder map, a drift view) are their own `type: index-view` nodes — never the reserved files. |
| **Q6** | Where type-templates live | **Golden knowledge.** An entity type's template is a golden note under `knowledge/golden/types/` — loaded first, never trimmed, user-owned, never synced. No new top-level `templates/`, no sync clobber. Also where a type's status ladder is declared (Mechanisms #1). |
| **Q7** | How the kit becomes a vault | **Ship-as-vault** (the human's ideal: download → just select it in Duo). The starter `knowledge/index.md` ships *with* the OKF marker as its first bytes + the `<!-- duo:listing -->` fence. Because `index.md` is user content (not in `managed_files`), it ships once and `sync` never touches it — the marker is delivered without `sync` ever writing it. *(One thing to confirm — below.)* |

> **Q7, the bit to confirm.** Ship-as-vault means every fresh fork — even ones that never open Duo —
> carries an `okf_version` / `type: index` header on `knowledge/index.md`. That's coherent now that
> loopkit *is* an OKF-vault foundation, and it's inert + renders clean on GitHub (first-bytes, so it
> shows as a table, not raw text). The only call: are you fine that a plain, never-opens-Duo fork still
> ships as a dormant vault? If you'd rather it stay marker-free until Duo is selected, it's a one-line
> change. I built it ship-as-vault per your stated ideal.

---

*The change in one line: loopkit stops being a flat bag of prose notes and becomes the smallest typed-
entity graph a Duo OKF vault already speaks — typed, `id:`'d nodes and rel-md edges that can carry data
— so the next work-agent-harness is a thin layer of policy written on it, not a machine rebuilt in it.*

## Sources & provenance
- Grounded in the WAH skills (`entity-verification`, `inbox-triage`, `domain-source-synthesis`,
  `stakeholder-intelligence`, `template-propagation`, `meta/specs/domain-lifecycle`) — staged for
  ingest in [`inbox/work-agent-harness.md`](../inbox/work-agent-harness.md) — and the ingested
  [Duo Note Vault source](../wiki/sources/duo-2026-note-vault.md).
- Designed and stress-tested by a multi-agent foreclosure review (2026-06-16): 0 future pieces
  foreclosed, 9 at-risk → resolved into the affordances above, and the four "still to design" gaps.
- Replaces the parked prose-vocabulary spec; supersedes [`SPEC-loopkit-on-duo.md`](SPEC-loopkit-on-duo.md).
