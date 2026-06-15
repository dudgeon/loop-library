---
type: Comparison
title: Duo Note Vault ↔ the LLM-Wiki / loopkit construct
summary: Duo's OKF Note Vault and this repo's wiki (and the shipped loopkit) are the same OKF markdown-graph substrate under three different operating models — the vault is the substrate plus a productized bookkeeping runtime; the wiki and loopkit are operating models you run on top of it.
tags: [okf, knowledge-base, ingest, query, lint, provenance, agent-harness]
timestamp: 2026-06-15T00:00:00Z
provenance: inferred
confidence: 0.65
sources: [/sources/google-2026-okf-spec.md, /sources/karpathy-2026-llm-wiki.md, /sources/duo-2026-note-vault.md]
related: [/comparisons/loopkit-vs-root.md, /concepts/loopkit-on-duo.md, /concepts/provenance.md, /loops/automation/ingest-query-lint.md]
---

> **Provenance note.** The Duo-side facts here are now grounded in the ingested
> [Duo Note Vault source](/sources/duo-2026-note-vault.md). The page stays `provenance: inferred`
> because the *framing* — one substrate, three operating models, the vault as a candidate runtime —
> is synthesis across that source plus OKF and Karpathy, not a claim stated in any single source.

## The one-line framing

> A **Note Vault is the substrate + a productized bookkeeping runtime.** The **wiki** and the
> **loopkit** are *operating models* you run on that substrate. "Is the wiki the vault?" — same
> body, different nervous systems.

Karpathy's claim is that the bottleneck of any knowledge base is **bookkeeping**, and that the
agent's job is to automate it [1]. Duo has productized exactly that bookkeeping for OKF/Obsidian
markdown graphs (capture, link-repair, listing generation, corpus introspection). This repo
currently does the same bookkeeping by hand, via `CLAUDE.md` rules + `scripts/lint.sh`. That is the
strategic crux: Duo is a candidate **runtime** for the substrate the wiki already conforms to.

## The shared spine — both are OKF markdown graphs

Duo's vault has two serializers over **one** graph model; one of them is *literally OKF v0.1* — the
same contract `wiki/` conforms to [2].

| | Duo **OKF** vault | loop-library `wiki/` |
| --- | --- | --- |
| At rest | markdown + YAML frontmatter + folders + link graph | same |
| Type field | every note carries `type:` | required `type:` (the only required field) |
| Vault marker | root `index.md` with `okf_version:` frontmatter | bundle-root `wiki/index.md` with `okf_version: "0.1"` |
| Reserved listings | generated `index.md` + `log.md` (`log.md` newest-first) | reserved `index.md` + `log.md` (newest-first) |
| Links at rest | rel-md `[Display](./note.md)`; **never** a persisted `[[wikilink]]` | bundle-relative absolute `/path.md`; **never** `[[wikilinks]]` |

At the substrate level, **the wiki *is* an OKF vault.** Duo independently arrived at the same
"OKF is the contract" decision this repo did.

## What differs — the operating model

Three things get conflated; separating them is the useful move.

| | Substrate | + Operating model | Distinctive layer |
| --- | --- | --- | --- |
| **Duo Note Vault** | OKF (or Obsidian) markdown graph | capture / search / process / publish / promote / rollups | personal work-notes; a live app with capture chords + an agent pass |
| **wiki** (Purpose 2) | OKF v0.1 bundle | `ingest` / `query` / `lint` [1] | **provenance / `sources:` / `# Citations` / conformance gate** — "why we believe this" is the product |
| **loopkit** (Purpose 1) | OKF-flavored plain markdown | `ingest` / `query` / `distill` | golden-pinning + `work/` deliverables; forkable, self-contained |

The operations map cleanly: Duo **capture** ≈ a lossy front of **ingest**; **search** ≈ **query**;
the **process** pass ≈ **lint** / **distill**; **publish** ≈ regenerating `index.md`/`log.md`.

## Two real frictions any "wiki = vault" adoption must resolve

Honest about the gaps, not just the symmetry:

1. **Identity.** The wiki uses **path-as-id** (no `id:` field) and *tolerates* broken links as
   "not-yet-written knowledge." Duo OKF **mints a stable `id:`** precisely so it can auto-repair
   links on move (`duo vault relink` resolves by `id:` first). Adopting Duo's runtime means adding
   `id:` and accepting active relinking over the wiki's deliberately-lazy broken-link tolerance.
2. **Link style.** The wiki uses `/absolute` bundle-relative links; Duo OKF uses `./relative`.
   Mechanical, but a migration — and the relative form is also the one that renders on GitHub from
   an arbitrary vendored path (see [/concepts/loopkit-on-duo.md](/concepts/loopkit-on-duo.md)).

A third asymmetry is **provenance**: Duo's vault has no notion of it (it's for work-notes, not cited
research). That's the wiki's load-bearing addition [/concepts/provenance.md](/concepts/provenance.md)
— and the thing a "research-vault flavor" of Duo would need to borrow back.

## Approaches (recommendation first)

- **(a) Treat the vault as the *runtime* under our operating models — recommended.** Keep the wiki's
  and loopkit's distinctive layers as *conventions on top of* an OKF vault, and hand the mechanical
  bookkeeping to Duo's verbs where it earns its keep (`publish` for listings, `graph orphans`/
  `backlinks` for lint, `relink`/`mv` for link-safe moves). Stop rebuilding what's solved; keep what
  is ours. This is also the clean path for **loopkit-on-Duo**
  ([/concepts/loopkit-on-duo.md](/concepts/loopkit-on-duo.md)).
- **(b) Stay separate, cross-pollinate.** Keep `wiki/` independent (path-id, abs-links, conformance)
  but borrow Duo's mechanics (stable-`id` relink, publish-style listing generation); and offer Duo a
  "research vault" flavor that adds provenance/citations its work-notes model lacks.
- **(c) Record-only.** Note the convergence and move on.

# Citations
[1] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — bookkeeping is the bottleneck; the
    agent maintains a persistent wiki via ingest/query/lint.
[2] [OKF Specification v0.1](/sources/google-2026-okf-spec.md) — the bundle contract (markdown + YAML
    frontmatter, required `type`, reserved `index.md`/`log.md`, link graph) both the vault's OKF mode
    and this wiki conform to.
[3] [Duo — OKF Note Vault](/sources/duo-2026-note-vault.md) — the vault's one-graph/two-serializer
    model, OKF mode (rel-md links, `okf_version` marker, stable `id:`, static listings), the verbs,
    and the live `duo vault schema` corpus. Ingested 2026-06-15 (ENH-208 · ENH-216).
