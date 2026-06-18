# SPEC — brainkit (a policy layer on loopkit)

> **Status:** candidate design spec — **not** authorization to ship to `dist/`. Per
> [`CLAUDE.md` §8](../CLAUDE.md), promotion needs a validated pattern + very-high confidence +
> an explicit human go/no-go. This file is research/design; it iterates freely.
> **Provenance:** `inferred` — synthesized from the loopkit foundation, the staged WAH source
> ([`inbox/work-agent-harness.md`](../inbox/work-agent-harness.md)), and a live design conversation
> with the maintainer (2026-06-18). Grounding ingest of WAH (T8) is still pending.
> **Lineage:** `karpathy-core` → `loopkit` → **brainkit**. brainkit realizes the
> "work-agent-harness kit built *on* loopkit" anticipated in
> [`dist/REGISTRY.md`](../dist/REGISTRY.md) (lines 36–38) and T7/T8 — scoped down to the subset
> that *doesn't* break the core loop.
> **Resolved (2026-06-18):** task policy default = **embodied** (tasks as typed nodes *with parents*);
> name = **brainkit**; `process/extract` folds into `ingest`; per-entity timeline = section on the
> entity note; WAH ingest + "spec as a loop-library source, shipped in the dist" are build-plan steps
> (§14). Standing: Q4 starter-type set ("good start," refine during build).

---

## 1. What brainkit is (one paragraph)

brainkit is a **"second brain" kit**: a self-contained, vendorable fork of
[`loopkit`](../dist/loopkit/) whose bundled skills are re-authored to make *intake* high-fidelity
and *knowledge* trustworthy enough to drive a deliverable. It is **loopkit's contract, unchanged**,
plus an opinionated **policy layer** — sharper `ingest`/`query`/`distill` behavior, a few
**pre-typed starter entities**, a first-run interview that captures the user's **work products** and
**declared-timeline entities**, and a **task-extraction** decision. It descends from the home-brain
/ work-agent-harness lineage but deliberately keeps only the primitives that serve the core goal and
drops every primitive that re-introduced hand-synced or out-of-scope machinery.

## 2. The core goal (north star — becomes the kit's `PROJECT.md` framing)

> **Recursive loops that build knowledge to improve one or more declared work products.**

Every brainkit behavior is justified against this sentence. Knowledge is never an end in itself; it
accrues **in service of a declared deliverable**, and the loop is **recursive** (each pass makes the
next intake cheaper and the work product better). Two corollaries used throughout this spec:

- **Retrieval is the point.** Knowledge that can't be found or linked later cannot improve a work
  product. So intake pays an enrichment tax (resolve, expand, link) *up front*.
- **Trust is the point.** A work product should draw on knowledge whose maturity and lineage are
  known. So knowledge carries a maturity ladder and a traceable source edge.

## 3. Foundational principle: **policy, not plumbing**

brainkit changes **policy** (skill bodies, starter templates, onboarding, `PROJECT.md`). It does
**not** change loopkit's **contract / mechanisms**. brainkit is self-contained (it vendors loopkit's
plumbing verbatim — a shippable artifact must be self-contained, never coupled to a wiki or memory
the user's repo won't have); "no plumbing change" means the following
loopkit invariants are preserved **exactly** and any brainkit behavior that would violate one is out
of scope:

| loopkit invariant (preserved verbatim) | brainkit relies on it for |
|---|---|
| Notes are typed entities; `type:` is the node field | every pre-typed entity below |
| Frontmatter is a floor; **never drop an unknown key** | user-added `status:`/`owner:`/`requested_by:` survive every pass |
| Links are rel-md edges; an edge can carry a payload | citation quotes, attribution, timeline back-refs |
| Edges survive a split | attribution surviving task/knowledge extraction (§8) |
| `id:` optional, never minted by the kit; vault owns identity | safe folder moves; Duo interop |
| **Derived views are regenerated and stamped — never hand-cached, never a live cache** | the per-entity timeline (§6 F2) |
| Resolution leans on the vault/notes; persist nothing | interactive resolution (§6 F1); aliases live *on the entity note*, not in a side index |
| Golden context is locked; `distill` never trims it | unchanged |
| Keep it light — no databases, no hand-maintained schema grids | starter types are prose templates, not field grids |

If a proposed brainkit feature can't be expressed within this table, it does not belong in brainkit.

## 4. Design thesis

brainkit = loopkit **+** three things, all delivered as skill/template/onboarding policy:

