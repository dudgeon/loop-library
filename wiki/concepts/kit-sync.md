---
type: Concept
title: Kit sync as curation, not overwrite
summary: A vendored loop kit should refresh its machinery by agent-run curation — the assistant reads what changed upstream and pulls in only the improvements the user approves, merging rather than clobbering local tweaks — not by a deterministic script that overwrites every managed file; real use of brainkit showed the script model "nukes local tweaks that are expected."
tags: [dist, sync, vendoring, agent-harness, knowledge-base, drift, lint]
timestamp: 2026-06-28T00:00:00Z
provenance: extracted
confidence: 0.75
sources: [/sources/karpathy-2026-llm-wiki.md, /sources/work-agent-harness.md, /sources/google-2026-okf-spec.md]
related: [/concepts/brainkit.md, /concepts/drift.md, /loops/automation/ingest-query-lint.md, /comparisons/loopkit-vs-root.md]
---

> **Status — extracted from real use (2026-06-28).** The maintainer tested
> [brainkit](/concepts/brainkit.md) on a real work implementation and reported that its scripted sync
> was *"fine but heavy-handed… deterministic sync is bad as it will nuke local tweaks that are
> expected."* That observation is the grounding for this page; the redesign it motivates is applied in
> `dist/` (`karpathy-core`, `loopkit`, `brainkit` all at v0.2.0).

## The finding

Every shipped kit splits its files into **machinery** (`managed_files` in `loop.manifest.json` — the
skills, `CLAUDE.md`, docs, templates) and **user content** (`PROJECT.md`, `knowledge/`, `work/`). The
original update mechanism shipped a deterministic `scripts/sync.sh` that **cloned origin and overwrote
every `managed_files` path**. The split was meant to keep user content safe.

The split is real, but the assumption underneath the overwrite is false: **users edit machinery files
on purpose.** A tuned `CLAUDE.md` policy, an adjusted skill, a reworded template — these are
intentional local improvements that live *in* managed files. A deterministic overwrite cannot tell an
intentional tweak from staleness, so it erases both. The very property that made the script safe to
reason about — determinism — is what makes it destructive.

## The fix: sync is an operation, not a script

The redesign reframes sync as a **fourth agent operation** alongside ingest / query / distill — a
**`sync` skill**, not `scripts/sync.sh`:

1. **Read what changed upstream.** Fetch canonical upstream, compare each `managed_files` entry, and
   read the upstream `CHANGELOG` to understand *what* changed and *why*.
2. **Reason about value, here.** For each upstream change, judge whether it's worth adopting given how
   *this* fork is set up — a bugfix to a skill usually is; a doc reword may not be.
3. **Curate with the user.** Surface the compelling changes (structured prompt: adopt / keep mine /
   show diff / merge) and apply only what's approved.
4. **Merge, never clobber.** Where the user tweaked a file *and* upstream changed it, merge the upstream
   improvement into the local edit rather than replacing it.

The user's own framing: *"a user runs sync to learn what has changed in canonical brainkit, and then
selectively pull in only those improvements that are compelling."* Sync becomes **non-deterministic and
suggest-only by design** — the same discipline [`distill`](/loops/automation/ingest-query-lint.md)
already applies to the knowledge graph, now applied to the kit's own engine.

## Why a skill is the right tool

This is the repo's recurring lesson: a mechanical script can only enforce a *fixed rule*, and "which
upstream change is worth adopting into this particular fork" is a **judgment call**, not a rule. It is
the same reason [`distill`](/loops/automation/ingest-query-lint.md) is suggest-only and the same reason
the root loop keeps irreversible actions [behind a human yes](/loops/agentic/agent-operations.md).
Overwriting a user's deliberate edit is exactly the kind of silent, hard-to-reverse action that wants a
human in the loop.

It also rhymes with [drift](/concepts/drift.md) from the other side. Drift says *two copies of a fact
will diverge, so keep one canonical home.* Kit sync is the benign, **wanted** divergence: a vendored
fork is *supposed* to diverge from upstream as the user adapts it. The job of sync is not to collapse
that divergence (overwrite) but to **let the user reconcile it deliberately** — pulling improvements
without losing adaptations.

## Relationship to OKF

OKF gives kits the **self-describing bundle** shape — a portable directory that "knows what it is" via
`loop.manifest.json` (the [OKF spec](/sources/google-2026-okf-spec.md) makes the bundle the unit of
distribution; we apply it to a code artifact). OKF describes *what travels*; it says nothing about
*how an update is applied*. The deterministic script filled that gap badly. The `sync` skill fills it
in the spirit of the rest of the system: an agent maintaining a bundle, not a `cp` loop.

## Limits

- **Provenance.** The *finding* (deterministic overwrite nukes wanted tweaks) is `extracted` from a
  single real-use report. The *redesign* is a one-pass synthesis — it has not itself been validated by
  a sync against a genuinely diverged fork. Confidence is moderate until that happens.
- **n=1.** One work implementation surfaced this. It's a strong signal (it matches the system's stated
  values), but it is one data point.
- **Open question.** Whether the skill should keep a stored *baseline* (last-synced upstream snapshot)
  to auto-classify "you changed it" vs "upstream changed it" was deferred — the current design does a
  two-way local-vs-upstream comparison and leans on the agent's judgment plus git. A baseline would
  sharpen classification at the cost of a managed second copy of the machinery.

## Citations

[1] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — the operating model where an agent
*maintains* a markdown bundle (ingest/query/lint); sync extends that agent-maintenance to the kit's own
machinery.
[2] [work-agent-harness (WAH)](/sources/work-agent-harness.md) — the predecessor whose hand-synced
"mirror" machinery brainkit deliberately drops; deterministic sync was a smaller instance of the same
"two synced copies" breaker.
[3] [OKF Specification v0.1](/sources/google-2026-okf-spec.md) — the self-describing bundle that
`loop.manifest.json` realizes for a code artifact; defines what travels, not how it updates.
[4] Maintainer real-use report, 2026-06-28 (this session) — brainkit tested on a work implementation;
"deterministic sync is bad as it will nuke local tweaks that are expected."
