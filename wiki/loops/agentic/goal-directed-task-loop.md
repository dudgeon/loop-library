---
type: Loop
title: Goal-Directed Task Loop (hypothesis)
description: A working hypothesis — that a minimal agentic loop becomes well-posed when given an explicit goal and an output-requirements checklist, iterating plan→produce→check→revise until met. Unvalidated; not shipped.
tags: [planning, verification, generate-test, termination, cost-control, human-in-the-loop]
timestamp: 2026-06-15T00:00:00Z
loop_family: agentic
cadence: per-step
trigger: a goal + output-requirements are defined and the loop is run
exit_condition: every acceptance check passes, max iterations reached, or a blocker needs the human
maturity: experimental
status: draft
aliases: [vanilla loop, define-then-run loop, goal-and-check loop]
summary: HYPOTHESIS (unvalidated, not shipped) — that two light scaffolds, a goal definition and an output-requirements checklist, turn open-ended iteration into a verifiable, terminating plan→produce→check→revise cycle.
provenance: inferred
confidence: 0.4
sources: [/sources/karpathy-2026-llm-wiki.md]
related: [/loops/automation/ingest-query-lint.md, /concepts/provenance.md, /synthesis.md]
---

> **⚠ Unvalidated hypothesis — not a shipped pattern.** The "goal file + output-requirements
> file" scaffolding was floated *notionally* by the human, not validated. It is recorded here
> (in the research layer, hedged) as the subject of an open research question, **not** in
> `dist/`. It may ship only after clearing the promotion bar (see the repo's `dist/REGISTRY.md`
> and `CLAUDE.md` §8). `provenance: inferred`, `confidence: 0.4`.

## The question this addresses
Karpathy's loop maintains a *knowledge corpus* but says nothing about putting it to productive
use or about specifying a goal. The open question: **what makes a goal + output-requirements
specification well-posed** — i.e. verifiable, terminating, and non-gameable — for a delivery
loop? This page is the current best guess; it needs grounding.

## Hypothesized mechanism (to be tested)
Define once, then iterate:

| Phase | What happens |
| --- | --- |
| **Define** | write a goal (objective, constraints, stop conditions) and an output-requirements checklist |
| **Plan** | choose the smallest useful next step toward the goal |
| **Produce** | write/update an output draft |
| **Check** | verify the draft against **every** requirement, pass/fail **with evidence** |
| **Revise** | if any check fails and iterations remain, loop back to Plan |
| **Stop** | all checks pass · max iterations · a blocker needs the human |

The bet is that the two scaffolds carry the load: the goal prevents drift; the checklist makes
"done" objective. **Whether this is the right scaffolding, and how to write good specs, is
exactly what's unproven.**

## What we'd need to validate before shipping
- Grounding in real prior art (eval/test-driven dev, acceptance criteria, reward specification
  & specification-gaming/Goodhart, LLM-as-judge rubric design, self-refine/reflexion verifiers).
- Evidence the scaffolds improve outcomes vs. a bare loop (real runs, not assertion).
- A defensible answer to non-gameability (checks that can't be satisfied trivially).
- Very-high confidence + a deliberate go/no-go (CLAUDE.md §8).

## Relationships
- **contrasts with** the [ingest → query → lint loop](/loops/automation/ingest-query-lint.md):
  that one *accumulates knowledge* with no terminal state; this one would *deliver an artifact*
  and stop. "Productive use" of the corpus is the *composition* — a delivery loop whose context
  is the knowledge corpus.
- **depends on** [provenance](/concepts/provenance.md) for the evidence discipline in its Check
  phase.

## Citations
[1] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — establishes the corpus loop
    and explicitly leaves goal-setting / "what it all means" to the human; the gap this
    hypothesis tries to fill.