1. **Retrieval-grade `ingest`** — interactive entity/alias resolution + acronym/shorthand expansion +
   linking, at capture time, with the human in the loop (§6 F1, F3).
2. **Write-time per-entity timelines** for declared entities — materialized at ingest, healed at
   distill, never computed at query time, always re-derivable from the graph (§6 F2).
3. **Maturity + lineage + work-product coupling** — source→knowledge ladders, citation edges, and a
   `query` mode that asks "what's missing for *this* deliverable?" (§7).

Plus the open design of **task extraction** (§8).

## 5. Relationship to the spectrum (what we port vs. drop)

From the divergence analysis (this conversation): brainkit ports the **build-on-top** band and
**dissolves or excludes** the breakers.

- **Ported (clean):** typed vocabulary, status/maturity ladders, source→knowledge lineage,
  domains-as-folders, interactive resolution, gap analysis, extraction discipline.
- **Dissolved by the graph (not ported as built):** hub-and-spoke hand-written timelines →
  re-derivable timeline artifact (F2); hand-maintained stakeholder map → optional regenerated
  `index-view`.
- **Excluded (breakers / different loops):** task *mirroring*, agent-control mirror-sync, publishing
  pipeline, the domain-strategy/roadmap/PRD layer. (See §10.)

---

## 6. The three core features

### F1 — Interactive entity & alias resolution at intake

**Behavior (in `ingest`):** when capture references an entity that is ambiguous or unverifiable,
resolve it **now, with the user**, rather than storing a vague reference or a silent flag. Order:
**closed-world first** — existing `knowledge/` notes → `golden/` → (Duo vault alias table if present)
— then **ask the user**; web lookup is *optional* and only when the user wants it. On resolution,
**record the alias on the canonical entity note** (`aliases: […]`) so the next capture auto-resolves.

**Invariants:** persist nothing outside the graph (the alias lives on the entity note; no side index);
prefer a vague-but-correct name over a confident-but-invented one; never upgrade a name you can't
verify.

**Why it serves the goal:** resolution makes a note *linkable* → it joins the work product's graph →
and each recorded alias makes the *next* loop cheaper. This is the most direct embodiment of
"recursive loops that build knowledge."

### F2 — Write-time, per-entity, re-derivable timelines

**Behavior:** an entity **type template** may declare `timeline: true`. Entities of that type carry a
stamped `## Timeline` section on their own note. `ingest` **appends** a dated entry when it files a
note that touches the entity; `distill` **re-derives and heals** the whole section and re-stamps it
(when / from what). **Never computed at query time.**

```markdown
## Timeline
<!-- regenerated by distill 2026-06-18 from 4 linked notes -->

### 2026-06-15 — Re-evaluating the vendor
David raised cost concerns; action item logged. See [meeting](./meetings/2026-06-15-procurement.md).
```

**The one invariant that keeps this from becoming WAH breaker #11:** the timeline must stay
**re-derivable from the graph** — the authoritative event lives in the event/source note; the
timeline is its *index*, every entry a summary-of-a-linked-note. A fact must never live *only* in a
timeline. With that rule, intake-append + distill-heal cannot drift.

