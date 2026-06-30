# DESIGN.md — why brainkit is shaped this way

This is the *why* behind the kit, for anyone extending it or deciding whether it fits. `CLAUDE.md` is
how the assistant operates brainkit day to day; [`FOUNDATION.md`](FOUNDATION.md) is the loopkit
contract brainkit is built on; this file is the design rationale and the seam between what brainkit
brings and what it deliberately leaves out.

## The one-line idea

brainkit is a **second brain** that makes *intake* high-fidelity and *knowledge* trustworthy enough to
drive a deliverable. It is **loopkit's entity-graph foundation plus a policy layer** — a few starter
entity types, retrieval-grade intake, per-entity timelines, maturity/lineage, and a task model.
Everything is justified against one goal:

> **Recursive loops that build knowledge to improve one or more declared work products.**

Knowledge is never an end in itself. It accrues to make a deliverable better, and each pass makes the
next intake cheaper. Two corollaries drive the whole design: **retrieval is the point** (so intake
pays an enrichment tax up front) and **trust is the point** (so knowledge carries maturity and
lineage).

## Policy, not plumbing — and the two foundation rules v2 relaxes

brainkit changes **policy** — the skill bodies, the starter types, the first-run interview, the
`PROJECT.md` shape. It changes the foundation **contract** in exactly **two** places (both in
contract v2, both additive and OKF-conformant): `id:` is now tool-mintable, and folders are now
derived from the parent edge. Every other foundation invariant is preserved exactly, and any feature
that would violate one is out of scope.

### Invariant ledger — the checkable "what's unchanged"

This table is what makes "keeps the contract unchanged" a *mechanical* claim rather than a promise:
diff a fork against it. Only two rows are **CHANGED**.

| Foundation invariant | v1 | v2 | Changed? |
|---|---|---|---|
| Notes are typed entities; `type:` is the node field | yes | yes | — |
| Frontmatter is a floor; **never drop an unknown key** | yes | yes | — |
| Links are rel-md edges (no `[[wikilinks]]`, no `/absolute`); an edge can carry a payload | yes | yes | — |
| Edges survive a split | yes | yes | — |
| Derived views regenerated + stamped — never hand-cached, never query-time | yes | yes | — |
| Resolution leans on the vault/notes; persist nothing extra | yes | yes | — |
| Reserved files (`index.md` / `log.md`) are not nodes | yes | yes | — |
| **Identity is `id:` or filename — never the folder path** | yes | yes | — *(load-bearing for the new derived path)* |
| **`id:` minting** | optional, **never minted by the kit** | **tool-mintable + always preserved** (heal id-first, then filename) | **CHANGED — D4** |
| **Folder placement** | flat bag; folders carry only ownership/lifecycle meaning | **derived from the `parent:` edge by default** (a WBS projection of the graph); secondary groupings are `index.md` outlines | **CHANGED — D1** |

The two changes are coupled on purpose: the derived folder path needs **loss-free moves** (re-parent →
re-file without breaking inbound links), and loss-free moves need an **id-first relink**, which needs a
**mintable `id:`**. You can't take the folder change without the `id:` change.

## The three features

**F1 — interactive entity & alias resolution at intake.** When capture references something ambiguous,
resolve it *with the user, at capture*, rather than guessing or deferring. Vault-first when a graph
host is present; otherwise existing notes → golden → ask. Record the resolved alias on the canonical
note, so the next capture auto-resolves — that recording is the recursive loop in miniature. Never
upgrade a name you can't verify.

**F2 — write-time, re-derivable per-entity timelines.** A type can declare it carries a timeline; those
entities get a `## Timeline` maintained at write time (appended at ingest, re-derived at distill),
never computed at query time. It's a *regenerated view*, fenced with generated markers so a hand-edit
is detected rather than clobbered. The load-bearing rule: the timeline is an **index** of linked
notes, not a store — a fact never lives *only* there, so append-then-heal can't drift. An entity is
"timeline-touched" by a note only if it's an attendee or explicitly-linked subject — incidental
mentions don't append.

