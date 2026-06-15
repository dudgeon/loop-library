---
type: Loop
title: Ingest → Query → Lint Loop
description: The compile-and-maintain loop of an LLM-maintained knowledge base — ingest sources into compiled pages, answer queries from them, and periodically lint for health — so knowledge compounds instead of being re-derived.
tags: [knowledge-base, ingest, query, lint, retro, human-in-the-loop]
timestamp: 2026-06-14T00:00:00Z
resource: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
loop_family: automation
cadence: event-driven
trigger: a new source arrives, a question is asked, or a scheduled health check is due
exit_condition: none — runs for the life of the knowledge base; each pass leaves it more complete
maturity: stable
status: active
aliases: [LLM wiki loop, compile-and-maintain loop, knowledge-maintenance loop]
summary: The three-operation loop (Ingest, Query, Lint) by which an LLM compiles a persistent wiki from sources and keeps it current, shifting cost from re-derivation to near-free bookkeeping.
provenance: extracted
confidence: 0.9
sources: [/sources/karpathy-2026-llm-wiki.md, /sources/google-2026-okf-spec.md]
related: [/concepts/progressive-disclosure.md, /concepts/provenance.md, /synthesis.md]
---

This is the loop this very repository runs on (see the operating manual `CLAUDE.md` §3, at the
repo root). It is both
**agentic** (an LLM does the reasoning) and an **automation** loop (it runs the recurring
work humans abandon). Karpathy's framing: *knowledge is compiled once and then kept current,
not re-derived on every query.*

# Mechanism

One full turn of the loop has three operations; any one can fire independently.

| Op | Trigger | Steps | Touches |
| --- | --- | --- | --- |
| **Ingest** | a source is approved | read → discuss → mirror → write Source concept → compile loop/concept/comparison pages → update indexes → append log | "a single source might touch 10–15 wiki pages" |
| **Query** | a question | read index → drill into pages → synthesize with citations → file novel answers back as pages | the index + a few pages; sometimes adds one |
| **Lint** | periodic / pre-merge | run conformance + lint scripts → review contradictions, drift, orphans, gaps → fix safe items → log | many pages in one pass |

The defining move is **filing answers back**: a good query result (a comparison, a discovered
connection) becomes a new page, so explorations compound just like ingested sources do.

# When to use
- A body of knowledge accumulates over time and you want it organized, cross-referenced, and
  current rather than scattered (research, competitive analysis, an evolving thesis).
- Moderate scale: ~100 sources / hundreds of pages, where an `index.md` replaces embedding RAG.
- A human is willing to curate sources and ask good questions while the agent does the rest.

# When not to
- One-shot lookups where nothing accumulates — plain RAG or a single read is cheaper.
- Very large corpora (the pattern is cited as collapsing past ~1,000 files) without adding a
  real search tool and/or splitting into sub-bundles.
- Fully unsupervised operation — without human curation and lint, the wiki drifts toward
  compounding hallucination (see [provenance](/concepts/provenance.md)).

# Failure modes

| Failure | Cause | Mitigation |
| --- | --- | --- |
| Compounding hallucination | LLM-only maintenance, no grounding | per-claim `provenance:`, mandatory `# Citations`, human-in-the-loop ingest |
| Stale claims | newer source contradicts an old page | Lint flags page-vs-newer-source; supersede, don't silently overwrite |
| Orphan / missing pages | cross-refs not maintained | `index.md` discipline + `scripts/lint.sh` orphan check |
| Scale collapse | index outgrows one context window | split into sub-bundles; add hybrid BM25/vector search (`qmd`) |
| Source corruption | agent edits the source of truth | mechanical rule: `sources/` is read-only; nothing auto-promoted from `inbox/` |

# Relationships
- **relies on** [progressive disclosure](/concepts/progressive-disclosure.md) — the index-first
  read is what keeps each pass inside the context window.
- **is governed by** [provenance](/concepts/provenance.md) — the discipline that keeps the
  compounding artifact trustworthy.
- **is the subject of** [the synthesis](/synthesis.md) — what makes this loop robust at scale.

# Citations
[1] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — the three operations,
    the three-layer architecture, and "compiled once, kept current."
[2] [OKF Specification v0.1](/sources/google-2026-okf-spec.md) — the reserved `index.md` /
    `log.md` files and the bundle the loop maintains.
