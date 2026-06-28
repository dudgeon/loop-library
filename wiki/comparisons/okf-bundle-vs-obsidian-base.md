---
type: Comparison
title: OKF bundle ↔ Obsidian Bases (.base)
description: An OKF "bundle" and an Obsidian ".base" are not the same kind of thing — a bundle is the corpus/container (bundle ≈ vault, concept ≈ note), while a .base is a saved view/query over note frontmatter (≈ a SQL VIEW). Maps the layers, and records where this repo's OKF usage diverges from Obsidian conventions.
tags: [okf, obsidian, knowledge-base, frontmatter, view, provenance]
timestamp: 2026-06-28T00:00:00Z
summary: An OKF bundle is the corpus/container (bundle ≈ Obsidian vault, concept ≈ note, frontmatter ≈ the YAML block); an Obsidian `.base` is a layer below it — a YAML-encoded saved view/query over notes' frontmatter (≈ a SQL VIEW), holding no notes of its own. This repo adopted the bundle pattern (wiki/ is an OKF bundle; dist/ kits apply the self-describing-bundle idea to code) and ships nothing like a `.base`; its real divergences from OKF are deliberate extensions (provenance, typed edges, strict conformance).
provenance: extracted
confidence: 0.75
sources: [/sources/obsidian-2026-bases.md, /sources/google-2026-okf-spec.md, /sources/karpathy-2026-llm-wiki.md]
related: [/comparisons/duo-vault-vs-wiki.md, /comparisons/wiki-vs-context-graph.md, /concepts/drift.md]
---

A maintainer watching a talk that referenced the OKF *"bundle"* asked: is the bundle a pattern this
repo shipped or ignored, and is it analogous to an Obsidian `.base`? Short answers: **shipped, and
load-bearing**; and **no — a `.base` is a different layer.**

## They sit at different layers

The cleanest way to see it is to line up the OKF vocabulary against Obsidian's:

| OKF ([spec](/sources/google-2026-okf-spec.md)) | Obsidian | What it is |
| --- | --- | --- |
| **bundle** | **vault** | the corpus / unit of distribution — a directory of files |
| **concept** (one `.md`) | **note** | one unit of knowledge, one file |
| frontmatter (YAML) | note properties (YAML frontmatter) | the queryable per-file metadata |
| `index.md` / `log.md` (reserved) | — (UI-provided navigation) | catalog + history |
| — *(no native query layer)* | **`.base`** | a saved view/query over frontmatter |

An OKF **bundle *is* the corpus**: the set of concept files, their path-identity, and the untyped
link graph between them ([spec](/sources/google-2026-okf-spec.md): the bundle is "the unit of
distribution"; concept ID = path minus `.md`). An Obsidian **`.base` holds no notes at all** — it is
*"valid YAML conforming to the schema"* storing only **view configuration** (filters, formulas,
per-property config, named views). Its data *"is backed by your local Markdown files and properties
stored in YAML"*; delete the base and you lose only the view.

So the correct mapping is **bundle ≈ vault**, not bundle ≈ `.base`. A `.base` lives *one layer below*
the bundle: it is closer to a **SQL `VIEW` over the vault's frontmatter** than to the vault itself. A
bundle answers *"what is the corpus and how is it identified and linked?"*; a `.base` answers *"show
me a filtered, computed table/cards/list/map over these notes' properties."* They are complementary,
not competing — you could lay a `.base`-style view over an OKF bundle's frontmatter without either
displacing the other.

### Why the analogy is tempting but wrong
Both are "just YAML + Markdown in a folder," so they look alike. The discriminator is **does it
contain the knowledge, or a lens onto it?** A bundle *contains* concepts (the path-identified files
are the knowledge). A `.base` *contains a query* and points at knowledge that lives elsewhere. Mixing
the layers is the error.

## Did this repo ship the bundle pattern? Yes — twice.

1. **`wiki/` is an OKF bundle.** The repo's root `CLAUDE.md` (§2) states it is *"a self-contained,
   OKF-v0.1-conformant bundle"*: one concept per file, concept ID = path, reserved `index.md`/`log.md`,
   bundle-relative links, broken links tolerated. This is the OKF bundle pattern adopted essentially
   verbatim.
2. **`dist/` kits apply the *self-describing bundle* idea to a code artifact.** A vendored kit carries
   `loop.manifest.json` so the copy "knows what it is" and what its machinery is — the same portability
   instinct OKF applies to knowledge, applied to a shippable loop (the kit family's lineage is in
   `dist/REGISTRY.md`).

This repo ships **nothing like a `.base`** — no separate view/query file. Its "views" are
[regenerated `index.md` catalogs](/concepts/drift.md) and (in the kits) stamped `index-view` notes,
which are *materialized into the bundle as files*, not held as a live query sidecar. That's a
deliberate fit with OKF's "if you can `cat` a file, you can read it" minimalism.

## Where this repo actually diverges from OKF

The divergences are mostly **additions**, not deviations — OKF is permissive (only `type` required;
*"no required tooling"*), so going beyond it is conformant:

| Area | OKF v0.1 | This repo |
| --- | --- | --- |
| **Provenance** | not in the spec | adds `extracted / inferred / ambiguous` — the hybrid's load-bearing rule ([provenance](/concepts/provenance.md)) |
| **Link typing** | links are *untyped* edges | extends: state the relationship in prose next to the link |
| **Conformance** | only `type` required; no tooling | strict gate — `type` + `sources:` + a `# Citations` section enforced by `conformance.sh` |
| **Links** | `/`-absolute **and** relative md allowed; `[[wikilinks]]` not part of OKF | uses `/`-absolute bundle-relative; **forbids** `[[wikilinks]]` (OKF-aligned; the common Obsidian-adopter divergence is *keeping* wikilinks) |
| **Citations** | not required | every compiled page must cite a source |

Net: on the **bundle format** this repo is conformant-and-then-some; its genuine departures are
intentional extensions (provenance, typed edges, a strict completion gate), not drift from the spec.
The one place an Obsidian convention would *break* OKF here is `[[wikilinks]]` — which the kits
explicitly rewrite to relative-markdown on the way in.

## Limits
`provenance: extracted`, but with a capture caveat: Obsidian's help pages 403 this environment's
fetcher, so the [Bases source](/sources/obsidian-2026-bases.md) was built from official text surfaced
via search + the 1.9.0 changelog. The layer-mapping argument does not depend on exact wording; the
verbatim quotes do, and are flagged as such.

## Citations
[1] [Obsidian Bases — the `.base` feature](/sources/obsidian-2026-bases.md) — `.base` is valid YAML
holding only view config; data stays in notes' Markdown + frontmatter; note/file/formula property
kinds; Table/Cards/List/Map views.
[2] [OKF Specification v0.1](/sources/google-2026-okf-spec.md) — bundle = the unit of distribution; one
concept per file; concept ID = path; untyped link graph; only `type` required; no required tooling.
[3] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — the operating model behind `wiki/`'s
adoption of the bundle as a maintained, agent-compiled corpus.
