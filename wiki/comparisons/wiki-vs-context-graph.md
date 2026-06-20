---
type: Comparison
title: Codified wiki ↔ live context graph
description: Contrasts a self-built markdown wiki (codified canon, compiled once) with a live-wired context graph (stays connected to sources, cites from the original) — and argues they are complements split by knowledge type, not rivals.
tags: [knowledge-base, provenance, retrieval, okf, context-management]
timestamp: 2026-06-20T00:00:00Z
summary: A wiki holds codified canon compiled once (cheap, owned, but drifts); a live context graph stays wired to sources and cites from the original (grounded, cross-source, but hosted/vendor-pitched). The argued answer is both, split by knowledge type.
provenance: inferred
confidence: 0.6
sources: [/sources/ouimet-2026-wiki-graph-drift.md, /sources/karpathy-2026-llm-wiki.md]
related: [/concepts/drift.md, /loops/automation/ingest-query-lint.md, /concepts/provenance.md, /comparisons/duo-vault-vs-wiki.md]
---

This contrast comes from Ouimet's thread, which is **part critique, part vendor advocacy** (the
author runs GTM at HipAI, the graph product). The comparison below keeps the structural argument
and marks where a claim is the vendor's rather than established. The honest reading: the *wiki
side* and the *drift diagnosis* are well-grounded; the *graph side* is one proposed remedy among
several and is **unvalidated** in this library (`provenance: inferred`, low confidence).

## The two layers

| Axis | Codified wiki (this repo's model) | Live context graph (proposed) |
| --- | --- | --- |
| **Holds** | Decisions, canon, pages you reread for years | Live, multi-source sprawl (Slack/Notion/CRM/repos) |
| **Relation to source** | Compiled once, then **detached** — a frozen copy | Stays **wired** to the source; re-pulls; no frozen copy |
| **Answers cited from** | The page (a summary the model wrote) | The **live source**, so answers can be re-checked |
| **Cross-source reasoning** | grep-and-read across pages; "thrashes" on hard joins | Reasons across everything at once (GraphRAG-style) |
| **Drift** | [Drifts](/concepts/drift.md) — "two copies will drift" | No second copy to drift (the core claim) |
| **Ongoing ingestion cost** | Re-export/re-pull every source by hand, forever | Connect each source once; sync is the tool's job |
| **Ownership** | Fully yours; free; can't be repriced or taken | Hosted service today (the author's stated reservation) |
| **Cost profile** | Cheap to stand up; human time is the cost | "Cheaper especially where the work is hard"; ~same on simple lookups |

## Where each wins

- **Wiki wins** for *codified context*: your reasoning, your canon, the stable pages — the things
  worth compiling because you'll reread them and they don't change under you. It is owned,
  portable (OKF), and close to free. Its weakness is [drift](/concepts/drift.md) and the recurring
  manual cost of keeping live sources current by hand.
- **Graph wins** for *live, multi-source context*: the sprawl that changes constantly and is too
  much to hand-maintain. Its claimed strengths are grounding (cite from the live source) and
  removing the export-treadmill. Its costs are being a hosted black box (unless self-hostable) and
  imperfect structure-inference on messy data — both conceded by the author.

## The argued resolution: both, split by knowledge type

The thread's thesis is **not** wiki-vs-graph but a **division of labor**: codified canon in the
wiki, live sprawl in a graph that *syncs for you and cites where it came from — including citing
the wiki*. The framing offered is "a context graph as a constant gardener" for the wiki, with
markdown-native graph output that can seed new wiki pages. The unifying principle is the same one
the [drift](/concepts/drift.md) concept turns on: **two copies of anything will drift**, so put
knowledge that must stay live where it isn't a second copy, and reserve the wiki for knowledge
that is genuinely yours to freeze.

## How this lands for *this* repo

This library already takes the wiki side and already names drift's antidote: mandatory
[provenance](/concepts/provenance.md) and a lint pass. The thread's contribution is the reminder
that lint is **page-to-page, not page-to-source** (see [the loop's failure modes](/loops/automation/ingest-query-lint.md)),
so citations are necessary but not sufficient — something has to actually re-check the page
against the source. Whether that "something" is a graph, a re-grounding lint pass, or a
human-in-the-loop ritual is an **open design question**, not a settled one. A context-graph layer
is therefore a *candidate idea to explore in `wiki/`*, **not** a shipping instruction for `dist/`
(per `CLAUDE.md` §8). Compare the OKF-native graph framing in
[Duo vault ↔ the wiki](/comparisons/duo-vault-vs-wiki.md).

# Citations
[1] [Ouimet — "An LLM wiki can't tell you when it's wrong"](/sources/ouimet-2026-wiki-graph-drift.md)
    — the wiki/graph split, the grounding claim, the GraphRAG reference, and "both, split by
    knowledge type."
[2] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — the wiki operating model the
    thread builds on, and the lint-can't-adjudicate caveat both share.
