---
type: Comparison
title: loopkit (the shipped kit) ↔ the root repo
summary: How the shipped loopkit kit maps onto this research repo, and which v0 design decisions the root adopts versus deliberately rejects — the kit is the distilled floor, the root is the leading-edge reference implementation.
tags: [okf, knowledge-base, ingest, query, lint, provenance]
timestamp: 2026-06-15T00:00:00Z
provenance: inferred
confidence: 0.7
sources: [/sources/karpathy-2026-llm-wiki.md, /sources/google-2026-okf-spec.md]
related: [/loops/automation/ingest-query-lint.md]
---

The shipped kit (`dist/loopkit`) and this repo are **the same loop at two maturity levels.** loopkit
is the **distilled floor** we ship for any project to fork; the root is the **leading-edge reference
implementation** that runs ahead with research-grade machinery (OKF, provenance, conformance, the
`dist/` §8 gate). "Compliance" means keeping the correspondence legible and the vocabulary aligned —
**not** flattening the root down to v0. New capability is prototyped in the root and distilled *down*
into a future loopkit only when it proves out.

## Correspondence

| loopkit (the floor) | root repo (the reference) | note |
| --- | --- | --- |
| knowledge base (`knowledge/`) | `wiki/` — OKF catalog of loop *types* | root is richer (OKF bundle) |
| golden, locked (`knowledge/golden/`) | `sources/` (immutable) + `_meta/` (schema) + `CLAUDE.md` | root's golden layer, protected by path |
| `PROJECT.md` (source of truth) | the `loop/` folder (GOAL · HYPOTHESES · TASKS) | split into richer primitives |
| `work/` deliverables | the `wiki/` corpus + `dist/` kits | self-referential work product |
| `ingest` / `query` / **`distill`** | `ingest` / `query` / **`lint`** | same ops; `distill` = `lint` (see below) |
| "pin this" → golden (a rule) | ownership rules (`sources` read-only, `_meta` co-evolved, `dist` gated) | root is richer |
| minimal note contract | full OKF frontmatter + `# Citations` | root is a superset |
| — | session-harvest, conformance, provenance, the §8 gate | root runs **ahead** |

## Which v0 decisions the root adopts vs. rejects

The root **adopts the *honesty* lessons** from building v0 and **rejects the *lightness* concessions**
(those were made for a vendored kit's end-user adoption; the root optimizes for rigor instead).
Recording the rejections matters as much as the adoptions — it keeps kit and root from drifting into
each other by accident.

| v0 decision | root | why |
| --- | --- | --- |
| Golden protection is convention + git review, not a hard mechanical lock | **adopt (framing)** | the root's `sources/`/`_meta/` are protected by rule + review too; say so plainly. Reject the hash-manifest mechanism as overkill. |
| Generated *view* only where the source is **structured**; prose deliverables are living docs | **adopt (rule)** | applies wherever we add generated outputs; prose pages stay living docs. |
| State the runtime contract (bash + python3) | **adopt (minor)** | the root's scripts assume the same. |
| `distill` as the user word for `lint` | **partial** | root keeps **`lint`** (it also runs OKF conformance — more than distilling); document `distill` = `lint`. |
| No generated loop map (loopkit ships none) | **adopt** | the root's generated `LOOPS.md` registry was collapsed to a hand list (see `loop/TASKS.md` T3). |
| `setup` + "pin this" as rules, not skills | **already holds** | root's protections are `CLAUDE.md` rules, not skills. |
| One knowledge base, split when needed | **already holds** | `wiki/` is one base with labelled subfolders — the "split when needed" case. |
| **Light** per-note sourcing | **REJECT** | the root keeps full OKF citations on every compiled page — it's a research KB where "why we believe this" is the product. |
| **No "loop" word** for users | **REJECT** | the root's audience is maintainers and the loop *is* the subject. |
| **Minimal note contract** as the floor | **REJECT** | the root runs the richer OKF frontmatter deliberately. |

Net: three small *adoptions* (protection-honesty framing, structured-view-vs-living-doc rule, runtime
note), one *partial* (`lint`/`distill` vocabulary), and three recorded *rejections* (light sourcing,
no-loop-word, minimal-contract floor). The rest already holds.

# Citations
[1] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — the ingest/query/lint loop both
    the root and the kit run.
[2] [OKF Specification v0.1](/sources/google-2026-okf-spec.md) — the bundle contract and the
    minimal-required-field discipline the root keeps and the kit lightens.
