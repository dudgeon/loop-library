---
type: Source
title: 'Ouimet — eqctrl.io "Karpathy+" knowledge/context system'
description: A complete, opinionated file-based architecture for persistent LLM memory ("Karpathy+") — a three-layer wiki maintained by ingest/query/lint, hardened with a knowledge/runtime boundary rule, defense-in-depth enforcement, a completion gate, and a six-archetype human-gated agent fleet.
tags: [knowledge-base, context-management, provenance, human-in-the-loop, agent-harness, verification]
authors: [Ethan Ouimet]
published: '2026-06'
timestamp: 2026-06-20T00:00:00Z
resource: https://eqctrl.io/
raw_mirror: ../sources/ouimet-2026-eqctrl-karpathy-plus.md
---

# Ouimet — eqctrl.io "Karpathy+" knowledge/context system

The fully built-out version of the system Ouimet teased in his
[X thread](/sources/ouimet-2026-wiki-graph-drift.md). **Karpathy+** is a file-based,
model-agnostic persistent-memory architecture for an LLM agent, organized around one mental
model — *the context window is RAM, files are disk* — and one promise: built in an afternoon,
maintained in minutes a week, designed to close **silent drift**. Its spine is the same
**three-layer / three-operation** wiki this repo runs (sources → wiki → schema; ingest /
query / lint), but it adds the parts this library was missing names for: a **boundary rule**
(knowledge vs. runtime live in two never-collapsed directories), **defense-in-depth
enforcement** (a stack of cheap, independent nets plus a constitutional *completion gate*),
the **snapshot problem** ("copies drift; links don't — verify at consumption"), the **three
causes of death** (Load, Drift, Silence), the **router-not-warehouse** framing of the schema
file, and an **Agent Operations** fleet of six archetypes under four governing principles
(steward scope, glass-not-load-bearing, three planes, a human gate on everything that matters).
The source is unusually convergent with this repo — it independently arrives at progressive
disclosure, ingest/query/lint, and drift — which makes it strong corroboration for the
library's thesis, with the caveat that it is one practitioner's system (and the author runs
GTM at HipAI, listed in its field kit). Documented as free to fork with credit.

# Key points
- **Three layers.** *Sources* (raw/messy) → *Wiki* (curated, 15–30 pages, one durable area per
  file) → *Schema* (`CLAUDE.md`, ~50 lines, *zero knowledge* — only tells the LLM how to read
  the wiki) → *Session*. "The model is the engine; the memory is the car" — swap models, keep
  the wiki.
- **The boundary rule.** Knowledge goes in `KNOWLEDGE_ROOT` (`~/AI/`), runtime in `RUNTIME_ROOT`
  (`~/.claude/`); never collapsed. The separation *is* the rule — it prevents one fact landing in
  a rules file, a lessons file, and a corrections file that drift apart. Nothing sits loose at the
  knowledge root; every file has a named bucket; the archive lives outside the search fence.
- **Progressive disclosure as a gate.** Each session loads schema (~50 lines) + index (<50 lines)
  + only 2–4 task-relevant pages — never the whole pile, because "a system that requires loading
  everything … gets skipped in long sessions." A plan is *not* enough context: load the pages it
  references; **plans decay faster than the project state they depend on**.
- **Three operations, concretely.** *Ingest*: after a fix/decision, update the page and append a
  log entry that includes a one-sentence **`Judgment:` line — the *why*, which is what future
  sessions use**. *Query*: read INDEX first, every session, no opt-out. *Lint*: a weekly **13-step
  checklist** (update queue, freshness vs. git, broken links, task aging, log-gap, unprocessed
  sources, log rotation, root cleanliness, **auto-memory drift diff**, plan reconciliation,
  heartbeat, report, optional sync). Rule: **flag once; build infrastructure only when a pattern
  fires twice**.
- **Defense in depth.** Discipline fails during fires, so stack independent, cheap, "a-little-dumb"
  nets (schema, session-hook tripwire, weekly lint, git history, heartbeat, output verifier, human
  completion gate) that fail only if *all* miss at once. Three enforcement *modes*: file-state
  checks, tripwires, output verification — each blind to what another catches.
- **The completion gate (constitutional rule).** Nothing is "done" until (1) the change works,
  (2) the docs reflect it (wiki page + `log.md`), (3) any deploy/script change followed its
  checklist. "Skipping it under pressure is the exact failure that caused most past incidents."