**Storage:** per-entity timeline = a section **on the entity note** (FOUNDATION lists "a timeline
section in a note's body" as exactly this affordance). A cross-entity roll-up (e.g. a people map), if
ever wanted, is a separate `type: index-view` node — also regenerated and stamped, never hand-kept.

### F3 — Source enrichment at intake (expand acronyms/shorthand, link entities)

**Behavior (in `ingest`):** raw capture (esp. meeting notes full of shorthand) becomes **one enriched
KB note** that *represents* the meeting/source: acronyms expanded, entities linked (`the vendor` →
`[Acme](./acme.md)`), terms made canonical. **Augment into a single graph citizen — do not make a
synced "clean twin" of the same content.** The **verbatim raw is preserved**: as a `## Raw` section
in the same file (if pasted) or as a link to the external original (a meeting link / Google Doc).
Enrichment is **additive** — never silently rewrite the user's words out of existence. Acronyms
discovered here are recorded as `aliases:` on the canonical entity (feeding F1).

**Two distinct outputs, kept straight:**
- **The meeting/source note** — enriched + linked + raw preserved. The retrievable record, and the
  surface F2 timelines derive from.
- **Extracted knowledge** — the genuinely reusable ideas/decisions pulled *out* of it, each its own
  `note`/`decision` entry with a lineage edge back (§7). A separate node is for *extraction*, never
  for a cleaned copy of the same text.

**Why no twin:** two KB markdown files (raw + clean) are two things to keep in sync — a drift surface
for zero benefit, since "preserve raw" is already satisfied in-file or by the external link.

---

## 7. Aligned primitives adopted (beyond the three features)

| # | Primitive | Skill surface | Serves the goal by… | Boundary |
|---|---|---|---|---|
| 1 | **Source→knowledge lineage** w/ citation-quote payloads | ingest / query | tracing every claim a work product uses back to its source | edge carries the quote; survives a split |
| 2 | **Gap analysis** ("what's missing for *this* work product?") | query | closing the recursive loop — surfaces the next thing to ingest | reads `work/` deliverable + graph; proposes, doesn't fabricate |
| 3 | **Maturity ladders** (`source: unread→reading→read→processed`; `note: draft→solid→canonical`) | all three | tells you what's trustworthy enough to pull into the deliverable | per-type `statuses:` in the type template; no global enum |
| 4 | **Reading-queue / unprocessed surfacing** | query (view) | shows the backlog of raw→knowledge | a regenerated `index-view`, not hand-kept |
| 5 | **Extraction discipline** (one idea per entry; name by what it teaches; don't duplicate—enrich) | ingest / distill | reusable knowledge across work products | house rules in the skill bodies |
| 6 | **Scoped retro** that improves the **knowledge + the type templates** (not the agent's global skills) | distill | keeps the recursion inside the KB↔work-product loop | does **not** touch agent control files (that's the root loop's `session-harvest`, out of scope here) |

---

## 8. Task management — tasks as typed nodes (resolved: **embodied** default)

Task **extraction** (recognizing discrete action items in raw capture — "David to send the SOC2 doc
by Fri") is genuine intake value and runs **regardless** of policy; it is part of enriched `ingest`,
parallel to knowledge extraction. What differs is the **sink**, set once in `PROJECT.md` as the
**task policy**. Resolved 2026-06-18: **`embodied` is the default** — the maintainer has no external
tracker, and embodied tasks earn their place in the graph (see hierarchy below).

- **`embodied` (default).** Tasks are first-class `type: task` **nodes** — owner edge, source/
  `requested_by` edge, `due:`/`status:`, and a **`parent` edge** (see hierarchy). The node **is** the
  single source of truth — **no mirrors** in domain files. `distill` surfaces stale/open tasks;
  `query` answers "what's open for X / under initiative Y / requested by Z."
- **`externalized` (supported, not default).** For users who *do* have a tracker: brainkit extracts,
  hands off, and keeps at most a **pointer edge** (a `task` node linking to the external item), never
  a copy of mutable state. Avoids WAH breaker #13 (mirrored `tasks.md` + domain copies that drift).
- **`off`.** No task handling; brainkit is pure knowledge.

**Tasks have parents — and that's why embodying them helps the graph.** A `task` carries a `parent`
edge to a **parent task** (decomposition) and/or to the **initiative / topic / work-product** it
advances. That hierarchy isn't task-tracker bureaucracy — it's *knowledge*: it wires "what needs
doing" to "what we're trying to build," which is exactly the core goal's "improve a declared work
product." A task under an initiative, sourced from the meeting that raised it, attributed to the
person who asked, is a richer graph than a flat external to-do list could be.

**Non-negotiable rule (both active modes):** **single source of truth, no mirrors.** Embodied → the
task node is SoT. Externalized → the external system is SoT and brainkit holds at most a link. This
is the exact line that turns WAH's breaker #13 into a non-breaker.

**Attribution + parentage survive decomposition.** An extracted task carries `requested_by`/`source`
*and* `parent` edges; all survive the loopkit "edges survive a split" rule. Closing a task can
surface its `requested_by` for a notify-the-asker loop — without any mirroring subsystem.

---

## 9. Pre-typed starter entities (shipped) + the alias mechanism

brainkit ships a **minimal** set of starter type templates so a fresh fork isn't empty; the user
extends/overrides them and declares their own (FOUNDATION: types are **user-owned**; `sync` never
touches `knowledge/templates/`). Starter set:

| Type | Purpose | Ladder / key fields | `timeline:`? |
|---|---|---|---|
| `source` | raw captured material to be mined | `statuses: [unread, reading, read, processed]`; `source_type`, `source_url`, `aliases` | no |
| `meeting` | enriched capture; attendees; raw preserved; primary timeline feeder | attendees (edges), `## Raw`/external link | feeds others |
| `note` | refined atomic knowledge entry | `statuses: [draft, solid, canonical]`; `origin`, lineage edge | no |
| `decision` | durable decision record (high value for work products) | `status`, rationale, source edge | optional |
| `person` | a tracked person | role, `aliases`; declared-timeline subject | **yes** (typical) |
| `task` | action item — **ships active** (default policy = embodied) | owner edge, `requested_by`/`source` edge, **`parent` edge** (task or initiative/work-product), `due`, `status` | no |

The user is expected to declare more (`org`, `topic`, domain-specific) and to set which carry
timelines. **Aliases mechanism:** every entity template includes `aliases: []`; `ingest` reads them
(and the Duo vault alias table when present) during F1 resolution and writes new ones back. This is
the only "index," and it lives *on the entities themselves*.

Work products are **not** a knowledge type — they live in `work/` per loopkit §10. brainkit couples
to them (gap analysis reads them) but does not model them as graph nodes.

---

## 10. Changes by surface (the actual build, when authorized)

**a. Bundled skills (re-authored — the bulk of the work):**
- **`ingest`** — add: interactive resolution (F1), acronym/shorthand expansion + linking + raw
  preservation (F3), alias write-back, timeline append (F2), knowledge **and** task extraction (§8),
  maturity-ladder stamping. Two-stage flow: **capture** (auto) vs **process/extract** (user-paced,
  judgment-heavy) — mirrors WAH's capture-vs-process split.
- **`query`** — add: gap analysis vs a declared work product (§7.2); reading-queue/unprocessed view;
  answer over task state when embodied. Still: index first, cite, file new conclusions back.
- **`distill`** — add: timeline **re-derivation + heal + stamp** (F2); alias/type-drift healing;
  stale-task / stale-source surfacing; the scoped knowledge+template retro (§7.6). Still suggest-only.
- **`CLAUDE.md`** — re-authored from loopkit's. brainkit is frequently the Claude Code **CWD**, so its
  `CLAUDE.md` is the operating manual the assistant reads on entry: the three features,
  tasks-as-typed-nodes (with parents), declared timelines, work-product coupling, and the first-run
  interview. (Managed file.)

**b. New skills:** **none required by default** — the above fits the three operations, honoring
the kit's keep-it-light rule ("not everything is a skill"). *Open:* promote `process/extract`
to its own skill only if it earns it (see §11 Q2).

**c. Pre-typed templates:** ship the §9 starter set as **seed content** under user-owned
`knowledge/templates/` (seeded once on fork, then user-owned — same pattern as loopkit's starter
`knowledge/index.md`). Never overwritten by `sync`.

**d. `PROJECT.md` + first-run interview:** loopkit's interview, plus — **(1)** name the **work
product(s)** the brain serves; **(2)** declare which **entities carry timelines**; **(3)** set the
**task policy** (default **`embodied`**; or `externalized` + *which* tracker; or `off`).

**e. Manifest / managed-vs-user split (`loop.manifest.json`):**
- `managed_files` (sync overwrites): `.claude/skills/**`, `scripts/sync.sh`, `loop.manifest.json`,
  `CHANGELOG.md`, `CLAUDE.md`, `work/templates/**`.
- `user_files` (sync never touches): `PROJECT.md`, `knowledge/**` (incl. `knowledge/templates/**`
  and `knowledge/golden/**`), `work/**`.
- **Seed-once content** (shipped into a user-owned path, never re-synced): the §9 starter templates,
  the starter `knowledge/index.md` w/ Duo marker.

brainkit consumes loopkit's [`FOUNDATION.md`](../dist/loopkit/FOUNDATION.md) rather than shipping its
own — it is an *application of* the foundation, not a new foundation to build on.

## 11. What brainkit must NOT do (explicit exclusions)

- ❌ Mirrored task state (`tasks.md` SoT + domain copies). → single-SoT only (§8).
- ❌ Hand-written hub-spoke timelines / hand-maintained roll-ups. → regenerated + stamped (F2).
- ❌ A cleaned "twin" of a source kept in sync with the raw. → one enriched note + preserved raw (F3).
- ❌ Agent-control mirror-sync (AGENTS ↔ CLAUDE ↔ .windsurf). → single-agent (Claude Code) kit.
- ❌ Publishing/sync-to-public pipeline. → out of scope; a separate concern if ever wanted.
- ❌ Domain-strategy/roadmap/PRD layer. → that's a different loop; brainkit stays a knowledge↔work-product loop.
- ❌ Any change to loopkit's contract/plumbing (§3).

## 12. Decisions (resolved 2026-06-18) + standing

**Resolved:**
- **Task policy default → `embodied`.** Tasks are `type: task` nodes with **`parent`** edges
  (task→task and task→initiative/work-product); no external tracker today; the hierarchy enriches the
  graph (§8). `externalized` stays supported for later.
- **`process/extract` → folds into `ingest`** as a user-paced stage (no new skill).
- **Timeline storage → section on the entity note** (per-entity); reserve `index-view` for cross-entity maps.
- **Name → `brainkit`.**
- **WAH ingest + "spec as a source, shipped in the dist" → build-plan steps** (§14), done in Phase 0
  to move provenance `inferred → extracted`.

**Standing:**
- **Q4 — Starter type set.** §9's six are a "good start" (maintainer); refine during the build
  (likely add `org`/`topic`, revisit `decision`).

## 13. Promotion path (§8)

This spec → (foreclosure-test / refine forks) → **explicit human go/no-go to build a candidate** →
candidate kit on a branch → **validation by real use** (which also validates loopkit's FOUNDATION
seam) → deliberate go/no-go to merge into `dist/`. Nothing here authorizes a `dist/` write.

---

## 14. Build plan (sequenced; the `dist/` write is gated)

**Phase 0 — grounding (research layer; no `dist/` write; maintainer-approved 2026-06-18).**
1. **Ingest WAH** as a real source (closes T8): immutable mirror under `sources/`, Source concept
   under `wiki/sources/`, compile the `WAH ↔ Duo-vault entity structure` comparison. Moves this spec
   `inferred → extracted`.
2. **Register brainkit in the research wiki** — a concept/loop page citing this spec + WAH + loopkit,
   so the research loop tracks it.
3. **Spec as a loop-library source** (maintainer instruction): freeze a copy of this spec as
   brainkit's design-of-record — Source concept at `wiki/sources/brainkit-spec.md`, living copy stays
   in `_meta/`. *(Open: also mirror into the immutable `sources/` tree? That layer is normally
   external-only — flagging before bending the convention.)*

**Phase 1 — scaffold the kit (⛔ the §8 `dist/` write — needs an explicit "go").**
4. Fork `dist/loopkit` → `dist/brainkit` (self-contained; loopkit contract/plumbing verbatim).
5. Re-author `CLAUDE.md` (CWD operating manual), `PROJECT.md` (north star + interview additions),
   `README.md`, `CHANGELOG.md` (v0.1.0), `loop.manifest.json` (managed / user / seed-once).
6. Ship the spec **in the dist** as a self-contained design doc (`dist/brainkit/DESIGN.md`).

**Phase 2 — re-author the three skills** (§10a): `ingest` (F1+F3, alias write-back, timeline append,
knowledge **and** task extraction folded in), `query` (gap analysis, queue view, task queries),
`distill` (timeline re-derive/heal, drift, stale surfacing, scoped retro).

**Phase 3 — starter content** (seed-once, user-owned paths): `knowledge/templates/` for the §9 types
(incl. `task` with `parent`/`aliases`/`statuses`); starter `knowledge/index.md` w/ Duo marker; empty
`knowledge/golden/`; `work/` + `work/templates/`.

**Phase 4 — harden + validate:** foreclosure test (does any of F1–F3 or the task design quietly break
a loopkit invariant or foreclose a later WAH feature?); real-use validation (also validates loopkit's
FOUNDATION seam) → **deliberate go/no-go to merge into `dist/`.**

**Gate:** Phase 0 is research and is approved — startable now. Phases 1+ write to `dist/` — the §8
gated action; on an explicit "go," the candidate is built on this branch (not merged) pending Phase 4.

---

## 15. Foreclosure resolutions (2026-06-18 — 24 verified findings → 1 blocker + 9 majors + 9 minors + a loopkit-side note; supersede earlier text where noted)

A 50-agent adversarial foreclosure pass confirmed brainkit is a sound **policy-only** design (it breaks
no loopkit invariant) but found precision gaps a builder would get wrong. All resolved as policy; none
touch loopkit's plumbing. Resolutions, baked into the built kit:

**Blocker**
- **B1 — manifest uses literal paths, never `**` globs.** `sync.sh` iterates each `managed_files`
  entry as a literal path and skips anything not on disk; a glob silently no-ops (would never sync the
  re-authored skills — the kit's whole point). `managed_files` lists every file explicitly.
  *(Supersedes §10e's glob entries.)*

**Majors**
- **M1 — DESIGN.md is derived, not a copy.** `dist/brainkit/DESIGN.md` is authored from the design
  content (§1–§11) only, stripped of every research-repo reference (REGISTRY/T7/T8/wiki/_meta/sources,
  the §12–§14 gating/plan) and any `[[wikilink]]`; it must pass loopkit's self-containment bar.
  *(Supersedes §14 step 6.)*
- **M2 — brainkit ships FOUNDATION.md and README.md, both managed.** The inherited CLAUDE.md links
  FOUNDATION.md (same-dir), so it must ship (vendored from loopkit, kept current by sync). README.md is
  managed too. *(Supersedes §10e; the "consumes loopkit's FOUNDATION rather than shipping its own" line
  is withdrawn.)*
- **M3 — three-way template/golden split.** `knowledge/templates/README.md` and
  `knowledge/golden/README.md` are **managed** (machinery docs); the §9 starter type templates and
  starter `knowledge/index.md` are **seed-once** (committed into the fork, omitted from managed_files,
  never re-synced); the user's authored type/golden notes are **untouched**. *(Supersedes §10e's
  "knowledge/** sync never touches.")*
- **M4 — F3 raw-mode is durability-gated.** In-file `## Raw` and external-link are not equivalent.
  External-link is allowed only for a durable, immutable original; for mutable/ephemeral originals
  capture verbatim in-file, and even external-link mode snapshots the key verbatim excerpts in-file
  (mirroring the `raw_mirror` Source-concept pattern). The `meeting` type defaults to in-file `## Raw`.
- **M5 — F2 timeline has explicit generated markers.** The regenerated region is wrapped in
  `<!-- BEGIN/END generated:timeline -->`; distill overwrites only inside them, **detects** any
  hand-edit inside and surfaces it (suggest-only) for relocation; the timeline template states the
  section is machine-owned.
- **M6 — F2 "touches" predicate defined.** An entity is timeline-touched by a note iff it is an
  **attendee or an explicitly-linked subject**; incidental F3-enrichment mentions do **not** append.
  ingest-append and distill-heal apply the same predicate. Meeting attendees are rel-md edges.
- **M7 — task policy is a persisted field.** `task_policy: embodied | externalized | off` (default
  `embodied`) at the top of `PROJECT.md`; the three skills read it on entry.
- **M8 — `parent` edge integrity.** ingest walks the parent chain and refuses/repairs a cycle; distill
  treats a task with open children as not-retireable (or re-parents before retiring) — suggest-only.
- **M9 — `task` status ladder enumerated.** `statuses: [open, in-progress, blocked, done]`; "stale" =
  open past `due:` (or open + long inactivity); task status is a **closeable/reopenable** transition
  (not a monotonic maturity ladder) — the close→notify-the-asker loop relies on it. `decision` gets a
  ladder too.

**Minors**
- **m1 — "seed-once" is not new plumbing**, just "committed into the fork + omitted from managed_files."
  Tradeoff stated: post-v0.1.0 template fixes don't reach existing vaults (the cost of user-ownership).
- **m2 — re-express loopkit ingest's "don't dump raw verbatim"** as the dump-vs-preserve distinction.
- **m3 — F3 fidelity wording tightened:** the enriched body is a faithful transform; exact wording is
  preserved only in `## Raw` — the body is never the fidelity record.
- **m4 — F1 is vault-first:** with a Duo vault present, consult `duo vault schema` first; headless, fall
  back knowledge/ → golden/ → ask. Alias write-back stays on the entity note.
- **m5 — CLAUDE.md edit-safety:** it's managed and encodes only mechanism; every user choice routes to
  PROJECT.md / knowledge/templates/. The shipped file carries a one-line "edits overwritten by sync"
  banner.
- **m6 — reading-queue view is regenerated by distill, read by query** (the index-view rule), with a
  defined path/scan/stamp.
- **m7 — manifest `name: brainkit`, `origin` = brainkit's own repo** (TODO placeholder). An origin
  pointing at loopkit would re-vendor loopkit's skills over brainkit's.
- **m8 — REGISTRY updated:** the "(future) WAH kit" stub becomes brainkit's entry.
- **m9 — extraction negative test:** an extraction states one atomic idea in its own words with the key
  quote on its lineage edge; a candidate that mostly restates the source is a cleaned copy — drop it.
- **(loopkit precision debt noted)** loopkit's CLAUDE.md §4 / FOUNDATION line 62 / templates README
  footer carry the same loose "sync never touches knowledge/templates/" wording — a pre-existing
  imprecision to fix in loopkit separately (out of scope for brainkit).
