---
type: Concept
title: Provenance
description: The discipline of recording, per page and per claim, what the knowledge base actually knows (extracted from a cited source) versus what it guessed (inferred) — the safeguard against compounding hallucination in an agent-maintained wiki.
tags: [provenance, knowledge-base, verification, okf]
timestamp: 2026-06-14T00:00:00Z
summary: Distinguish extracted (cited) from inferred (synthesized) from ambiguous (sources disagree) at write time, so a compounding, agent-maintained corpus stays auditable as it grows.
provenance: inferred
confidence: 0.8
sources: [/sources/karpathy-2026-llm-wiki.md, /sources/google-2026-okf-spec.md]
related: [/loops/automation/ingest-query-lint.md, /concepts/progressive-disclosure.md, /synthesis.md]
---

**Provenance** is knowing, for any statement in the wiki, *where it came from* — and being
honest about the difference between what a source said and what the agent inferred. This is
the **load-bearing addition this library makes** on top of its two parents: neither Karpathy's
pattern nor OKF v0.1 distinguishes extracted knowledge from synthesized knowledge, and that
gap is the documented cause of *compounding hallucination* in LLM-maintained wikis.

> This page is itself marked `provenance: inferred` — the three-way taxonomy below is this
> library's synthesis, not a verbatim rule from either source. The grounding (the *need* for
> it, and the raw materials — citations, `log.md`, `timestamp`, git history) is extracted.

# The three-way declaration
Every compiled page sets `provenance:` to its dominant basis:

| value | meaning | obligation |
| --- | --- | --- |
| `extracted` | directly supported by a cited source | cite it in `# Citations` |
| `inferred` | the agent's synthesis across sources | say so in the body; don't present as fact |
| `ambiguous` | sources disagree | the body must explain the disagreement |

Plus two mechanical supports on every Loop/Concept/Comparison page: a non-empty `sources:`
list and a `# Citations` section (both enforced by `scripts/conformance.sh`).

# Why it matters for loops
The [Ingest → Query → Lint loop](/loops/automation/ingest-query-lint.md) makes knowledge
*compound* — every pass builds on prior pages. Without provenance, errors compound just as
fast as insight: a guess written once is read as fact forever after. Provenance keeps the
compounding artifact **auditable**, which is what lets a human safely delegate the bookkeeping.

# Inherited supports (from the parents)
- **OKF:** `# Citations` (numbered), the `resource:` URI, `timestamp`, `log.md` history, and
  git attribution — coarse provenance that this library makes per-page mandatory.
- **Karpathy:** "answers with citations," and Lint's job of flagging "stale claims that newer
  sources have superseded."

# Relationships
- **governs** [the Ingest → Query → Lint loop](/loops/automation/ingest-query-lint.md) — it is
  the trust discipline applied at every Ingest and Query.
- **is checked by** the Lint operation — provenance drift (pages going mostly `inferred`) is a
  lint finding.

# Citations
[1] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — answers with citations;
    Lint flags stale/superseded claims.
[2] [OKF Specification v0.1](/sources/google-2026-okf-spec.md) — `# Citations`, `resource`,
    `timestamp`, `log.md`, git-native provenance.
