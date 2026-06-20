---
type: Concept
title: Defense in depth (mechanical enforcement)
description: Keeping a maintenance loop honest by stacking several cheap, independent, "a-little-dumb" checks plus a human completion gate — so the system fails only when every net misses at once — rather than relying on discipline, which fails during fires.
tags: [verification, human-in-the-loop, knowledge-base, retro, provenance]
timestamp: 2026-06-20T00:00:00Z
summary: Discipline fails under pressure, so stack independent cheap nets (schema, tripwire hook, weekly lint, git history, heartbeat, output verifier, human completion gate) across three modes; each must fix the problem or loudly interrupt — never quietly log it.
provenance: extracted
confidence: 0.75
sources: [/sources/ouimet-2026-eqctrl-karpathy-plus.md]
related: [/loops/automation/ingest-query-lint.md, /concepts/drift.md, /concepts/provenance.md, /synthesis.md]
---

**Defense in depth** is the answer to a hard truth about maintenance loops: *discipline alone
fails during fires*. When something urgent breaks, the human (or agent) fixes the urgent thing
and records nothing — Ouimet's **SILENCE** cause of death. The fix is not "try harder"; it is to
stack several **independent, cheap, a-little-dumb** checks so that the system fails only when
*all of them* miss at once. [Source](/sources/ouimet-2026-eqctrl-karpathy-plus.md).

## The stack of nets

| Net | What it catches | Mode |
| --- | --- | --- |
| Schema (house rules, ~50 lines) | behavioral drift, wrong file placement | — |
| Session hook (tripwire) | a change happened that needs a wiki update | tripwire |
| Weekly lint (file check) | stale pages, broken links, unprocessed sources | file-state |
| Git history | what changed and when; serves as the archive | file-state |
| Heartbeat (timestamp) | whether the system is actually running at all | output |
| Verifier (output check) | whether a scheduled job produced its expected file | output |
| Completion gate (human) | nothing is "done" until it works *and* the docs reflect it | human |

## Three enforcement modes

The nets deliberately span three modes, because each mode is blind to what another catches:

1. **File-state checks** — does the record match reality? (blind to *runtime*)
2. **Tripwires** — did a change happen that needs follow-through? (blind to *staleness*)
3. **Output verification** — did a scheduled job actually produce its output, on time? (the only
   mode that can see whether something is *running*, since every other net just reads files).

## Two load-bearing rules

- **The completion gate (the "constitutional rule").** Nothing is done until **(1)** the change
  works (smoke test / verification), **(2)** the docs reflect it (wiki page + `log.md`), and
  **(3)** any deploy or script change followed its checklist. Skipping it under pressure is named
  as the cause of most past incidents — it is the same instinct as SILENCE, gated.
- **Mechanical or loud, never polite.** "A warning written to a log file nobody reads is
  functionally identical to no check at all." A net must either **fix** the problem itself
  (mechanical) or **interrupt** a human who will (loud); the quiet middle option "is always a
  lie." Corollary — *your dev machine lies to you*: run checks somewhere that **disagrees** with
  your dev environment (a case-insensitive macOS filesystem hid link drift that broke on Linux;
  only the server check caught it).

A restraint balances the stack: **flag once; build infrastructure only when a pattern fires
twice.** Defense in depth is not an excuse to over-engineer — each net must stay cheap.

## Why it matters for loops

The [ingest → query → lint loop](/loops/automation/ingest-query-lint.md) is exactly the kind of
maintenance loop that rots silently — its failures ([drift](/concepts/drift.md), stale claims,
unlogged fixes) don't throw errors. [Provenance](/concepts/provenance.md) makes the artifact
*auditable*; defense in depth is what makes the audit *actually happen* on a schedule and during
fires, rather than depending on a human remembering to care. It sharpens the
[synthesis](/synthesis.md): grounding is real only if something mechanically re-checks it.

## Relationships
- **operationalizes** [the lint operation](/loops/automation/ingest-query-lint.md) — the weekly
  checklist is one net among several, not the whole defense.
- **backs** [provenance](/concepts/provenance.md) — citations are auditable; these nets perform
  the audit and refuse to do it quietly.
- **counters** [drift](/concepts/drift.md) — the heartbeat/verifier/tripwire nets catch the
  silent divergence a single check would miss.

# Citations
[1] [Ouimet — eqctrl.io "Karpathy+" system](/sources/ouimet-2026-eqctrl-karpathy-plus.md) — the
    net stack, the three enforcement modes, the completion gate, "mechanical or loud, never
    polite," and "your dev machine lies to you."