- **The snapshot problem.** The moment a fact leaves the wiki the copy stops updating; auto-memory,
  UI instructions, forwarded prompts are **snapshots, not live references**. "Copies drift; links
  don't." **Verify at consumption, not at creation.** A forwarded/terse instruction is *a claim,
  not a direction* — re-derive scope from the current wiki first.
- **Three causes of death.** *LOAD* (rules too long → skipped), *DRIFT* (one fact in three files),
  *SILENCE* (nothing written down during a fire). Every design choice dodges one of these.
- **Schema = router, not warehouse.** `CLAUDE.md` is a small always-loaded front door that
  bootstraps the index and pulls only relevant pages; the wiki is the warehouse. Keep it
  under ~80 lines; knowledge in pages, not rules.
- **Enforcement must be mechanical or loud, never polite.** A warning in a log nobody reads equals
  no check. A check must *fix* the problem (mechanical) or *interrupt* a human who will (loud); the
  quiet middle "is always a lie." And: "your dev machine lies to you" — run checks somewhere that
  disagrees with your dev environment (case-insensitive macOS hides link drift that breaks on Linux).
- **Agent Operations.** Six archetypes (Attended Heartbeat, Scheduled Drafters, Sweepers &
  Digesters, the Responder, Intake Pollers, Health & Hygiene Crons) under four principles:
  **steward scope** (draft + report, never decide + ship — the line is what it *can't take back*),
  **glass not load-bearing** (the dashboard is a window; kill it and the system runs), **three
  planes** (work / ops / surface), and **a human gate on everything that matters** ("a well-run
  fleet never graduates to fully autonomous; it graduates to faster yes").
- **Lineage.** Synthesized from Karpathy (ingest/query/lint), Atlas Forge (compounding agency),
  arscontexta (progressive disclosure, semantic links), Fraser Cottrell (memory folder, schema as
  behavior), lorepunk (creative collaboration).

# Notable excerpts
- "The context window is RAM, files are disk."
- "Knowledge goes in `~/AI/`. Runtime goes in `~/.claude/`. … The separation IS the rule."
- "Copies drift; links don't. … Verify at consumption, not at creation."
- "Two copies of anything will drift."
- "A warning written to a log file nobody reads is functionally identical to no check at all.
  Enforcement must either fix the problem itself (mechanical) or interrupt someone who will (loud).
  The middle option — quietly noting the problem — is always a lie."
- "Nothing is 'done' until the change works, the docs reflect the change, and any deploy or script
  change followed its checklist."
- "The model is the engine, and the engine swaps. The memory is the car."
- "A well-run fleet never graduates to 'fully autonomous.' It graduates to faster drafts approved
  with less friction. The gate stays."
- "Flag once via lint. Build infrastructure only when the pattern fires twice."

# Caveats (read before citing)
- **One practitioner's system, presented as settled.** It is opinionated and prescriptive; specific
  thresholds (15–30 wiki pages, ~50/~80-line schema, 30/90/14-day staleness, ~50-page search
  threshold) are the author's heuristics, not validated findings.
- **Commercial adjacency.** The author runs GTM at HipAI, which appears in the field kit (§18) as
  "context graphs as a product." This source is mostly system design, not a pitch, but note the
  interest.
- **Convergence ≠ independent proof.** Where it agrees with this repo (progressive disclosure,
  ingest/query/lint, drift) it is strong *corroboration*, but it draws on the same Karpathy lineage,
  so treat overlaps as a shared ancestor, not two independent confirmations.

# Compiled into
- [Knowledge ↔ runtime boundary](/concepts/knowledge-runtime-boundary.md) — new concept (the boundary rule)
- [Defense in depth (mechanical enforcement)](/concepts/defense-in-depth.md) — new concept (nets + completion gate + mechanical-or-loud)
- [Agent operations: a human-gated fleet](/loops/agentic/agent-operations.md) — new overview (six archetypes + four principles)
- [Drift](/concepts/drift.md) — reinforced (snapshot problem, three causes of death, verify-at-consumption)
- [Progressive disclosure](/concepts/progressive-disclosure.md) — reinforced (load index + 2–4 pages; plans decay)
- [Ingest → Query → Lint loop](/loops/automation/ingest-query-lint.md) — reinforced (13-step lint, Judgment lines, completion gate)
- [What makes a knowledge loop robust](/synthesis.md) — new robustness condition (enforce mechanically)
