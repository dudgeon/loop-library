# Changelog

All notable changes to brainkit. This project follows semantic versioning.

## 0.3.0 — 2026-06-29 (candidate)
**Contract v2 — `id:` becomes mintable, folders follow the parent edge.** Exactly two foundation rules
relax (see the invariant ledger in [`DESIGN.md`](DESIGN.md)); everything else is unchanged. This entry
is the **contract-version anchor**: a vault is **contract v2** iff `loop.manifest.json` `version` ≥
`0.3.0` (and `FOUNDATION.md` carries `contract_version: 2`). NOTE: `0.2.0` is still **contract v1** — it
was the sync-skill change, where `id:` is still "never mint." Migrating a pre-`0.3.0` vault to contract
v2 is a one-time, atomic, reversible pass — see [`MIGRATION.md`](MIGRATION.md).

- **`id:` is a shared, tool-mintable integrity tag** (was: "never minted by the kit"). The kit may mint
  a short, opaque, URL-safe, vault-unique `id:` and always preserves one it finds; links heal id-first,
  then by filename. A **contract, not an algorithm** — Duo's 8-char base36 is the reference shape.
- **Folders are derived from the `parent:` edge, by default.** A note with a parent files inside the
  parent's folder, recursively — the folder tree mirrors the work-breakdown. The graph stays canonical;
  re-parent/reorg is loss-free via `id:`. Parentless notes stay in flat type folders; secondary
  groupings are `index.md` nested-bullet outlines, never a second folder tree.
- **At-rest format reframed: bare Google OKF v0.1 + the shared `id:` tag + a documented dialect.** A Duo
  vault and a brainkit vault are both valid bare OKF v0.1 and interoperate at rest.
- **Content layer kept — and now the reference a Duo vault adopts** as OPTIONAL conventions (maturity
  ladders, task model, `## Raw` provenance, deliverable-coupling). Nothing cut.
- **New `MIGRATION.md`** (a managed file): contract-version detection, behave-by-version rules for
  agents on old/modified vaults, and the atomic contract v1 → v2 migration. The `sync` skill carries the
  v2 machinery; seed-once type templates need the hand-update steps in `MIGRATION.md`.

## 0.2.0 — 2026-06-28 (candidate)
**Sync is now a curation skill, not a deterministic script.** Real use surfaced that the old
`scripts/sync.sh` — which overwrote every `managed_files` path from origin — *nuked intentional local
tweaks* to managed files (a tweaked `CLAUDE.md`, an adjusted skill). That's the wrong model for an
LLM-maintained kit.

- **Removed `scripts/sync.sh`** (and the empty `scripts/` dir). Updating the kit is no longer a
  bulk-overwrite.
- **Added the `sync` skill** (`.claude/skills/sync/SKILL.md`) — a fourth operation alongside
  ingest/query/distill. The assistant reads what changed in canonical brainkit, **reasons about which
  upstream improvements are worth adopting here**, and pulls in only what you approve — **merging, never
  clobbering, your local tweaks**. Non-deterministic and suggest-only, like `distill`.
- **`loop.manifest.json`** keeps `managed_files`, but its meaning shifts from "paths `sync.sh`
  overwrites" to "machinery files the `sync` skill *compares against upstream and may offer to update*."
  `scripts/sync.sh` dropped from the list; `.claude/skills/sync/SKILL.md` added.
- Docs updated throughout (`CLAUDE.md` §11/§15 + header, `README.md`, `work/README.md`) to describe
  curate-don't-overwrite. **Contract for your content is unchanged** — sync still touches nothing
  outside `managed_files`.

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
