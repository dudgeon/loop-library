# Concepts

Cross-cutting ideas that loops rely on.

* [Progressive disclosure](/concepts/progressive-disclosure.md) — read the index first; keep each pass inside the context window.
* [Provenance](/concepts/provenance.md) — extracted vs inferred vs ambiguous; the safeguard against compounding hallucination.
* [Drift (two copies will drift)](/concepts/drift.md) — the silent failure where a page diverges from its source; lint checks pages against each other, not against sources.
* [Knowledge ↔ runtime boundary](/concepts/knowledge-runtime-boundary.md) — keep knowledge and runtime in two never-collapsed homes so a fact has one canonical location; the structural defense against drift.
* [Defense in depth (mechanical enforcement)](/concepts/defense-in-depth.md) — stack cheap independent nets + a completion gate; enforcement must fix or interrupt, never quietly log.
* [Loopkit on Duo](/concepts/loopkit-on-duo.md) — design (unvalidated, not shipped): how loopkit gains from Duo as an optional host without failing without it.
* [brainkit](/concepts/brainkit.md) — candidate (built in `dist/brainkit`, not yet validated): the WAH application layer rebuilt as policy on loopkit; the three features + the embodied task model.
* [Kit sync as curation, not overwrite](/concepts/kit-sync.md) — real-use finding: refresh a vendored kit's machinery by agent curation (read what changed upstream, pull only what's approved, merge local tweaks) — never a deterministic overwrite script.

_Candidates awaiting sources:_ termination conditions, idempotency, convergence,
cost-control, context-management, human-in-the-loop.
