# dist/ — shipped loop kits (Purpose 1)

`dist/` is the **shipping target** for vendorable loop kits. Shipping here is treated like
**shipping software**: deliberate, versioned, and reserved for patterns we have **extremely
high confidence** in. Nothing lands here by default.

## Currently shipped

### loopkit — v0.1.0 (2026-06-15)
A forkable **context-aware project**: a knowledge base of plain markdown that stays sharp through
three operations — **ingest / query / distill** (the Karpathy LLM-wiki loop; `distill` = his
`lint`). Ships golden (locked) context with a "pin this" promotion path, and multiple deliverables
in `work/` whose sections can be locked and finalized one at a time. Setup and golden-pinning are
`CLAUDE.md` rules, not skills. **Self-contained** — no dependency on this repo's wiki.

- Path: [`dist/loopkit/`](loopkit/) · README, CLAUDE.md, three skills, templates, semver +
  CHANGELOG + `loop.manifest.json` + `scripts/sync.sh` (managed-vs-user split realized & tested).
- Go/no-go: explicit human decision (2026-06-15), after a multi-pass design review.
- Status: **v0 — shipped for use and dogfooding.** Real-use validation is ongoing; expect
  refinement before a 1.0. Known v0 limits are in its CHANGELOG.

#### Proposed: v0.2.0 — Duo-optional + resolve-once vocabulary (PENDING go/no-go)
Built on branch `claude/loopkit-on-duo-build` per [`_meta/SPEC-loopkit-on-duo.md`](../_meta/SPEC-loopkit-on-duo.md)
(phases P1–P3; P4 deferred). Adds an optional golden-prose **vocabulary** the kit resolves against at
query time, a relative-markdown link convention, and an **opt-in** "open in Duo" path — all
degrading cleanly when Duo is absent. **Not shipped:** this is a separate PR awaiting the §8 go/no-go;
`main` remains v0.1.0 until that decision. On merge, update this entry to "shipped".

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
