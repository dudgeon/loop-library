---
type: Concept
title: Progressive Disclosure
description: The navigation discipline of surveying a lightweight index before opening documents, so an agent can work a large corpus while keeping the working set inside its context window.
tags: [context-management, knowledge-base, retrieval, okf]
timestamp: 2026-06-14T00:00:00Z
summary: Read the index first, then drill into only the pages you need — index-first navigation that replaces embedding RAG at moderate scale and keeps each step context-budget-aware.
provenance: extracted
confidence: 0.9
sources: [/sources/google-2026-okf-spec.md, /sources/karpathy-2026-llm-wiki.md, /sources/google-2026-okf-blog.md, /sources/ouimet-2026-eqctrl-karpathy-plus.md]
related: [/loops/automation/ingest-query-lint.md, /concepts/provenance.md, /concepts/knowledge-runtime-boundary.md]
---

**Progressive disclosure** is the practice of letting a reader (human or agent) see *what is
available* — titles and one-line descriptions in an `index.md` — before spending attention on
any full document. It is the navigation primitive both parent formats converge on, and the
reason an index can stand in for embedding-based RAG at moderate scale.

# Why it matters for loops
The [Ingest → Query → Lint loop](/loops/automation/ingest-query-lint.md) reads the index
*first* on every query. That single rule is what keeps each pass inside the context window:
the agent surveys, then pulls in only the relevant pages, instead of ingesting the whole
corpus. It is a **context-budget-aware** traversal model — the cheap structural read gates the
expensive full read.

# How it shows up
- **OKF:** `index.md` is a reserved file at every directory level; the bundle-root `index.md`
  additionally declares `okf_version`. An agent "may also synthesize an index on the fly."
- **Karpathy:** "the LLM reads the index first to find relevant pages, then drills into them.
  This works surprisingly well at moderate scale (~100 sources)… and avoids the need for
  embedding-based RAG infrastructure."
- **In this repo:** every directory has an `index.md`; `wiki/index.md` is the root catalog.
- **Ouimet's [Karpathy+](/sources/ouimet-2026-eqctrl-karpathy-plus.md):** disclosure is treated as
  a **gate**, with concrete budgets — each session loads the schema (~50 lines) + the index (<50
  lines) + only **2–4 task-relevant pages**, *never* the whole pile, "because a system that
  requires loading everything … gets skipped in long sessions." The motivation is behavioral, not
  just budgetary: an over-heavy system isn't read at all (his **LOAD** cause of death).

# A plan is not enough context
Ouimet adds a caveat the founding sources don't: **load the pages a plan references, not just the
plan.** "Plans decay faster than the project state they depend on," so a plan consumed on its own
is a stale [snapshot](/concepts/drift.md). Progressive disclosure means drilling from the index to
the *referenced pages*, not stopping at the first summary that looks sufficient.

# Limits
Index-first navigation degrades when the index itself outgrows one context window (cited as
~1,000 files). The escalation path is to split into sub-bundles and add a real search tool —
not to abandon the discipline.

# Relationships
- **enables** [the Ingest → Query → Lint loop](/loops/automation/ingest-query-lint.md) — it is
  the read step that makes the loop affordable.
- **complements** [provenance](/concepts/provenance.md) — disclosure governs *what you read*;
  provenance governs *whether to trust it*.

# Citations
[1] [OKF Specification v0.1](/sources/google-2026-okf-spec.md) — reserved `index.md`,
    progressive disclosure, synthesize-on-the-fly.
[2] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — read the index first;
    works at ~100 sources without embedding RAG.
[3] [Google Cloud — Introducing OKF](/sources/google-2026-okf-blog.md) — index.md lets an
    agent navigate top-down and pull only what it needs.
[4] [Ouimet — eqctrl.io "Karpathy+" system](/sources/ouimet-2026-eqctrl-karpathy-plus.md) —
    disclosure as a gate (schema + index + 2–4 pages), the LOAD cause of death, and "load the
    pages a plan references; plans decay faster than the state they depend on."
