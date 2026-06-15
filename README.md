# Loop Library

A research knowledge base **about loops** — how to make them and how to improve them — built
as a **hybrid of two ideas**:

- **[Karpathy's "LLM Wiki"](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)**
  — the *operating model*: an LLM compiles and continuously maintains an interlinked markdown
  wiki instead of re-deriving answers from raw chunks every query.
- **[Google's Open Knowledge Format (OKF v0.1)](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md)**
  — the *on-disk contract*: a portable bundle of markdown files with YAML frontmatter, one
  concept per file, identified by path, linked into a graph.

> **OKF is the contract; Karpathy is the operating model; provenance is the addition both lack.**

**Scope:** agentic (LLM reason-act-observe) and automation/workflow loops.

## Two engines

The repo runs two loops that feed each other:

1. **Research loop — `wiki/` (Purpose 2).** The knowledge base above, maintained by
   `ingest → query → lint`, accumulating the state of the art in loop construction and
   recursive improvement.
2. **Shipped loop kits — `dist/` (Purpose 1).** Vendorable, self-syncing prototypes that let
   any home/work task *begin by defining a loop, then running it*. **Shipping here is deliberate
   — treated like shipping software — and reserved for validated, very-high-confidence patterns.
   Nothing is shipped yet.** Candidates are developed in the research loop first. See the bar in
   [`dist/REGISTRY.md`](dist/REGISTRY.md) and `CLAUDE.md` §8.

The research loop improves the kits; vendored kits throw off usage that becomes new research
sources. The library studies loops in order to ship better loops — and its own operation is
one of them.

**Two ceremonies:** the **root/meta loop is alpha** — malleable; its primitives (goal, work
product, hypotheses, tasks/sub-goals) live in [`loop/`](loop/) and the repo holds them on
*itself*. **`dist/` is shipped product** — deliberate and gated. Promote from alpha to shipped
only at very-high confidence.

## Layout (three layers)

| Path | Layer | Rule |
| --- | --- | --- |
| [`loop/`](loop/) | the **root loop's primitives** — GOAL · HYPOTHESES · TASKS | alpha — malleable |
| [`sources/`](sources/) | immutable raw mirrors | read-only — the source of truth |
| [`inbox/`](inbox/) | staging | nothing auto-promoted; human approves ingest |
| [`wiki/`](wiki/) | the OKF bundle (compiled) — **research loop / Purpose 2** | agent-owned; every page cites a source |
| [`dist/`](dist/) | shipped loop kits — **Purpose 1** | deliberate, high-confidence only; nothing shipped yet |
| [`_meta/`](_meta/) | schema + taxonomy | the rules, written down |
| [`scripts/`](scripts/) | lint + conformance | the retro loop, operationalized |
| [`CLAUDE.md`](CLAUDE.md) | control | the agent's operating manual |
| [`.claude/skills/`](.claude/skills/) | operations | `ingest` · `query` · `lint` |

The OKF bundle is **`wiki/`** — point any OKF consumer there. Start at
[`wiki/index.md`](wiki/index.md).

## How to use it

1. **Add a source** to `inbox/` (or `sources/` if you've named it), then run **`/ingest`** —
   the agent mirrors it, writes a Source digest, and compiles it into loop/concept pages.
2. **Ask questions** with **`/query`** — the agent reads the index, answers with citations,
   and files genuinely new findings back as pages.
3. **Keep it healthy** with **`/lint`** — runs `scripts/conformance.sh` (strict) and
   `scripts/lint.sh` (advisory), then reviews contradictions, drift, and gaps.

Conformance is strict: every compiled page has a non-empty `type`, cites a source, and carries
a `# Citations` section. Run `bash scripts/conformance.sh` to check.

## Status

- **Research loop (`wiki/`)** — seeded from the founding sources; conformance + lint green.
- **Loop kits (`dist/`)** — nothing shipped. A `vanilla-loop` scaffold was withdrawn as premature;
  it's now an open research question. Shipping is gated (see `dist/REGISTRY.md`).
- The mission is set (two engines that feed each other); see [`wiki/synthesis.md`](wiki/synthesis.md).
