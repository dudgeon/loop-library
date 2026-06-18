# DESIGN.md — why brainkit is shaped this way

This is the *why* behind the kit, for anyone extending it or deciding whether it fits. `CLAUDE.md` is
how the assistant operates brainkit day to day; [`FOUNDATION.md`](FOUNDATION.md) is the loopkit
contract brainkit is built on; this file is the design rationale and the seam between what brainkit
brings and what it deliberately leaves out.

## The one-line idea

brainkit is a **second brain** that makes *intake* high-fidelity and *knowledge* trustworthy enough to
drive a deliverable. It is **loopkit's entity-graph foundation, unchanged, plus a policy layer** — a
few starter entity types, retrieval-grade intake, per-entity timelines, maturity/lineage, and a task
model. Everything is justified against one goal:

> **Recursive loops that build knowledge to improve one or more declared work products.**

Knowledge is never an end in itself. It accrues to make a deliverable better, and each pass makes the
next intake cheaper. Two corollaries drive the whole design: **retrieval is the point** (so intake
pays an enrichment tax up front) and **trust is the point** (so knowledge carries maturity and
lineage).

## Policy, not plumbing

brainkit changes **policy** — the skill bodies, the starter types, the first-run interview, the
`PROJECT.md` shape. It does **not** change loopkit's **contract**. These foundation invariants are
preserved exactly, and any feature that would violate one is out of scope:

| Invariant (from the foundation) | brainkit relies on it for |
|---|---|
| Notes are typed entities; `type:` is the node field | every starter type |
| Frontmatter is a floor; **never drop an unknown key** | user-added `status:`/`owner:`/`aliases:` survive every pass |
| Links are rel-md edges; an edge can carry a payload | citation quotes, attribution, timeline back-refs |
| Edges survive a split | attribution + parentage surviving task/knowledge extraction |
| `id:` optional, never minted by the kit | safe moves; Duo interop |
| **Derived views regenerated + stamped — never hand-cached / never query-time** | the per-entity timeline, the reading-queue view |
| Resolution leans on the vault/notes; persist nothing extra | interactive resolution; aliases live *on the entity note* |
| Golden is locked; keep it light — no databases, no schema grids | starters are prose templates |

If a proposed feature can't be expressed within that table, it doesn't belong in brainkit.

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

## Tasks: typed nodes, one source of truth

Task extraction runs at intake regardless of policy; the *sink* is a policy choice (`embodied` by
default, `externalized`, or `off`). The default makes a task a graph **node** with owner,
`requested_by`, `due`, `status`, and a **`parent`** edge to a parent task or the initiative /
work-product it advances. That hierarchy is *knowledge* — it connects "what needs doing" to "what
we're building." Integrity rules keep it honest: no cycles (checked at ingest), a task with open
children isn't retired (children re-parent first), and status is a closeable/reopenable transition.
The non-negotiable: **one source of truth, no mirrors** — no second copy of a task in any other file.

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

People, tasks, and domains can still exist — but as plain typed notes and folders, not as their own
hand-maintained subsystems. That restraint is what keeps brainkit a *foundation-respecting* application
rather than a second machine rebuilt on top of the first.

## Extending it

Build richer policy in *your* layer — a lifecycle, a tier scheme, a domain convention — as type
templates and skill conventions, not as changes to the foundation contract. Preserve unknown keys in
anything that rewrites a note; keep links rel-md; let derived views regenerate; let the graph host
(when present) own identity and resolution. Stay inside those and your additions compose cleanly — and
the kit stays a clean, GitHub-readable, graph-host-openable second brain the whole way up.
