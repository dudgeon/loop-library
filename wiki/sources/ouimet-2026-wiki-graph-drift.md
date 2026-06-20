---
type: Source
title: 'Ouimet — "An LLM wiki can''t tell you when it''s wrong"'
description: An X thread arguing that a Karpathy-style markdown wiki silently drifts because lint only checks pages against each other and frozen summaries get quoted in place of their sources — and proposing a live-wired "context graph" alongside the wiki as the fix.
tags: [knowledge-base, provenance, retrieval, ingest, lint]
authors: [Ethan Ouimet]
published: '2026-06'
timestamp: 2026-06-20T00:00:00Z
resource: https://x.com/entropy_eq/status/2067983693512319049
raw_mirror: ../sources/ouimet-2026-wiki-graph-drift.md
---

# Ouimet — "An LLM wiki can't tell you when it's wrong"

A practitioner X (Twitter) thread by **Ethan Ouimet** (@entropy_eq), who runs a
Karpathy-style markdown wiki (the same operating model as this repo) and reports that the
hard part was not *organizing* knowledge but **noticing when a page had quietly drifted**.
His core argument: the **lint pass only checks pages against each other** — it can say page A
disagrees with page B, but not which is true, because the wiki has **no live line back to the
source**. Worse, the model writes the summaries and then answers from them, so a compressed
page becomes the thing that gets quoted instead of the original; when it drifts "nothing
breaks," it just gets "a little more confidently wrong, quoting a copy of itself," until
caught weeks later. His proposed remedy is to keep the wiki for codified canon and run a
**live-wired "context graph" alongside it** that stays connected to sources, cites every
answer from the live source, reasons across sources, and removes the recurring
export-and-re-pull cost for platforms like Slack/Notion/CRM. **Important context:** the
author discloses he runs **GTM at HipAI** (@gethipai), the graph product he promotes; the
thread is part genuine critique, part vendor advocacy, and several pro-graph claims are
self-interested and unvalidated here. The intellectual contribution worth keeping is the
**drift failure mode** and the **"two copies of anything will drift"** principle.

# Key points
- **The wiki's value is real and cheap.** A self-built markdown wiki is "close to free," yours,
  and can't be repriced or taken away; `claude-obsidian` (cited as the most mature open version)
  sets up in an afternoon, and the model keeps the index/links/log so most feared maintenance
  never materializes.
- **The drift failure mode.** Lint "only checks my pages against each other." It flags A-vs-B
  disagreement but cannot adjudicate truth, because the wiki has no live link back to either
  claim's source. This restates Karpathy's own caveat that lint can't resolve contradictions —
  "you still need a human deciding what's true."
- **Frozen-summary substitution.** "The real source got compressed into a page months ago, and
  from then on the page is what gets quoted, not the source." The model answers from its own
  prior summary; drift is silent ("nothing breaks") and compounds into confident wrongness.
- **The graph's claimed remedy.** A graph "doesn't keep that frozen copy" — it stays wired to
  the source, re-pulls easily, and cites every answer from the live source so it can be checked;
  it also reasons across sources (the cross-source questions "grep never handled"). Invokes
  Microsoft's **GraphRAG**: check the answer against the original, not against another page you
  wrote.
- **The real hidden cost is upstream of ingestion.** Reading a handed-over doc was never the hard
  part; getting and *keeping* clean exports out of Slack/Notion/CRM (auth, paging, format churn,
  rate limits) is "a small project every time… now do that every week, forever." Connect once
  to a graph and that recurring job disappears.
- **Honest tradeoffs (author's own hedges).** A graph is "cheaper especially where the work is
  hard" (cross-source), about the same on simple lookups; structure-inference over messy data
  "won't be flawless on first build"; dedup/relationships are still being sharpened.
- **Ownership is the non-negotiable.** "Not-your-keys-not-your-tokens": he wants to see inside
  the tool, export the whole corpus, and run it on his own model/key — which is why he runs a
  custom system rather than a black box.
- **The conclusion is "both," split by knowledge type.** Codified canon (decisions, pages reread
  for years) lives in the **wiki**; live multi-source sprawl lives in a **graph** that syncs and
  cites — including citing the wiki. "I didn't replace my wiki, I gave it a context graph as a
  constant gardener."

# Notable excerpts
- "It only checks my pages against each other. It'll tell me page A disagrees with page B. It
  can't tell me which one is true, because the wiki has no live line back to where either claim
  came from."
- "The real source got compressed into a page months ago, and from then on the page is what gets
  quoted, not the source."
- "When a page drifts, nothing breaks. It just gets a little more confidently wrong, quoting a
  copy of itself, for weeks, until you catch it three pages deep."
- "Microsoft's GraphRAG work makes the same point: you check the answer against the original, not
  against another page you wrote."
- "The trick answer is both, split by what kind of knowledge it is."
- "🗣️ TWO COPIES OF ANYTHING WILL DRIFT"
- "I didn't replace my wiki, I gave it a context graph as a constant gardener and let it carry
  the load."

# Caveats (read before citing)
- **Vendor advocacy.** The author sells the proposed remedy (GTM at HipAI). Treat product
  superiority claims (cost, dedup, "grounded from day one") as marketing, not established fact.
- The drift *diagnosis* is well-grounded (it matches this repo's own provenance discipline and
  Karpathy's lint caveat); the graph *prescription* is one option among several (e.g. storing a
  source pointer + excerpt per page, or re-grounding lint against sources) and is **unvalidated**
  in this library.

# Compiled into
- [Drift (two copies of anything will drift)](/concepts/drift.md)
- [Codified wiki ↔ live context graph](/comparisons/wiki-vs-context-graph.md)
- [Ingest → Query → Lint loop](/loops/automation/ingest-query-lint.md) — new failure-mode row
- [What makes a knowledge loop robust](/synthesis.md) — "ground every claim" reinforced
