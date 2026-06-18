---
type: Source
title: brainkit spec (SPEC-brainkit.md)
description: The design-of-record for brainkit — the WAH application layer rebuilt as a policy layer on loopkit (re-authored ingest/query/distill + starter entity types + a first-run interview, loopkit's contract unchanged). Resolves the design forks, defines the three features (interactive resolution, write-time timelines, source enrichment) and the embodied task model, and records a 50-agent foreclosure pass.
tags: [entity-graph, knowledge-base, ingest, query, lint, agent-harness, dist, spec]
authors: [dudgeon, loop-library]
published: '2026'
timestamp: 2026-06-18T00:00:00Z
resource: ../_meta/SPEC-brainkit.md
raw_mirror: ../_meta/SPEC-brainkit.md
---

# brainkit spec

The living design-of-record for [brainkit](/concepts/brainkit.md), maintained at
`_meta/SPEC-brainkit.md` and shipped (stripped, self-contained) inside the kit as its `DESIGN.md`.
brainkit is the work-agent-harness application layer rebuilt as **policy on loopkit** — re-authored
`ingest`/`query`/`distill`, a few starter entity types, and a first-run interview, with loopkit's
contract unchanged ("policy, not plumbing").

# Key points

- **North star:** *recursive loops that build knowledge to improve one or more declared work products.*
- **Policy, not plumbing:** preserves every loopkit invariant (preserve-unknown-keys, regenerated-not-
  cached views, persist-nothing resolution, edges-survive-a-split, golden locked, keep-it-light).
- **Three features:** F1 interactive entity/alias resolution at intake (vault-first; aliases recorded
  on the canonical note); F2 write-time, re-derivable, per-entity timelines (fenced generated markers;
  attendee/linked-subject "touch" predicate); F3 source enrichment (expand + link; raw preserved
  in-file, durability-gated; faithful-transform body; extraction ≠ cleaned copy).
- **Tasks as embodied typed nodes** with `parent` edges (cycle-checked; orphan-on-retire guarded;
  `[open, in-progress, blocked, done]` ladder; `task_policy` in `PROJECT.md`), single source of truth.
- **Excludes the WAH breakers:** hand-copied timelines, hand-maintained stakeholder map, mirrored
  tasks, cross-agent mirror-sync, publishing, the domain-strategy layer.
- **Hardened** by a 50-agent foreclosure pass (1 blocker + 9 majors + 9 minors, all folded in).

# Compiled into

- [brainkit — the WAH application layer on loopkit](/concepts/brainkit.md)
