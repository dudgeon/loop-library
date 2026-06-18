---
type: Comparison
title: WAH ↔ Duo-vault entity structure — hand-rolled vs native
summary: work-agent-harness hand-builds, in markdown + agent skills, the exact typed-entity graph that a Duo OKF Note Vault provides natively — typed entities, resolution/aliases, backlinks, filing, capture→process; the mapping is near one-to-one, and it is the argument for building the next harness ON the native graph (loopkit) instead of hand-rolling it again.
tags: [entity-graph, knowledge-base, ingest, query, lint, agent-harness, prior-art]
timestamp: 2026-06-18T00:00:00Z
provenance: inferred
confidence: 0.7
sources: [/sources/work-agent-harness.md, /sources/duo-2026-note-vault.md]
related: [/comparisons/duo-vault-vs-wiki.md, /concepts/brainkit.md, /concepts/loopkit-on-duo.md]
---

> **Provenance note.** Both sides are now grounded — WAH in its [source](/sources/work-agent-harness.md),
> the vault in the [Duo Note Vault source](/sources/duo-2026-note-vault.md). The page stays
> `provenance: inferred` because the *framing* — "hand-rolled vs native," and the conclusion that the
> next harness should be built on the native graph — is synthesis across both, not a claim either
> source makes about the other.

## The one-line framing

> **WAH is a hand-rolled implementation of the model a vault gives you for free.** Every piece of
> machinery WAH carries in skills + conventions has a native analog in a Duo OKF Note Vault. That is
> the whole case for [loopkit](/concepts/loopkit-on-duo.md) (build *on* the native graph) and
> [brainkit](/concepts/brainkit.md) (the WAH application layer, minus the hand-rolled parts).

WAH and the Duo Note Vault independently arrived at the **same substrate** — typed markdown notes,
relative-markdown links, types-as-templates, capture→process. WAH then implemented the graph behaviors
in agent skills because it had no graph-aware host; the vault implements them in the runtime. Read
alongside [Duo Note Vault ↔ the wiki/loopkit construct](/comparisons/duo-vault-vs-wiki.md): that page
shows the *wiki* is an OKF vault; this one shows *WAH* is a hand-rolled one.

## The mapping — WAH machinery → vault-native affordance

| WAH builds by hand | Duo OKF vault provides natively | What the hand-rolling costs |
| --- | --- | --- |
| Typed entity files from `templates/` | Typed notes; types read from `templates/<type>.md`; type-picker + `duo vault stub` [3] | none structurally — same idea, same place |
| `entity-verification` resolution order (context → domain → web → ask) | `duo vault schema` is the live **types/entities/aliases** table; aliases resolve references [3] | a second resolution index the agent maintains in prose |
| **Hub-and-spoke timelines** — spoke entries hand-copied onto each person/project | **`graph backlinks`** — the graph knows its inbound links [3] | denormalized, hand-maintained, drift-prone (this library's breaker #11) |
| `context/stakeholder-map.md` — hand-maintained cross-domain index | A regenerated rollup / static `index.md` (`duo vault publish`) [3] | a roll-up babysat by hand instead of regenerated |
| `tasks.md` **+ domain-file mirrors** ("authoritative when they disagree") | A typed node + backlinks; one source of truth | duplicated state that can silently diverge (breaker #13) |
| Inbox → triage → file → archive | **capture → process** ("capture is fast and lossy; processing is where it's filed and fixed") [3] | near-identical; the vault makes process a first-class pass |
| `meta/taxonomy.md` written when volume warrants | Types/props **observed live** by `duo vault schema`; declared via templates [3] | a hand-written taxonomy vs a computed one |
| Stable references across moves (manual relinking) | Stable **`id:`** + `duo vault mv`/`relink` repair links on move [3] | WAH links break on reorganization; the vault heals them |
| `template_version` propagation skill | (not native; an application concern either way) | legitimately WAH's own — survives as policy |

The single through-line: **edges + backlinks + a live resolution table are the things WAH reimplements
in prose.** Give the agent a graph that has them, and most of WAH's bookkeeping skills dissolve.

## What is genuinely WAH's own (survives as application policy)

Not everything maps to the substrate. These are real *application* choices a vault doesn't make for
you — and they are exactly what [brainkit](/concepts/brainkit.md) keeps (as policy) or excludes:

- **Kept:** source→knowledge **maturity ladders** (`draft→solid→canonical`), **attribution that
  survives decomposition** (`requested_by`), the **resolution *order*** and the never-invent-a-name
  rule, **extraction discipline** (atomic, name-by-what-it-teaches), and the **skills house style**.
- **Excluded as breakers / different loops:** hand-copied timelines, the hand-maintained stakeholder
  map, **mirrored** tasks, cross-agent mirror-sync, the publishing pipeline, and the
  domain-strategy/roadmap layer. (See the divergence analysis folded into
  [brainkit](/concepts/brainkit.md).)

## Approaches (recommendation first)

- **(a) Build the next harness *on* the native graph — recommended.** Take WAH's valuable application
  policy (ladders, attribution, resolution order, extraction discipline) and run it on a typed-entity
  graph that supplies edges/backlinks/resolution — i.e. loopkit. The hand-rolled denormalization
  (timelines, stakeholder map, task mirrors) is *dropped*, because the graph makes it unnecessary.
  This is exactly the [brainkit](/concepts/brainkit.md) thesis.
- **(b) Keep hand-rolling.** Continue maintaining the graph behaviors in skills. Works, but pays the
  bookkeeping tax forever and reintroduces drift the substrate would prevent.
- **(c) Record-only.** Note the convergence; build nothing.

# Citations
[1] [work-agent-harness](/sources/work-agent-harness.md) — the hand-rolled entity graph: resolution
    order, hub-and-spoke timelines, stakeholder map, source→knowledge lineage with attribution,
    emergent taxonomy, maturity ladders, mirrored tasks.
[2] [Duo — OKF Note Vault](/sources/duo-2026-note-vault.md) — `duo vault schema` (live types/entities/
    aliases), `graph backlinks`, typed templates, `id:`-based `mv`/`relink`, capture→process.
[3] [Duo Note Vault ↔ the wiki/loopkit construct](/comparisons/duo-vault-vs-wiki.md) — the companion
    comparison establishing the OKF substrate the vault and this library share.
