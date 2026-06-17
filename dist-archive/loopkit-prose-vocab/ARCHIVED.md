# ARCHIVED — loopkit, prose-vocabulary candidate (v0.2.0, PR #6)

> **Not maintained, not shipped.** A frozen snapshot of a discarded design direction, kept for the
> record. The live foundation kit is [`dist/loopkit/`](../../dist/loopkit/) (the entity-graph version).

## What this was
An attempt to give loopkit entity awareness by holding an "encoded vocabulary" as **golden prose**
(`knowledge/golden/vocabulary.md`) and computing the "observed" rung live in `distill` — a
progressive-enhancement layer over the Karpathy core, Duo-optional.

## Why it was discarded
It **under-read the goal.** The user wanted a typed-entity *graph* with resolution; this reduced
entities to a single prose blurb and refused typed entities (`type:`). The reframe that replaced it:
loopkit is the **entity-graph foundation** a richer work agent is built *on* — typed nodes,
payload-bearing edges, and resolution leaning on a Duo vault. See `dist/loopkit/` and
`_meta/SPEC-loopkit-entity-foundation.md`.

## Provenance
- Built on branch `claude/loopkit-on-duo-build`, **PR #6** (closed, not merged).
- Its fuller design record — including an as-built §12 section — is the superseded
  `_meta/SPEC-loopkit-on-duo.md` and the PR #6 history.
