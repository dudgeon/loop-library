# dist/ — shipped loop kits (Purpose 1)

`dist/` is the **shipping target** for vendorable loop kits. Shipping here is treated like
**shipping software**: deliberate, versioned, and reserved for patterns we have **extremely
high confidence** in. Nothing lands here by default.

## Currently shipped — the loop-kit family

`dist/` holds a **family** of vendorable kits that share the Karpathy ingest / query / distill
lineage, layered from a minimal primitive up. Each is self-contained (its own `CLAUDE.md`, skills,
`loop.manifest.json`, `scripts/sync.sh`); they're related by heritage, not by dependency.

### karpathy-core — v0.1.1
The pure **Karpathy LLM-wiki / OKF primitive**: ingest / query / distill over a plain-markdown
knowledge base, golden (locked) context with a "pin this" promotion path, and multiple `work/`
deliverables whose sections can be locked one at a time. Minimal and self-contained — **no
entity-graph, no Duo machinery**. The floor of the family. (v0.1.1, 2026-06-20: mid-task
confirmations use the structured AskUserQuestion prompt — behavior-only, contract unchanged.)

- Path: [`dist/karpathy-core/`](karpathy-core/). This is the original kit (shipped 2026-06-15),
  preserved under its proper name when the entity-graph work spun out as `loopkit`.
- Status: **stable primitive, shipped for use.** Known v0 limits are in its CHANGELOG.

### loopkit — v0.1.0 (CANDIDATE, 2026-06-16 · branch `claude/loopkit-entity-foundation`)
The **entity-graph foundation**, built on the same loop: typed `type:` nodes, payload-bearing
relative-markdown edges, preserve-unknown-keys, entity resolution in `ingest` + `distill`, types
written down at `knowledge/templates/`, and **ships-as-a-Duo-vault** (the marker rides the starter
`knowledge/index.md`). The foundation a future work-agent-harness is built *on*, not *in*. Ships
`FOUNDATION.md` for builders.

- Path: [`dist/loopkit/`](loopkit/) · Spec: [`_meta/SPEC-loopkit-entity-foundation.md`](../_meta/SPEC-loopkit-entity-foundation.md).
- Go/no-go: the human **authorized building a candidate** (2026-06-16); decisions Q1–Q7 resolved;
  designed + foreclosure-tested by a 23-agent pass, then a 4-lens build review (1 major + 3 minors
  fixed). **Not yet validated by real use** → a candidate on its branch/PR; merges on a deliberate call.
- Lineage: descends from `karpathy-core`; an earlier prose-vocabulary attempt (PR #6) was discarded.

### brainkit — v0.1.0 (CANDIDATE, 2026-06-18 · branch `claude/elegant-mayer-f52497`)
The **work-agent-harness application layer**, rebuilt as **policy on loopkit** — re-authored
ingest/query/distill + starter entity types + a first-run interview, with loopkit's contract
**unchanged** (no plumbing change). Core: **retrieval-grade ingest** (interactive entity/alias
resolution + acronym/shorthand expansion, raw preserved), **write-time re-derivable per-entity
timelines**, source→knowledge **maturity + lineage**, and **embodied tasks as typed nodes with parent
edges**. Ports WAH's valuable policy; drops its breakers (hand-copied timelines, the hand-maintained
stakeholder map, mirrored tasks, cross-agent mirror-sync, publishing, the domain-strategy layer).

- Path: [`dist/brainkit/`](brainkit/) · Spec: [`_meta/SPEC-brainkit.md`](../_meta/SPEC-brainkit.md) ·
  ships a self-contained `DESIGN.md`. Lineage: `karpathy-core` → `loopkit` → **brainkit**.
- Go/no-go: maintainer **authorized the build** (2026-06-18); 6 design forks resolved; foreclosure-tested
  by a 50-agent pass (1 blocker + 9 majors + 9 minors, all folded in). **Not yet validated by real
  use** → a candidate. Building it also exercises loopkit's `FOUNDATION.md` seam (loopkit's own
  validation).

## Archived (built, not shipped)
Discarded directions are preserved — not deleted — in [`../dist-archive/`](../dist-archive/):

- **loopkit-prose-vocab** (v0.2.0, PR #6) — the prose-vocabulary attempt that under-read the goal;
  superseded by the entity-graph `loopkit`. See `dist-archive/loopkit-prose-vocab/ARCHIVED.md`.

## The promotion bar (research → `dist/`)

A pattern may be promoted from the research loop (`wiki/`) into `dist/` only when **all** hold:

1. **Validated** — grounded in cited sources and/or real use, recorded in `wiki/`, not notional.
2. **Confidence: very-high** — tracked on its task in the parent loop (see the repo's
   task register, once established).
3. **Deliberate human review** — an explicit go/no-go, not a side effect of building something.
4. **Shippable** — semver + CHANGELOG + `loop.manifest.json` + `scripts/sync.sh`, README, and
   the managed-vs-user file split below.

This gate is the thing whose *absence* let a notional idea ship prematurely. It now exists.

## Under research (not shipped)

- **vanilla-loop** (a goal-definition + output-requirements scaffold) — **withdrawn from
  `dist/` on 2026-06-15** as premature; it was a notional idea, not a validated pattern. It is
  now an open research question in the parent loop. It ships only if it clears the bar above.

## Sync mechanism (the design we'll use when we ship)

Each shipped kit will carry a self-describing `loop.manifest.json` splitting files into:

- **`managed_files`** — the loop machinery (skill, templates, scripts, docs). `scripts/sync.sh`
  overwrites these from origin.
- **`user_files`** — the vendor's content (their goal, requirements, logs, runs). `sync.sh`
  never touches these.

This is the OKF "self-describing bundle" idea applied to a code artifact: a vendored copy knows
where it came from and updates only its engine. **Realized in `loopkit` v0.1.0** —
`dist/loopkit/loop.manifest.json` lists `managed_files`; `scripts/sync.sh` overwrites only those
and never touches `PROJECT.md`, `knowledge/`, or the user's `work/` deliverables.
