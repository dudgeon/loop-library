---
type: Concept
title: Drift (two copies of anything will drift)
description: The silent failure mode of a compiled knowledge base — a page diverges from the source it was built from, because lint only checks pages against each other and the model answers from its own frozen summary rather than the original.
tags: [knowledge-base, provenance, retrieval, lint, context-management]
timestamp: 2026-06-20T00:00:00Z
summary: Drift is when a compiled page silently diverges from its source; because lint cross-checks pages (not sources) and the model quotes its own summary, the page gets "confidently wrong, quoting a copy of itself" until a human catches it.
provenance: extracted
confidence: 0.8
sources: [/sources/ouimet-2026-wiki-graph-drift.md, /sources/ouimet-2026-eqctrl-karpathy-plus.md, /sources/karpathy-2026-llm-wiki.md]
related: [/concepts/provenance.md, /concepts/knowledge-runtime-boundary.md, /loops/automation/ingest-query-lint.md, /comparisons/wiki-vs-context-graph.md, /synthesis.md]
---

**Drift** is the failure where a compiled page quietly stops matching the source it was built
from. It is the load-bearing risk of the [ingest → query → lint loop](/loops/automation/ingest-query-lint.md)
this repo runs on, and the reason [provenance](/concepts/provenance.md) exists. Ouimet's thread
names the principle bluntly: **"two copies of anything will drift."** Once a source is compiled
into a page, you have two copies — the original and the summary — and they diverge over time.

## Why it is silent (the mechanism)

| Step | What happens | Why nothing catches it |
| --- | --- | --- |
| Compile | The model reads a source and writes a summary page. | A second copy now exists. |
| Substitute | Later queries are answered **from the page**, not the source. | "The page is what gets quoted, not the source." |
| Diverge | The page is edited, the source updates, or the summary was lossy. | The page still parses, still links — it just no longer matches. |
| Compound | Other pages cite the drifted page; the error propagates. | The wiki has "no live line back to where the claim came from." |

The defining property is that **drift does not throw an error**. Broken links are visibly
broken; drift is invisible — the page "gets a little more confidently wrong, quoting a copy of
itself, for weeks, until you catch it three pages deep."

## Why lint alone can't fix it

The [lint](/loops/automation/ingest-query-lint.md) pass "only checks my pages against each
other." It can flag that page A disagrees with page B, but **not which one is true**, because
the cross-check is page-to-page, never page-to-source. This is not a tooling gap to be patched —
it is the same limit Karpathy states in the founding source: *lint can't resolve contradictions
on its own; a human still decides what's true.* Lint keeps the wiki **tidy** (internally
consistent); keeping it **correct** (faithful to sources) is a different job.

## The snapshot framing (verify at consumption)

Ouimet's fuller [Karpathy+ writeup](/sources/ouimet-2026-eqctrl-karpathy-plus.md) restates the
same principle as the **snapshot problem** and adds the operative rule: *"copies drift; links
don't."* The moment a fact leaves the canonical store it is a **snapshot, not a live reference** —
this covers not just wiki pages but the agent's auto-memory, pasted UI instructions, and
forwarded session prompts. Two rules follow:

- **Verify at consumption, not at creation.** A copy is correct only when re-checked at the moment
  it is used, never on the strength of having been right when written.
- **Forwarded instructions are claims, not directions.** A session that opens with a terse "do
  what the plan says" should re-derive scope from the current wiki before acting — the plan is
  itself a snapshot, and *plans decay faster than the state they depend on*.

The structural defense is to **not keep a second copy**: remove a duplicated fact and point to the
canonical page (a hardcoded count drifts; a link cannot) — which is precisely what the
[knowledge ↔ runtime boundary](/concepts/knowledge-runtime-boundary.md) enforces at write time, and
why "DRIFT — one fact in three files" is one of Ouimet's three named causes of death for a
knowledge system.

## How it shows up across loop families

- **Automation / knowledge loops:** the case above — compiled pages outrunning their sources.
- **Agentic loops:** an agent that summarizes a tool result into working memory and then reasons
  from the summary for the rest of the task exhibits the same two-copies divergence within a
  single run.
- **Any cache:** drift is the general hazard of *any* derived copy (cache, index, embedding,
  summary). The principle is not specific to wikis.

## Mitigations (and their honest limits)

| Mitigation | What it buys | Limit |
| --- | --- | --- |
| [Provenance](/concepts/provenance.md) discipline — `sources:` + `# Citations` on every page | A traceable path back to the source for human re-check | Still requires a human (or a pass) to *follow* the line and compare |
| Lint flags page-vs-**newer-source** contradictions; `supersede` instead of overwrite | Catches drift when a *new* source arrives | Doesn't catch a page drifting from an *unchanged* source |
| Keep a source pointer + verbatim excerpt on the page (this repo's `# Notable excerpts`) | Shrinks the gap between copy and original | The excerpt is itself a (smaller) frozen copy |
| Re-ground answers against the live source — Ouimet's proposed **[context graph](/comparisons/wiki-vs-context-graph.md)** | Every answer cited from the live source, not a summary | Vendor-pitched and unvalidated here; trades self-hosting for a hosted service |

No mitigation removes drift; they shorten the time-to-detection and the distance back to truth.
The deepest framing is structural: drift is the cost of compiling, and the only way to *not*
have a second copy that drifts is to not keep one — which is exactly the bet a live-wired graph
makes (see [the comparison](/comparisons/wiki-vs-context-graph.md)).

## Relationships
- **is the risk mitigated by** [provenance](/concepts/provenance.md) — citations are the line
  back to the source that makes drift *checkable*, even though they don't prevent it.
- **is a named failure mode of** [the ingest → query → lint loop](/loops/automation/ingest-query-lint.md).
- **motivates** [the wiki ↔ context-graph comparison](/comparisons/wiki-vs-context-graph.md) —
  drift is the problem the graph layer is proposed to solve.
- **sharpens** [the synthesis](/synthesis.md), condition 2 ("ground every claim").

# Citations
[1] [Ouimet — "An LLM wiki can't tell you when it's wrong"](/sources/ouimet-2026-wiki-graph-drift.md)
    — the drift failure mode, frozen-summary substitution, and "two copies of anything will drift."
[2] [Ouimet — eqctrl.io "Karpathy+" system](/sources/ouimet-2026-eqctrl-karpathy-plus.md) — the
    snapshot problem ("copies drift; links don't"), verify-at-consumption, forwarded-instructions-
    as-claims, and "DRIFT" as one of the three causes of death.
[3] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — lint cannot resolve
    contradictions on its own; a human still decides what is true.
