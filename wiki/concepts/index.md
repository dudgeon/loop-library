# Concepts

Cross-cutting ideas that loops rely on.

* [Progressive disclosure](/concepts/progressive-disclosure.md) — read the index first; keep each pass inside the context window.
* [Provenance](/concepts/provenance.md) — extracted vs inferred vs ambiguous; the safeguard against compounding hallucination.
* [Drift (two copies will drift)](/concepts/drift.md) — the silent failure where a page diverges from its source; lint checks pages against each other, not against sources.
* [Loopkit on Duo](/concepts/loopkit-on-duo.md) — design (unvalidated, not shipped): how loopkit gains from Duo as an optional host without failing without it.
* [brainkit](/concepts/brainkit.md) — candidate (built in `dist/brainkit`, not yet validated): the WAH application layer rebuilt as policy on loopkit; the three features + the embodied task model.

_Candidates awaiting sources:_ termination conditions, idempotency, convergence,
cost-control, context-management, human-in-the-loop.
