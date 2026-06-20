# Changelog

All notable changes to brainkit. This project follows semantic versioning.

## 0.1.0 — 2026-06-18 (candidate)
**First release — a "second brain" built on loopkit.** brainkit is the application layer on loopkit's
entity-graph foundation (see [`FOUNDATION.md`](FOUNDATION.md)): it re-authors the three
operations and ships a few starter entity types so that **intake is high-fidelity** and **knowledge is
trustworthy enough to drive a deliverable.** loopkit's contract is unchanged — brainkit is **policy,
not plumbing.** Candidate — pending real-use validation.

- **North star.** *Recursive loops that build knowledge to improve one or more declared work products.*
  Knowledge is never an end in itself; it accrues in service of a deliverable, and each pass makes the
  next intake cheaper.
- **Retrieval-grade ingest.** Vague references are resolved **interactively, with you, at capture**;
  acronyms/shorthand are expanded and entities linked, so a note is findable and linkable later. A
  resolved alias is recorded on the canonical note, so the next capture auto-resolves.
- **Raw is preserved, additively.** The enriched note is the substance; the verbatim original is kept
  in a `## Raw` section (or, for a durable external original, a link — with key excerpts snapshotted
  in-file). The enriched body is a faithful transform, never the fidelity record.
- **Per-entity timelines, write-time and re-derivable.** A type can declare `timeline: true`; those
  entities carry a `## Timeline` section that `ingest` appends to and `distill` re-derives from the
  graph — wrapped in generated markers, never a query-time computation, never hand-cached.
- **Tasks as typed nodes (embodied by default).** A `task` is a node with owner / `requested_by` /
  `due` / `status` and a **`parent`** edge (task→task and task→initiative/work-product). The node is
  the single source of truth — **no mirrors.** `task_policy` in `PROJECT.md` can switch to
  `externalized` (hand off to a real tracker, keep only a pointer) or `off`.
- **Maturity + lineage.** Sources ladder `unread→reading→read→processed`; knowledge ladders
  `draft→solid→canonical`; every claim traces to its source via a citation-bearing edge; `query` can
  ask *"what's missing for this deliverable?"*
- **Starter entity types** (`source`, `meeting`, `note`, `decision`, `person`, `task`) ship under
  `knowledge/templates/` as **seed-once** content — yours to edit; sync never overwrites them.
- **Drops the hand-rolled predecessor's breakers.** No hand-copied hub-spoke timelines, no hand-maintained stakeholder map, no
  mirrored task list, no cross-agent mirror-sync, no publishing pipeline, no domain-strategy layer.

Built on **loopkit** v0.1.0 (typed entities, payload-bearing edges, entity resolution, types-as-
templates, ships-as-a-Duo-vault), which descends from the Karpathy LLM-wiki primitive shipped as
**karpathy-core**. Designed and hardened by a 50-agent foreclosure pass (1 blocker + 9 majors + 9
minors, all folded in). See [`DESIGN.md`](DESIGN.md) for the why.

_2026-06-20 (candidate, no version bump): **AskUserQuestion interaction style** (`CLAUDE.md` §17) —
brainkit's retrieval-grade intake asks the user a lot (entity matches, ambiguous aliases, retire/merge/
re-parent), so those confirmations now use the structured prompt with concrete options instead of
free-text. Applied across the kit family._