**F3 — source enrichment at intake.** Messy capture (shorthand, acronyms) becomes one enriched note:
terms expanded, entities linked, so it's retrievable later. Augment into a single note — never a
synced "clean twin." The verbatim original is preserved in a `## Raw` section (external-link only when
the original is durable, and even then key excerpts are snapshotted in-file). The enriched body is a
faithful transform, not the fidelity record. Genuinely reusable ideas are *extracted* into their own
notes with a lineage edge — never a cleaned copy of the whole source.

## Aligned primitives

Beyond the three features, brainkit adopts the parts of the predecessor model that serve the north
star: **source→knowledge lineage** with citation-bearing edges; **maturity ladders**
(`unread→reading→read→processed`, `draft→solid→canonical`); a **gap-analysis** query mode ("what's
missing for *this* deliverable?") that closes the loop; a **reading-queue** view; and **extraction
discipline** (one idea per note, name it by what it teaches, don't duplicate—enrich).

> **This content layer is brainkit's most differentiated, validated-by-design asset — and it is the
> canonical reference a Duo vault adopts as OPTIONAL conventions** (D6: port brainkit's content layer
> *into* Duo, not the reverse). Duo's general work-notes vault has no maturity ladder, no task
> primitive, and no `## Raw` rule today; these brainkit conventions are what it copies. Nothing here is
> cut — it's kept here and referenced there.

## Tasks: typed nodes, one source of truth

Task extraction runs at intake regardless of policy; the *sink* is a policy choice (`embodied` by
default, `externalized`, or `off`). The default makes a task a graph **node** with owner,
`requested_by`, `due`, `status`, and a **`parent`** edge to a parent task or the initiative /
work-product it advances. That hierarchy is *knowledge* — it connects "what needs doing" to "what
we're building." It is also **the primary axis the derived folder path follows** (v2): a task with a
`parent:` files inside the parent's folder, so the task tree *is* a browsable work-breakdown on disk.
Integrity rules keep it honest: no cycles (checked at ingest), a task with open children isn't retired
(children re-parent first), and status is a closeable/reopenable transition. The non-negotiable: **one
source of truth, no mirrors** — no second copy of a task in any other file.

## What brainkit deliberately does NOT do

The predecessor this model comes from was a hand-rolled knowledge system that also carried machinery a
typed-entity graph makes unnecessary or that belongs to a different loop. brainkit excludes it on
purpose:

- **No hand-copied "hub-and-spoke" timelines** — the graph's backlinks and the regenerated timeline
  replace them.
- **No hand-maintained cross-entity map** (e.g. a stakeholder map babysat by hand) — if wanted, it's a
  *regenerated* `index-view`, not hand-kept.
- **No mirrored task list** — a single-source-of-truth node, never a copy that can drift.
- **No multi-agent control-file mirroring, no publish/share pipeline, no strategy/roadmap layer** —
  those are separate concerns, not knowledge-compilation, and would overload the loop.
- **No second folder tree for secondary groupings** *(new in v2)* — the parent edge gets the one
  derived folder tree; every *other* way you'd want to slice the graph (by person, by quarter) is a
  regenerated `index.md` nested-bullet outline, not a competing directory layout.
- **No `id:` churn** *(new in v2)* — a stable `id:` is minted once and preserved forever; the kit
  never rewrites or reuses one. Minting is additive (at create or explicit backfill), never a
  rolling rename.

People, tasks, and domains can still exist — but as plain typed notes and folders, not as their own
hand-maintained subsystems. That restraint is what keeps brainkit a *foundation-respecting* application
rather than a second machine rebuilt on top of the first.

## Extending it

Build richer policy in *your* layer — a lifecycle, a tier scheme, a domain convention — as type
templates and skill conventions, not as changes to the foundation contract. Preserve unknown keys in
anything that rewrites a note; keep links rel-md; let derived views regenerate; let the graph host
(when present) own identity and resolution. Stay inside those and your additions compose cleanly — and
the kit stays a clean, GitHub-readable, graph-host-openable second brain the whole way up.

---

*Conformance check for a v2 build:* every **—** row of the invariant ledger holds unchanged, **and**
both CHANGED rows are present (a mintable-but-preserved `id:`, and parent-derived folders with `id:`
heal on move). A fork that drops an unknown key, hand-caches a view, or ties identity to the path is
not conformant — regardless of version number.
