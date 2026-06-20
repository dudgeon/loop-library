---
type: Concept
title: Knowledge ↔ runtime boundary
description: The discipline of keeping durable knowledge and machine runtime in two separate, never-collapsed locations, so a single fact has one canonical home instead of drifting copies scattered across rules, lessons, and config files.
tags: [context-management, knowledge-base, provenance, agent-harness]
timestamp: 2026-06-20T00:00:00Z
summary: Put knowledge in KNOWLEDGE_ROOT and runtime (schema, hooks, settings, sessions, auto-memory) in RUNTIME_ROOT, never collapsed; the separation gives every fact one canonical home and is the structural defense against three-copy drift.
provenance: extracted
confidence: 0.75
sources: [/sources/ouimet-2026-eqctrl-karpathy-plus.md]
related: [/concepts/drift.md, /concepts/progressive-disclosure.md, /loops/automation/ingest-query-lint.md]
---

The **knowledge ↔ runtime boundary** is a placement rule: durable knowledge and machine
runtime live in two clean, separate directories that are *never collapsed into one*. In
Ouimet's [Karpathy+ system](/sources/ouimet-2026-eqctrl-karpathy-plus.md) the split is literal —
knowledge in `KNOWLEDGE_ROOT` (`~/AI/`), runtime in `RUNTIME_ROOT` (`~/.claude/`) — and the
author is emphatic that **"the separation IS the rule."**

## What goes on each side

| Side | Holds | Why here |
| --- | --- | --- |
| **Knowledge** (`KNOWLEDGE_ROOT`) | the wiki, project repos, personal/career/outputs, raw sources awaiting curation | the durable, owned record — the "car" that outlasts any model |
| **Runtime** (`RUNTIME_ROOT`) | the schema (`CLAUDE.md`), hooks, skills, settings, sessions, history, telemetry, **auto-memory** | the machine's working state — disposable, model-specific |

Two finer rules follow: nothing sits loose at the knowledge root (every file has a **named
bucket/drawer**), and the **archive lives outside the search fence** so retrieval stays clean.

## Why it matters for loops

The boundary is a structural defense against [drift](/concepts/drift.md) — specifically the
"DRIFT" cause of death Ouimet names: *one fact in three files* (a rules file, a lessons file, a
corrections file) that diverge independently. If there is exactly **one canonical home** for a
fact, there is no second copy to drift. It is the placement-layer complement to
[provenance](/concepts/provenance.md) (which makes a claim's basis auditable) and
[progressive disclosure](/concepts/progressive-disclosure.md) (which governs what gets read):
the boundary governs *where a fact may be written in the first place*.

The load-bearing insight generalizes past one person's directory names: **decide what folders
your agent's search tools can see before you file anything.** "Once a tool has a boundary, where
you put a file is a choice, not an accident." The runtime side's **auto-memory** is the dangerous
exception — it is knowledge the model writes about itself outside the canonical store, so the
weekly [lint](/loops/automation/ingest-query-lint.md) explicitly **diffs auto-memory against the
wiki** to keep the two honest.

## How this repo already embodies it (and where it differs)

This library enforces a related but not identical split: `sources/` is **read-only** to the
agent, `wiki/` is the compiled store, and `_meta/` holds the schema — ownership is *mechanical*
(see `CLAUDE.md` §1). The eqctrl framing adds the explicit **runtime** side (hooks, sessions,
auto-memory) that this repo does not yet model, and the warning that the agent's *private*
runtime notes are a drift vector. That gap is worth tracking: this repo has no auto-memory diff
step.

## Relationships
- **prevents** [drift](/concepts/drift.md) — removes the duplicate-copy precondition for the
  most common drift mode.
- **complements** [progressive disclosure](/concepts/progressive-disclosure.md) — boundary =
  where you may write; disclosure = what you may read.
- **is enforced by** the [lint](/loops/automation/ingest-query-lint.md) operation — root-cleanliness
  and auto-memory-drift checks police the boundary.

# Citations
[1] [Ouimet — eqctrl.io "Karpathy+" system](/sources/ouimet-2026-eqctrl-karpathy-plus.md) — the
    boundary rule (`KNOWLEDGE_ROOT` vs `RUNTIME_ROOT`), named buckets, archive-outside-the-fence,
    and the auto-memory drift diff.
