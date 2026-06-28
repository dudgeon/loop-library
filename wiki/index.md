---
okf_version: "0.1"
---

# Loop Library — index

The compiled OKF bundle. Read this first, then drill into pages (see
[progressive disclosure](/concepts/progressive-disclosure.md)). Links are bundle-relative,
resolved from this `wiki/` directory.

## Synthesis
* [What Makes a Knowledge Loop Robust](/synthesis.md) — the library's evolving thesis (draft).

## Loops
* [Loops index](/loops/index.md) — all loops by family.
* [Goal-Directed Task Loop](/loops/agentic/goal-directed-task-loop.md) — hypothesis (unvalidated, not shipped): the most vanilla loop.
* [Ingest → Query → Lint Loop](/loops/automation/ingest-query-lint.md) — the compile-and-maintain loop this repo runs on.
* [Session-Harvest Loop](/loops/automation/session-harvest.md) — design (unvalidated, not shipped): the retro loop turned inward onto project intent.
* [Agent operations: a human-gated fleet](/loops/agentic/agent-operations.md) — overview: six agent archetypes under four principles; irreversible action stays behind a human yes.

## Concepts
* [Concepts index](/concepts/index.md) — cross-cutting ideas loops rely on.
* [Progressive disclosure](/concepts/progressive-disclosure.md) — index-first, context-budget-aware navigation.
* [Provenance](/concepts/provenance.md) — extracted vs inferred vs ambiguous; the anti-hallucination discipline.
* [Drift (two copies will drift)](/concepts/drift.md) — the silent failure where a compiled page diverges from its source; lint can't catch it alone.
* [Knowledge ↔ runtime boundary](/concepts/knowledge-runtime-boundary.md) — one canonical home per fact; the structural defense against drift.
* [Defense in depth](/concepts/defense-in-depth.md) — stacked cheap nets + a completion gate; enforce mechanically or loudly, never politely.
* [Loopkit on Duo](/concepts/loopkit-on-duo.md) — design (unvalidated, not shipped): progressive enhancement by an optional host.
* [brainkit](/concepts/brainkit.md) — candidate (built in `dist/`, not yet validated): the WAH application layer rebuilt as policy on loopkit.
* [Kit sync as curation, not overwrite](/concepts/kit-sync.md) — real-use finding: a vendored kit refreshes its machinery by agent curation (pull only what you approve, merge local tweaks), not a deterministic overwrite script.

## Comparisons
* [Comparisons index](/comparisons/index.md) — contrasts between loops/patterns.
* [loopkit ↔ the root repo](/comparisons/loopkit-vs-root.md) — shipped kit vs this repo; which v0 decisions the root adopts vs rejects.
* [Duo Note Vault ↔ the wiki/loopkit construct](/comparisons/duo-vault-vs-wiki.md) — same OKF substrate, three operating models; the vault as a candidate runtime.
* [WAH ↔ Duo-vault entity structure](/comparisons/wah-vs-duo-vault.md) — hand-rolled vs native; the case for building the next harness on the graph.
* [Codified wiki ↔ live context graph](/comparisons/wiki-vs-context-graph.md) — compiled-and-detached vs live-wired-to-source; the argued answer is both, split by knowledge type.
* [OKF bundle ↔ Obsidian Bases (.base)](/comparisons/okf-bundle-vs-obsidian-base.md) — the corpus/container layer (bundle ≈ vault) vs the view-over-frontmatter layer (`.base` ≈ a SQL VIEW); where this repo's OKF usage diverges.

## Sources
* [Sources index](/sources/index.md) — digests of ingested sources.
* [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md)
* [OKF Specification v0.1](/sources/google-2026-okf-spec.md)
* [Google Cloud — Introducing OKF](/sources/google-2026-okf-blog.md)
* [work-agent-harness (WAH)](/sources/work-agent-harness.md) — the hand-rolled entity-graph KM system brainkit ports from.
* [brainkit spec](/sources/brainkit-spec.md) — the brainkit design-of-record (`_meta/SPEC-brainkit.md`).
* [Ouimet — "An LLM wiki can't tell you when it's wrong"](/sources/ouimet-2026-wiki-graph-drift.md) — wiki drift and the live "context graph" complement (part vendor advocacy).
* [Ouimet — eqctrl.io "Karpathy+" system](/sources/ouimet-2026-eqctrl-karpathy-plus.md) — a full file-based persistent-memory architecture (boundary rule, defense in depth, snapshot problem, human-gated fleet).
* [Obsidian Bases — the `.base` feature](/sources/obsidian-2026-bases.md) — the `.base` YAML view/query over note frontmatter; the data stays in the notes.
