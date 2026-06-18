---
type: Concept
title: brainkit — the WAH application layer on loopkit
summary: brainkit is the work-agent-harness application layer rebuilt as a policy layer on loopkit — re-authored ingest/query/distill + starter entity types + a first-run interview, with loopkit's contract unchanged — keeping WAH's valuable policy (retrieval-grade intake, maturity/lineage, attribution, an embodied task model) and dropping its breakers (hand-copied timelines, the stakeholder map, mirrored tasks, mirror-sync, publishing, the strategy layer).
tags: [entity-graph, knowledge-base, ingest, query, lint, agent-harness, dist, provenance]
timestamp: 2026-06-18T00:00:00Z
provenance: inferred
confidence: 0.7
sources: [/sources/brainkit-spec.md, /sources/work-agent-harness.md, /sources/karpathy-2026-llm-wiki.md, /sources/duo-2026-note-vault.md]
related: [/comparisons/wah-vs-duo-vault.md, /concepts/loopkit-on-duo.md, /comparisons/loopkit-vs-root.md]
---

> **Status — candidate (not yet validated by real use).** brainkit v0.1.0 is **built** in
> `dist/brainkit` on the maintainer's authorization (2026-06-18) and **foreclosure-tested** by a
> 50-agent pass (1 blocker + 9 majors + 9 minors, all folded in), but has **not** been validated by
> real use. `provenance: inferred` — the design is synthesis across the [WAH
> source](/sources/work-agent-harness.md), loopkit, and a design conversation; it is grounded but not
> proven. Lineage: `karpathy-core` → loopkit → **brainkit**.

## The one-line idea

> brainkit = **loopkit's entity-graph foundation, unchanged, plus a policy layer** that makes *intake*
> high-fidelity and *knowledge* trustworthy enough to drive a deliverable.

Its north star — *recursive loops that build knowledge to improve one or more declared work products*
— is a sharper articulation of what a vendored loop kit is *for* than the foundation states. Two
corollaries shape every operation: **retrieval is the point** (intake pays an enrichment tax up front)
and **trust is the point** (knowledge carries maturity + lineage).

## Why "policy, not plumbing"

brainkit changes skill bodies, starter types, and the first-run interview; it does **not** touch
loopkit's contract. This is the discipline that keeps the [hand-rolled-vs-native
lesson](/comparisons/wah-vs-duo-vault.md) intact: build the application *on* the native graph, don't
re-hand-roll it. Every loopkit invariant is preserved — preserve-unknown-keys, regenerated-not-cached
views, persist-nothing resolution, edges-survive-a-split, golden locked, keep-it-light. A feature that
can't be expressed within those is out of scope.

## The three features (the new policy)

| | What it does | The invariant that keeps it safe |
| --- | --- | --- |
| **F1 — interactive resolution** | resolve vague references *with the user, at capture*; record the alias on the canonical note so the next capture auto-resolves | vault-first; persist nothing but the alias-on-note; never upgrade a name you can't verify |
| **F2 — write-time timelines** | declared types carry a `## Timeline` appended at ingest, re-derived at distill — never query-time | a *regenerated view* fenced with generated markers; an entry indexes a linked note (a fact never lives only in the timeline); "touch" = attendee or explicitly-linked subject |
| **F3 — source enrichment** | expand acronyms/shorthand, link entities, into one note; preserve raw | augment one note (no synced twin); raw kept in-file (`## Raw`), external link only when durable; the enriched body is a faithful transform, not the fidelity record |

F1 and F3 are one engine: **interactive alias/entity resolution at intake that teaches the graph**, so
retrieval and linking get cheaper every pass — the recursive loop in miniature.

## Tasks: embodied typed nodes

Task extraction runs at intake regardless of policy; the *sink* is `task_policy` (default `embodied`).
A task is a node with owner / `requested_by` / `due` / `status` (`[open, in-progress, blocked, done]`)
and a **`parent`** edge to a parent task or the initiative/work-product it advances — *knowledge* that
wires "what needs doing" to "what we're building." Integrity: cycles refused at ingest, a task with
open children isn't retired, status is closeable/reopenable, and the rule that turns WAH's breaker into
a non-breaker — **one source of truth, no mirrors.**

## What it deliberately excludes

From the [divergence analysis](/comparisons/wah-vs-duo-vault.md): brainkit ports WAH's build-on-top
band (typed vocabulary, ladders, lineage, resolution order, extraction discipline) and **excludes** the
breakers — hand-copied hub-and-spoke timelines (dissolved by F2 + the graph), the hand-maintained
stakeholder map (a regenerated `index-view` if ever wanted), **mirrored** tasks, cross-agent
mirror-sync, the publishing pipeline, and the domain-strategy/roadmap layer (a different loop).

## Significance for the library

Once exercised in real use, brainkit will also **validate loopkit's foundation seam**: a clean
application composing on loopkit's affordances (typed nodes, payload-bearing edges, regenerated views,
resolution) is the real-use evidence loopkit's own candidate is waiting for. It is the first kit that
*brings vocabulary* to the foundation rather than being one.

# Citations
[1] [brainkit spec](/sources/brainkit-spec.md) — the design-of-record: the three features, the task
    model, the policy-not-plumbing thesis, and the foreclosure resolutions.
[2] [work-agent-harness](/sources/work-agent-harness.md) — the hand-rolled predecessor brainkit ports
    (resolution order, status ladders, attribution-survives-decomposition, extraction discipline).
[3] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — the ingest/query/lint loop brainkit's
    three operations descend from.
[4] [Duo — OKF Note Vault](/sources/duo-2026-note-vault.md) — the native typed-entity graph (aliases,
    backlinks, regenerated listings) brainkit's policy leans on when a vault is present.
