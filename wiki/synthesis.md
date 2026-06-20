---
type: Synthesis
title: What Makes a Knowledge Loop Robust
description: The evolving thesis of the Loop Library — distilling, across sources, what keeps an LLM-maintained, compounding knowledge base trustworthy and durable rather than collapsing into hallucination or scale.
tags: [knowledge-base, provenance, context-management, retro]
timestamp: 2026-06-14T00:00:00Z
summary: A living thesis page; v0 distills three robustness conditions — compile don't re-derive, ground every claim, and disclose progressively — from the founding sources.
provenance: inferred
confidence: 0.7
sources: [/sources/karpathy-2026-llm-wiki.md, /sources/google-2026-okf-spec.md, /sources/google-2026-okf-blog.md, /sources/ouimet-2026-wiki-graph-drift.md]
related: [/loops/automation/ingest-query-lint.md, /concepts/progressive-disclosure.md, /concepts/provenance.md, /concepts/drift.md]
status: draft
---

> **This is a living page** (`provenance: inferred`, `status: draft`). It is the synthesis the
> library compiles toward and will be revised as sources accrue. v0 is built from the three
> founding sources only.

The Loop Library's first question is reflexive: *what makes a knowledge loop itself robust?*
From the founding sources, three conditions stand out.

## 1. Compile, don't re-derive
RAG rediscovers knowledge from scratch on every query; the
[Ingest → Query → Lint loop](/loops/automation/ingest-query-lint.md) compiles it once and
keeps it current. Robustness condition: **knowledge must accumulate as a persistent artifact**,
with cross-references and synthesis already present before a question is asked.

## 2. Ground every claim
A compounding artifact compounds its errors too. [Provenance](/concepts/provenance.md) — the
extracted/inferred/ambiguous declaration, mandatory citations, human-in-the-loop ingest — is
the discipline that keeps trust from decaying as the corpus grows. Robustness condition:
**the loop must be auditable**, or delegation to an agent is unsafe. The sharpest statement of
the threat is [drift](/concepts/drift.md): "two copies of anything will drift," and a lint pass
that checks pages *against each other* cannot catch a page diverging from its *source*. So
citations are **necessary but not sufficient** — grounding is real only if something actually
re-checks the page against the source, whether a human, a re-grounding pass, or a live
[context-graph layer](/comparisons/wiki-vs-context-graph.md).

## 3. Disclose progressively
[Progressive disclosure](/concepts/progressive-disclosure.md) — index first, drill second —
is what keeps each pass inside the context window and lets an index stand in for embedding RAG
at moderate scale. Robustness condition: **navigation must be context-budget-aware**, with a
known escalation path (sub-bundles + search) when the index outgrows one window.

## The hybrid in one line
**OKF is the contract** (a portable bundle any consumer can read), **Karpathy is the operating
model** (the agent compiles and maintains it), and **provenance is the addition both lack** (so
the compounding stays trustworthy).

## Why this library exists (two engines)
The repo runs two loops that feed each other:

1. **A research loop (`wiki/`, Purpose 2)** — this bundle, maintained by
   [ingest → query → lint](/loops/automation/ingest-query-lint.md), accumulates the
   state of the art in loop construction and recursive improvement.
2. **Shipped loop kits (`dist/`, Purpose 1)** — vendorable, self-syncing prototypes that let
   any task "begin by defining a loop, then running it." **Nothing is shipped yet:** shipping
   to `dist/` is deliberate and reserved for validated, very-high-confidence patterns (see
   `dist/REGISTRY.md`). The leading candidate is the
   [goal-directed task loop](/loops/agentic/goal-directed-task-loop.md), currently an
   *unvalidated hypothesis* under research, not product.

The research loop improves the kits; shipped kits, once vendored, throw off usage that becomes
new sources for the research loop. The robustness conditions above are the criteria a candidate
must meet before it ships. The recursion is the point: **a loop library whose own operation,
and whose (eventual) products, are loops it studies and improves — with a deliberate gate
between studying and shipping.**

# Citations
[1] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md)
[2] [OKF Specification v0.1](/sources/google-2026-okf-spec.md)
[3] [Google Cloud — Introducing OKF](/sources/google-2026-okf-blog.md)
[4] [Ouimet — "An LLM wiki can't tell you when it's wrong"](/sources/ouimet-2026-wiki-graph-drift.md)
