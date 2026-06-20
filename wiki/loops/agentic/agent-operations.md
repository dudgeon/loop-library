---
type: Overview
title: 'Agent operations: a human-gated fleet'
description: A map of Ouimet's Agent Operations architecture — six agent archetypes (from an attended heartbeat to hygiene crons) governed by four principles that keep every agent a steward that drafts and reports rather than a principal that decides and ships.
tags: [agent-harness, human-in-the-loop, automation, verification]
timestamp: 2026-06-20T00:00:00Z
summary: Six agent archetypes run on clocks and mentions but only ever draft and report; four principles (steward scope, glass-not-load-bearing, three planes, a human gate on everything that matters) keep irreversible action behind a deliberate human yes.
provenance: extracted
confidence: 0.7
sources: [/sources/ouimet-2026-eqctrl-karpathy-plus.md]
related: [/loops/automation/ingest-query-lint.md, /concepts/defense-in-depth.md, /loops/agentic/goal-directed-task-loop.md]
---

Where the [ingest → query → lint loop](/loops/automation/ingest-query-lint.md) keeps a single
agent's *knowledge* honest, **Agent Operations** governs a whole *fleet* of agents acting on the
world. It is the operations half of Ouimet's [Karpathy+ system](/sources/ouimet-2026-eqctrl-karpathy-plus.md),
and its organizing commitment is that every agent is a **steward, not a principal**: it drafts
and reports; it never decides and ships. This page is a map of the sub-area, not a single loop.

> **Scope (maintainer call, 2026-06-20):** operational agent-fleet loops are in-scope for the
> *research wiki's* taxonomy (this page), but are **not** a direction for the shipped `dist/` kits.
> Mine them for evidence on loop primitives and governance; don't build them into product.

## The six archetypes

| Archetype | Trigger | Scope (what it may touch) |
| --- | --- | --- |
| **Attended Heartbeat** | human at the keyboard | reads the board, drafts a brief; nothing changes until the human approves/redirects/defers each item. "You don't automate direction." |
| **Scheduled Drafters** | a clock | produce drafts/proposals only (Daily Runner, Weekly Board Health, Idea Incubator); never publish |
| **Sweepers & Digesters** | a clock | read scattered sources → one short daily digest (Commitment Sweep, Link Digester); read + report |
| **The Responder** | a mention | wakes and replies *in-channel*; speaks for the user, doesn't act for them; can't create tasks, move records, or message outside its channel |
| **Intake Pollers** | new drops | turn links/half-ideas into sorted, scoped items ready for promotion or deletion |
| **Health & Hygiene Crons** | a clock | report on system health, don't do the work (Smoke Test — silence means green; Knowledge Hygiene — stale-page audit) |

The recurring shape: **clock or mention fires → agent drafts → human gate → act only after an
explicit acknowledgement.** Note the deliberate echo of [defense in depth](/concepts/defense-in-depth.md):
the hygiene crons and smoke tests are the *output-verification* nets applied to a live fleet.

## The four governing principles

1. **Steward scope.** The line isn't what an agent *can* do, it's what it **can't take back** —
   "you can fix a draft before it matters; you can't unsend a message or un-merge code." A clear,
   deliberate **yes** is the gate; inaction is never a yes ("not deleting, not complaining — none
   of that is a yes").
2. **Glass, not load-bearing.** The dashboard is a *window* onto the system, not the system. Every
   button maps to a real write into real machinery; kill the dashboard and the system keeps
   running, because timed agents fire on a clock, not on a heartbeat from the screen.
3. **Three planes.** *Work plane* = the system of record (one source of truth; humans and agents
   both write). *Ops plane* = fleet state, built from **what agents report**, not what the screen
   shows. *Surface plane* = where the human steers (queue / approve / halt), reading from ops and
   writing back to work through approved actions only.
4. **A human gate on everything that matters.** The gate "isn't training wheels — it's the design."
   A well-run fleet **never graduates to fully autonomous**; it graduates to a *faster yes*. Each
   agent has a set, checkable scope (its tools, the places it can write), so the boundary is built
   into what it can touch rather than a rule it is merely asked to follow.

## Why it belongs in this library

It is a concrete, opinionated answer to **termination/authority** in agentic loops: rather than
trusting an agent to stop or to refrain, the design makes irreversible action *structurally*
unreachable without a human yes. That contrasts usefully with the
[goal-directed task loop](/loops/agentic/goal-directed-task-loop.md), whose open question is
exactly when an autonomous loop should halt or escalate. The honest caveat: this is one
practitioner's architecture, presented as settled and shaped partly by a product context (the
author runs GTM at HipAI) — so it is a well-articulated *design stance*, not a validated result.

## Relationships
- **shares enforcement DNA with** [defense in depth](/concepts/defense-in-depth.md) — the human
  gate is the completion-gate idea applied to actions instead of edits.
- **contrasts with** [the goal-directed task loop](/loops/agentic/goal-directed-task-loop.md) —
  bounded-by-design stewardship vs. an open question about autonomous termination.

# Citations
[1] [Ouimet — eqctrl.io "Karpathy+" system](/sources/ouimet-2026-eqctrl-karpathy-plus.md) — the
    six archetypes and the four governing principles (steward scope, glass-not-load-bearing,
    three planes, a human gate on everything that matters).
