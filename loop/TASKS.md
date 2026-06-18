# Tasks — root (meta) loop

Forward-looking register of work / sub-goals (the complement to `wiki/log.md`, which is
backward-looking). Alpha — malleable. A `pattern-candidate` may ship to `dist/` **only** via the
bar in `CLAUDE.md` §8.

**Kinds:** `research-question` · `pattern-candidate` · `chore`  
**Status:** `open` · `active` · `blocked` · `parked` · `done`  
**Confidence:** `low` · `medium` · `high` · `very-high` (only `very-high` pattern-candidates may be promoted)

| id | title | kind | status | confidence | links |
| --- | --- | --- | --- | --- | --- |
| T1 | Define the loop primitives (goal · work product · tasks/sub-goals) | pattern-candidate | active | low | H1, H2, H3, H4 |
| T2 | Research goal & work-product specification, grounded in sources | research-question | open | low | T1, goal-directed-task-loop |
| T3 | Loop portfolio — how to track/see the project's loops (generated registry tried, then collapsed to a hand list) | pattern-candidate | done | low | H5, H6, loop/README |
| T4 | `session-harvest` skill — review → validate → execute → update-heuristics loop over session evidence | pattern-candidate | active | low | H7, intent-heuristics.md |
| T5 | Ship **loopkit** v0 to `dist/` — context-aware project kit (ingest·query·distill + golden + lockable work products) | pattern-candidate | done | very-high | dist/loopkit, dist/REGISTRY.md |
| T6 | Ingest the Duo `vault` skill reference as a proper source (currently cited as a local doc, not in `sources/`) | chore | done | n/a | duo-vault-vs-wiki, loopkit-on-duo |
| T7 | **Loopkit as the entity-graph foundation.** Q1–Q7 resolved + 4 mechanisms designed; **loopkit v0.1.0 candidate built** in `dist/loopkit` (PR #7), passed a 4-lens review (0 blockers; 1 major + 3 minors fixed); ships `FOUNDATION.md`. Dist split: pure primitive preserved as **`dist/karpathy-core`** v0.1.0; loopkit is the entity-graph sibling. Awaiting: real-use validation before merge. Prior prose-vocab attempt (PR #6) parked. | pattern-candidate | active | high | T5, T8, SPEC-loopkit-entity-foundation |
| T8 | Ingest WAH as a source — DONE: mirrored to `sources/`, Source concept + `WAH ↔ Duo-vault` comparison (hand-rolled vs native) filed; brainkit spec recorded as a source | chore | done | n/a | T7, work-agent-harness, wah-vs-duo-vault |
| T9 | **brainkit** — a policy layer on loopkit (re-authored skills + starter types + first-run interview; no plumbing change). **Candidate BUILT** in `dist/brainkit` (maintainer-authorized 2026-06-18), foreclosure-tested by a 50-agent pass (1 blocker + 9 majors + 9 minors folded in), ships `DESIGN.md`. Not yet validated by real use. | pattern-candidate | active | high | T7, T8, SPEC-brainkit, brainkit |

## T9 — brainkit (policy layer on loopkit)
**Goal:** a vendorable "second brain" kit whose north star is *recursive loops that build knowledge to
improve one or more declared work products*. Built **on** loopkit's contract unchanged (§ "policy, not
plumbing"): re-authored `ingest`/`query`/`distill`, a minimal set of pre-typed starter entities, a
first-run interview that captures work products + declared-timeline entities + a task policy, and
user-declared templates. Core features: **F1** interactive entity/alias resolution at intake, **F2**
write-time, re-derivable per-entity timelines, **F3** source enrichment (acronym/shorthand expansion +
linking, raw preserved). Task handling is **embody-or-externalize** (no mirrors). Excludes the WAH
breakers (task mirroring, mirror-sync, publishing, domain-strategy layer).
**Spec:** [`_meta/SPEC-brainkit.md`](../_meta/SPEC-brainkit.md). **Definition of done:** forks resolved
(spec Q1–Q6), foreclosure-tested, **then** very-high confidence + explicit go/no-go before any `dist/`
ship (§8). Doing T8 (ingest WAH) first would move the spec's provenance from `inferred` → `extracted`.
**Open:** Q1 task-policy default (rec: externalized), Q5 name (`brainkit`), Q6 WAH-ingest-first.

## T1 — Define the loop primitives
**Goal:** prototype the primitive shape at the root (alpha — this `loop/` folder), validate it,
and only then ship a templated version as a `dist/` kit.
**Definition of done:** a clear, defended definition of each primitive (goal, work product,
tasks/sub-goals); evidence the shape actually helps; **very-high confidence + an explicit
go/no-go** before any `dist/` ship (§8). **Tests:** H1–H4.

## T2 — Research goal & work-product specification
**Goal:** ground T1 in prior art — what makes a goal / work-product / done-criteria *well-posed*
(verifiable, terminating, non-gameable). Candidate source areas: eval/test-driven development,
acceptance criteria, reward specification & specification-gaming (Goodhart), LLM-as-judge rubric
design, self-refine / reflexion verifiers.
**Definition of done:** a grounded `wiki/` concept page (cited) that raises or lowers confidence
on H1–H4 and the goal-directed-task-loop hypothesis. **Honors** "nothing ingested without review."

## T3 — Loop registry + visualization
**Goal:** maintain an enumeration of a project's loops — one record per loop (name · encoding
location: skill/agent/`CLAUDE.md`/`loop/` · the H1–H3 primitive triple · `trigger`/`cadence`/
`exit_condition` · `maturity`) — rendered as (a) an **inventory** table and (b) a **topology**
graph (how loops feed/trigger/improve one another). The registry is the source of truth; the
diagram is a *generated view*. Extends T1: the per-loop record **is** the primitive triple, and
the registry is `wiki/index.md` filtered to `type: Loop` + a "where encoded" field.
**Open forks:** dogfood on this repo now vs. scope as a research→`dist` pattern first; registry
home (`loop/` alpha vs. a `wiki/` Overview page); medium (mermaid-in-markdown vs. generated SVG).
**Definition of done:** a registry covering this repo's current loops + one rendered view; a
defended medium choice. **Note:** revising `CLAUDE.md`'s "two engines" wording (per H5) is part of
this once validated — gated, not yet.
**Progress (2026-06-15) — superseded by the collapse note below:** dogfooded, self-syncing, and
wiki-independent. `LOOPS.md` inventory + mermaid topology were **generated** by
[`scripts/gen-loops.sh`](../scripts/gen-loops.sh) from a **self-contained**
[`loops.registry.json`](loops.registry.json); the generator reads no wiki content, so the
registry + generator travel with any repo that *uses* loops (a user's repo has no research wiki).
A `catalog` link to a wiki page is an optional cross-reference only. `--check` (wired into
`lint.sh`) fails on stale output.
**Progress (2026-06-15, later — DONE/collapsed):** removed the generated registry after
stress-testing its usefulness. Deleted `loops.registry.json`, `scripts/gen-loops.{py,sh}`,
`LOOPS.md`, and the `lint.sh` check; the loop portfolio is now a hand-maintained list in
[`README.md`](README.md). Rationale: at ~5 loops the machinery cost more than it returned; its
`--check` only guarded source↔view, not view↔reality (false anti-rot comfort); its source needed
manual upkeep anyway; the topology edges can't be auto-derived; and loopkit ships no generated map,
so this aligns the root with the kit. **Reopen** (option b: auto-derive nodes from `.claude/skills/`)
only past ~8–10 loops. The H5/H6 *insight* and the self-contained sub-finding stand.

## T4 — `session-harvest` skill
**Goal:** design the loop that keeps project intent fresh from session evidence: (1) review the
current/prior session for changes to intent, guided by a **heuristics doc**; (2) validate proposed
changes with the human; (3) execute the approved ones; (4) update the heuristics doc from the
feedback so it improves. Encoded as a skill; a candidate `Loop`/recursive-improvement page.
**Definition of done:** a hedged `wiki/` loop design page + a heuristics-doc shape; evidence it
helps on real sessions; later, **very-high confidence + go/no-go** before any `dist/` ship (§8).
**Honors** "validate with the human" and "nothing auto-promoted."
**Progress (2026-06-15):** built as an alpha skill at
[`.claude/skills/session-harvest/`](../.claude/skills/session-harvest/SKILL.md); heuristics doc
seeded at [`intent-heuristics.md`](intent-heuristics.md) (repo-level, not gated in the skill);
mechanism diagram added to the [catalog page](../wiki/loops/automation/session-harvest.md). **Still
open:** run it on real sessions to gather the evidence H7 needs; decide whether the 5-phase +
heuristics-doc shape generalizes enough to ship.

## T6 — Ingest the Duo `vault` skill reference as a source
**Goal:** the Duo-side claims in [duo-vault-vs-wiki](../wiki/comparisons/duo-vault-vs-wiki.md) and
[loopkit-on-duo](../wiki/concepts/loopkit-on-duo.md) currently cite a **local** skill doc
(`~/.claude/skills/duo/references/vault.md`), not a source in `sources/`. Both pages are `inferred`
and flagged. Mirror the doc immutably under `sources/`, write its Source concept under
`wiki/sources/`, and re-ground those two pages (provenance → `extracted` where warranted).
**Honors** "do not invent sources / nothing ingested without human review" — needs the maintainer's
OK that this local doc is an approved source.

## T7 — Loopkit on Duo (progressive enhancement)
**Goal:** turn the [loopkit-on-duo](../wiki/concepts/loopkit-on-duo.md) design into a decision. The
governing principle (baseline runs Duo-less + renders on GitHub; Duo only accelerates) is settled;
the open forks are the four decisions in that page: **A** `kind:`→`type:` field, **B** vault root
(`knowledge/` vs repo root), **C** ship the OKF `index.md` marker by default, **D** `id:` minting
(leave to Duo vs. mint in `ingest`).
**Definition of done:** A–D decided; a forkable loopkit that a Duo user can set as a default OKF
vault (capture → `inbox/`, verbs operate on the base, moves stay GitHub-renderable) **and** that a
Duo-less clone runs unchanged. **Gated:** any `dist/loopkit` change rides the §8 bar + an explicit
go/no-go — this design is research input, not authorization.
**Progress (2026-06-15):** spec written at [`_meta/SPEC-loopkit-on-duo.md`](../_meta/SPEC-loopkit-on-duo.md),
hardened by an adversarial multi-agent pass (18 agents; 3 blockers + 4 majors + 23 completeness
items folded in; ground-truth re-verified against the shipped skills + `sync.sh`). **Key reframe:**
schema-as-a-file is *rejected* (violates loopkit §7 "no databases" AND Duo's no-sidecar rule) →
encoded vocabulary = **golden prose** (`knowledge/golden/vocabulary.md`), "observed" rung =
**computed live by `distill`**, never persisted. A–D resolved in §9 (A overridden: keep `kind:`).
Re-derivation guarantee is **query-path only** (shipped `ingest`/`distill` don't read golden today).
**Still open:** the §8 go/no-go on the dist-touching phases — **P2** (distill reads vocabulary +
emits the live observed-count / off-vocabulary flags), **P3** (opt-in OKF marker), **P4** (ingest-time
resolution + `inbox/` scan). P1 (golden vocabulary as a user-side convention) touches no managed file.
**REDIRECTED (2026-06-16):** the progressive-enhancement / prose-vocabulary direction was the wrong
target — it under-read the goal (a typed-entity graph with resolution) and absorbed too little of the
entity model. New spec [`_meta/SPEC-loopkit-entity-foundation.md`](../_meta/SPEC-loopkit-entity-foundation.md):
loopkit = the entity-graph **foundation** the next work-agent-harness is built *on*, not *in* (typed
`type:` nodes, payload-bearing rel-md edges, resolution leaning on the vault, emergent→encoded taxonomy
as templates). Designed + foreclosure-tested by a 23-agent pass (0 future WAH pieces foreclosed; 9
at-risk → affordances; 4 mechanisms still to design). **PR #6 parked** (prose-vocab v0.2.0, draft).
**Next:** human calls Q1–Q7 (esp. Q1 `kind:`→`type:`), then design the 4 open mechanisms, then §8.
