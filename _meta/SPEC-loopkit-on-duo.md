# SPEC-loopkit-on-duo.md — loopkit as a Duo-optional OKF vault

The normative contract for evolving the shipped `dist/loopkit` kit into a folder a
[Duo](https://github.com/dudgeon/duo) user can treat as an **OKF Note Vault** — **without** the kit
ever depending on Duo. It is a strict *extension* of the loopkit contract
(`dist/loopkit/CLAUDE.md`): the three-line note contract, the three operations
(`ingest`/`query`/`distill`), the managed-vs-user split, and the golden mechanics are **unchanged**
unless this spec says otherwise.

> **Status — golden candidate, not shipped.** Research-loop hypothesis extending
> [`/wiki/concepts/loopkit-on-duo.md`](../wiki/concepts/loopkit-on-duo.md) (provenance: inferred,
> confidence ~0.5). This document is **research input, not authorization.** No assertion here
> permits a change under `dist/loopkit/`; every such change is gated, *per item*, by
> [`CLAUDE.md` §8](../CLAUDE.md) (validated · very-high confidence · explicit human go/no-go ·
> shippable). It is a *candidate* for golden context once validated — promoting it is itself a §8
> decision. This spec was hardened by an adversarial multi-agent pass (2026-06-15); the findings it
> resolves are recorded in [`/wiki/log.md`](../wiki/log.md).

> **The one-line rule:** the encoded vocabulary is **golden prose, not a schema file**; the
> "observed" rung is **computed live, never persisted**; Duo only accelerates a kit that already
> works alone and renders on GitHub.

> **Implementation status (as built — [PR #6](https://github.com/dudgeon/loop-library/pull/6)).**
> Phases **P1–P3 are built; P4 is deferred.** One spec↔build divergence was found in a post-build
> audit and **fixed** (T11 `id:` preservation — the kit now carries its *own* preserve-unknown-keys
> rule; it was wrongly assumed to inherit one). The phase-by-phase and test-by-test record, the
> divergences, and the not-complete items are in **[§12 As-built record](#12-as-built-record-pr-6)**.
> Until PR #6 merges, `dist/loopkit` on `main` stays **v0.1.0** and this remains a *proposal*.

---

## 0. The reframe that defines this spec

The intuitive design — "infer entity structure during ingest, then *periodically encode it into a
schema file* so the agent stops reinventing it" — is **wrong**, and the wrongness is load-bearing.
A `knowledge/schema.md` with `## Types` / `## Fields` / `## Observed` tables fails **two** hard
constraints at once:

| Constraint | Source | Why a schema file violates it |
| --- | --- | --- |
| "No databases, no elaborate schemas" | loopkit `CLAUDE.md` §7 | A typed-field grid *is* a database by another name. |
| "The corpus MUST be computed live, **never cached to disk**" (no-sidecar) | Duo vault, [`/wiki/sources/duo-2026-note-vault.md`](../wiki/sources/duo-2026-note-vault.md) | A persisted `## Observed` count is a cached corpus that goes stale. |

So the disqualifying artifact is **killed**, and the valuable idea is kept by relocating it:

- **Encoded vocabulary → golden *prose*** in `knowledge/golden/vocabulary.md` (definitions are
  exactly what golden is for), not a typed grid.
- **The "observed" rung → computed live** by `distill` each pass, never written down — the
  no-sidecar discipline applied to ourselves.

Everything below follows from this reframe.

---

## 1. Purpose & the one principle

| | |
| --- | --- |
| **Purpose** | Let a Duo user get *more* from the same vendored loopkit — typed entities, link self-healing, a live corpus — while a Duo-less clone loses *nothing*. |
| **The one principle** | **Progressive enhancement.** Baseline works everywhere and renders on GitHub; the host (Duo) only **adds**, never gates. |
| **Hard invariant** | Nothing in loopkit may require a `duo` binary. If `which duo` fails, every operation still completes. |
| **Load-bearing test** | For *every* item in this spec: a Duo-less clone still works **and** still renders on GitHub. If not, it does not ship. |
| **Each Duo move is** | either **inert-when-absent** (an unused frontmatter key, an empty folder) **or** has a **no-Duo fallback** (the assistant does by hand what a `duo` verb automates). |

---

## 2. Non-goals

| Non-goal | Why |
| --- | --- |
| A `knowledge/schema.md` or any `## Types` / `## Fields` / `## Observed` grid | §0 — database-by-another-name (loopkit §7) **and** disk-cached corpus (Duo no-sidecar). Killed outright. |
| Renaming `kind:` to `type:` on notes | The note contract is frozen at `summary:` + `kind:` + `source:` (§4 / §9-A). |
| Wiki concepts on loopkit notes | No `provenance:`, `sources:` (plural), `# Citations`, or path-as-identity. Those are root-wiki, not loopkit. |
| Persisting an "observed" count to disk | No-sidecar (Duo) + no-database (loopkit). Computed live or not at all (§3.3). |
| `/absolute` bundle-relative links | That is the root wiki, which a fork lacks. loopkit uses `./relative` rel-md (§5). |
| A `log.md` in the kit | **loopkit ships no `log.md`** (only `knowledge/index.md` is the catalog). This spec adds none, and claims no `log.md` fallback. If Duo generates one, it is treated as inert user content. |
| A mechanical conformance gate beyond the 3-line contract | loopkit ships no gate but the contract. The vocabulary check is **suggest-only**, never a hard reject (§3.5). |
| Minting `id:` in loopkit | Preserve-only; never minted without the host (§9-D). |
| Stamping the OKF marker on every fresh fork | Opt-in, Duo-detected or user-asked only. A non-Duo fork stays frontmatter-free (§6, §9-C). |
| Surfacing the rung vocabulary ("emergent/observed/encoded") to the user | loopkit §7: talk about *their* knowledge, not theory. The ladder is internal mechanics (§3.2, §7-rule). |

---

## 3. The resolve-once vocabulary: emergent → observed → encoded

The kit lets the agent **define a concept once and resolve against it**, preventing the real
failure mode: **vocabulary drift**, where one concept fractures into N spellings (the enum-vs-entity
failure, §3.4). The encoded vocabulary is held as **golden prose**, never a schema file (§0).

### 3.1 Storage shape

| What | Where | Form |
| --- | --- | --- |
| The user's stable vocabulary | **`knowledge/golden/vocabulary.md`** (one golden note) | **Prose**, plain user language. *"We track **initiatives**. Each has a **scope** that is **internal** or **external**, and an **owner** (a person)."* **Not** a typed-field grid. |
| The "observed" shape | **nowhere on disk** | Computed live by `distill` (§3.3). Never persisted. |
| The `kind:` for *this* note | **nowhere on disk** | The label the agent picks at write time (§3.2). |

`knowledge/golden/vocabulary.md` is golden because it is exactly what golden is for — locked
**definitions and contracts** (`CLAUDE.md` §4) — so it is loaded as an authoritative constraint and
**wins on contradiction** using machinery the kit already ships. No new mechanism.

> **Guard against schema-creep (§0 by the back door).** `vocabulary.md` MUST stay prose. It may
> **not** contain `## Types`, `## Fields`, or `## Observed` headings, nor a per-field/per-enum
> table. That structure is the killed schema migrating into a new file; the §0 ban applies to the
> *shape*, not just the filename (test T14).

### 3.2 The lifecycle — a behavioral ladder, NOT a stored axis

This ladder is **schema-shape confidence** and is a **distinct vocabulary** from the wiki's content
`provenance: extracted | inferred | ambiguous`. Never reuse the `provenance:` key for it — that
would overload a conformance-gated field. The rung names are **internal**: they must never appear in
a user-facing prompt or in `distill` output (§7-rule).

| Rung | Where it lives | Trigger | Driver | Blocks? |
| --- | --- | --- | --- | --- |
| **emergent** | nowhere — the `kind:` the agent picks for *this* note | every ingest | agent, silently | never; never asks |
| **observed** | nowhere persisted — `distill` computes it live by reading current notes | each `distill` run | `distill`, mechanically | never |
| **encoded** | **`knowledge/golden/vocabulary.md`** | human says yes | human go/no-go ("pin this") | n/a |

### 3.3 Promotion & the human go/no-go

- **emergent → observed.** `distill` reads the current notes and counts recurring shapes **live,
  every pass**; the count is **recomputed, never stored**. Whether a shape "recurs" is a **judgment
  call the assistant states in the suggestion** ("appears across 5 notes") — *not* a magic
  threshold, keeping with loopkit's no-magic-numbers lightness.
  - **Cost honesty — no false "saving."** Live recomputation **relocates** re-derivation from
    ingest to distill; it does **not** reduce it. We choose it deliberately to honor the no-sidecar
    rule. Frame it as a **conformance cost**, never a saving. The *only* genuine re-derivation
    saving is the human-encoded golden note (§3.6), read at query time.
- **observed → encoded.** Rides `distill`'s existing **suggest-only numbered list** — one new item
  type on the one gate the kit already has. E.g. *"3. 'initiative' recurs across 5 notes with an
  internal/external split — pin this? (y/n)"*. On **yes**, the definition moves into
  `vocabulary.md` exactly like "pin this" / "make this golden" works today. `distill` never encodes
  silently.

### 3.4 The enum-vs-entity distinction (the named failure mode)

The vocabulary records that *"internal | external"* are **values of a `scope` phrase on
`kind: initiative`** — **not** two phantom `kind:` entities.

| Correct | Drift to prevent |
| --- | --- |
| note → `kind: initiative`; "internal" is a scope phrase in the body | `kind: internal-initiative` / `kind: external-initiative` — two phantom types for one concept |

Enum **values are never declared** — not to ourselves (no `## Observed` table) and not to Duo (§8);
they are read from usage by both sides.

### 3.5 Demotion, revision & the off-vocabulary flag (suggest-only)

Two **distinct** signals — do not conflate them:

| Signal | Definition | `distill` response |
| --- | --- | --- |
| **off-vocabulary** | a `kind:` value used in notes that the vocabulary prose does not mention | numbered item proposing alignment or encoding |
| **contradiction** | newer usage conflicts with what the prose asserts (e.g. prose says scope is internal/external, but notes consistently use a third value) | numbered item proposing the prose be revised |

- Both are **flagged, never auto-applied.** Golden/locked content is **never trimmed** — the kit's
  iron rule, extended in both directions.
- **Retiring an encoded concept** (encoded → gone) has no automatic path: it is a **deliberate
  golden edit** by the human (§4), exactly like editing any pinned definition. The ladder is not a
  one-way ratchet, but exit from `encoded` is always human-driven.
- **This costs a managed edit.** The shipped `distill` reviews `knowledge/` notes + `index.md` +
  `PROJECT.md` and is told *"Never touch `knowledge/golden/`"* — it does **not read** golden content
  today. Producing either signal requires `distill` to *read* `vocabulary.md`, an edit to
  `distill/SKILL.md` (a managed file). It is therefore **P2-gated** (§11), not free.

### 3.6 What actually reduces re-derivation (honest scope)

| Mechanism | Effect | Claim |
| --- | --- | --- |
| Encoded golden vocabulary note (§3.1) | Genuinely reduces it **at query time** | `query` loads `knowledge/golden/` as an authoritative constraint, so a query resolves `initiative` against the definition once. **The only honest reduction — and query-path only (§3.7).** |
| Live "observed" rung (§3.3) | **Increases** per-pass work | A conformance cost, not a saving. |
| Off-vocabulary / contradiction flags (§3.5) | Makes consistent resolution *available and authoritative when read* | Best-effort; not a gate. |

### 3.7 Resolution timing — query-path guarantee only

Cost reduction depends on resolving `kind:` against `vocabulary.md` **at the moment of resolution**.
Ground truth on the shipped skills:

| Skill | Reads `knowledge/golden/` today? | Guarantee |
| --- | --- | --- |
| `query` | **Yes** — loads golden as authoritative constraints (after PROJECT.md + index.md) | **Holds.** Query-time resolution is genuine and shippable today. |
| `ingest` | **No** — reads `PROJECT.md` + `knowledge/index.md` only | **Does not hold today.** When a note's `kind:` is chosen, the vocabulary is not in context. |
| `distill` | **No** — reviews notes + `index.md` + `PROJECT.md`; told "Never touch golden" | **Does not hold today.** The §3.5 flags require a managed edit to read golden (P2). |

**Therefore the spine ships only the query-path guarantee.** This spec does **not** assert
ingest-time resolution. Two paths to ingest-time resolution exist, both deferred and gated:

- **(a)** Scope the guarantee to `query` (the default). Ingest-time drift is caught after the fact
  by the §3.5 flags during `distill`.
- **(b)** Amend `ingest/SKILL.md` to read `vocabulary.md` first. This edits a **managed file** and
  is a `dist/`-shaping change — **not authorized *here*** (it is scheduled as the gated, optional
  P4 in §11, requiring its own §8 go/no-go).

---

## 4. Note + frontmatter contract

- **`kind:` stays the frozen three-line contract** — exactly `summary:` + `kind:` + `source:`. No
  rename to `type:`; no `provenance:`, `sources:` (plural), or `# Citations`.
- **Encoded type-names become the *values* `kind:` takes** — `kind: initiative`. A vocabulary buys
  the note a stable label, not a new field.
- **`type:` never appears on a note.** Its only permitted appearance in the kit is the reserved OKF
  index marker on `knowledge/index.md` (§6), and the index is not a note.
- **`id:` is preserve-only, never minted** (§9-D). A Duo-minted `id:` is carried untouched through
  every rewrite by OKF's preserve-unknown-keys rule; in a no-Duo clone it is inert.
- **A freshly-forked kit with zero encoded vocabulary is fully valid** — every note already carries
  `kind:`; the vocabulary note is an enhancement, not a precondition.

> **Round-trip consequence (stated, not hidden).** Because loopkit notes carry `kind:` and **not**
> `type:`, Duo — which types and files **only** on `type:` (D10/D19) — sees a loopkit note as
> **untyped**. Duo's process pass will propose adding `type:` (CriticMarkup) and a D19 folder move.
> loopkit does **not** claim Duo files its notes cleanly; the round-trip guarantee is scoped to
> **renders-on-GitHub + inert-`id:`-preservation** (§8).

---

## 5. Link rules at rest

| Rule | Form | Rationale |
| --- | --- | --- |
| Inter-note links are **relative markdown** | `[Display](./note.md)` | GitHub-safe from any vendored path; identical to Duo OKF at-rest form. |
| **No `[[wikilinks]]` persist** | rewritten to rel-md on resolve | Matches Duo D3. `[[Name]]` is **input-only**: the agent may *type* it as a stub gesture; it never survives to disk. **Invariant:** no commit may contain `[[...]]`; the rewrite runs before any write that lands in git (a `grep '\[\['` check in `distill`'s link review). |
| **No `/absolute` links** | forbidden | That is the root wiki, which a fork lacks. (The same assistant works in both repos — emitting `/absolute` out of habit is a real risk; T3 guards it.) |
| Broken links | tolerated | "Not-yet-written knowledge" (OKF) — a soft warning in `distill`, never a hard failure. **Caveat:** without Duo, an out-of-band move (Finder/git) leaves links broken until fixed by hand — there is no `relink` fallback (§7), so the "self-healing" value is Duo-only. |

---

## 6. New/changed files & the managed-vs-user split

| Path | New? | Side | Rule |
| --- | --- | --- | --- |
| `knowledge/golden/vocabulary.md` | **new** | **USER** | The encoded vocabulary. **NOT** in `managed_files`. `sync.sh` iterates only `managed_files` and **deletes nothing outside it** (verified) — so the user's vocabulary is never overwritten *or* removed. |
| `knowledge/golden/README.md` | exists | **MANAGED** | The managed-README trap: this README *is* managed; the `vocabulary.md` beside it is **not**. Same folder, opposite sides. |
| `knowledge/index.md` | exists | **USER** | Assistant-maintained; never in `managed_files`. Holds the OKF marker only when enabled (below). |
| `inbox/` | **new** | **USER** (empty folder, inert) | Capture target. Genuinely new — nothing in loopkit references it today. See the capture caveat below. |

**`loop.manifest.json` impact: none required.** No new path joins `managed_files`; the vocabulary
note and the OKF marker both live on **user** files.

**The OKF marker — opt-in, written by hand, never by `sync`.** The marker
(`okf_version: "0.1"` + `type: index`) belongs on `knowledge/index.md`, which is **user content**;
`sync.sh` cannot ship it without clobbering the user's catalog. Therefore:

- **It is opt-in, not a baseline.** A fresh non-Duo fork's `knowledge/index.md` **stays
  frontmatter-free, byte-identical to shipped** (the shipped file has no frontmatter).
- **It is never stamped during the §0 first-run interview** (four plain-language questions —
  goal / deliverable / golden / cadence). That interview must never mention `okf_version`, `type:`,
  schema, or "vault."
- The assistant writes it **only when** `which duo` succeeds **or** the user explicitly asks to make
  the folder a Duo OKF vault — framed in the user's language ("make this folder openable in Duo?"),
  never as a schema obligation.
- **Placement is load-bearing:** the marker must be the **first bytes of the file**, *above* the
  existing `# Knowledge base — index` H1 — GitHub renders YAML frontmatter as a table only at the
  very top with no preceding content; below the H1 it leaks as raw text (T13). Its no-Duo safety
  rests on *"inert frontmatter, ignored by anything that doesn't parse it,"* not on "renders as a
  table" (which is github.com-blob-view-specific).
- **The marker write must include the `<!-- duo:listing -->` fence** below it. `duo vault publish`
  regenerates only the body *after* that fence; without it, publish has no anchor and may overwrite
  the user's hand-maintained catalog (T12, T14b).

**Capture caveat (`inbox/`).** The §7 capture fallback ("assistant files an inbox drop on next
`ingest`") is **not implemented today**: `ingest` reads `PROJECT.md` + `index.md` only and has no
rule to look in `inbox/`. So `inbox/` is an empty inert folder now; making the fallback real
requires an `ingest/SKILL.md` edit (managed) and is **P-gated** (§11). Who creates `inbox/`: the
assistant, on first use — not `sync`, not the §0 interview.

---

## 7. Duo enhancements ↔ no-Duo fallbacks

The load-bearing test applies to every row: `which duo` failing breaks nothing.

| Capability | Duo accelerates | No-Duo fallback (assistant by hand) | Today? |
| --- | --- | --- | --- |
| Capture | `duo vault capture` → `inbox/` | User drops a file in `inbox/`; assistant files it on next `ingest` | **needs ingest edit (P-gated, §6)** |
| Corpus for resolution | `duo vault schema` (live corpus) | Read `vocabulary.md` + `index.md` first (query path, §3.7) | yes (query) |
| Observed-shape counting | `duo vault schema` reports observed shapes | `distill` reads notes live and counts (§3.3) | **needs distill edit (P2)** |
| Stub a typed entity | `duo vault stub <type> <name>` from `templates/<type>.md` | Assistant writes the note from the vocabulary definition | yes |
| Link-safe **move** | `duo vault mv` | Assistant rewrites rel-md links in the **same commit** as the move | yes |
| Link **repair** (out-of-band) | `duo vault relink` (auto on open) | **No fallback** — broken links sit until fixed by hand (§5 caveat) | n/a |
| Listings | `duo vault publish` regenerates `index.md` | Assistant keeps `knowledge/index.md` current by hand | yes |
| Promote a running-doc section | `duo vault promote` (D9) | Assistant splits the `##` section into a note by hand, leaves a rel-md link (loopkit `work/` already splits into section files) | yes |
| Work-list | `duo graph orphans` / `backlinks` | Assistant's manual `distill` review | yes |

**Accepted asymmetry:** `duo vault schema` also reports `aliases` and `templates`, which loopkit has
no notion of; by-hand resolution ignores aliases silently. Acknowledged, not closed.

---

## 8. Duo round-trip contract

When Duo is present it is **authoritative and live**: `duo vault schema` computes the corpus every
call; loopkit reads it and **persists nothing back**. The no-sidecar rule holds because we built our
side to the same rule.

**Round-trips losslessly:**

| Property | Status |
| --- | --- |
| Rel-md links at rest | Identical to Duo OKF at-rest form. |
| Renders on GitHub | Yes, with or without Duo — **pre-Duo-filing** (see below). |
| Unknown keys (e.g. Duo's `id:`) | Preserved on every `ingest`/`distill` rewrite — the kit's §8 note conventions carry an explicit *"keep frontmatter keys you didn't write"* rule (added in PR #6; the kit does **not** silently inherit the root repo's preserve-keys rule). T11. |
| OKF marker (when enabled) | `duo vault publish` preserves the marker frontmatter byte-identically and regenerates only the body after `<!-- duo:listing -->`. |

**Does NOT round-trip cleanly — stated, not glossed:**

- **Typing / filing.** Duo types and files **only** on `type:` (D10 HARD; D19; `templates/<type>.md`;
  `duo vault schema`/`stub`/`publish` all key on `type:`). A loopkit note carries `kind:`, so Duo's
  **P8 process pass sees it as untyped+unfiled** and proposes (suggest-only) adding `type:` and a
  D19 move. If accepted, the note carries **both** `kind: initiative` and `type: initiative` and is
  **relocated** into a D19 folder. **Consequence for GitHub rendering:** a D19 move changes the
  note's path, so its inbound rel-md links **break** unless Duo also runs `mv`/`relink`. The
  *renders-on-GitHub* guarantee therefore holds **pre-Duo-filing**; post-filing link integrity
  depends on Duo's own `mv`/`relink`, not on loopkit.
- **Prose vocabulary is invisible to Duo's corpus.** Duo declares types **only** via
  `templates/<type>.md` files; it cannot read `vocabulary.md` as a type declaration. loopkit's
  `ingest`/`distill` write flat notes — they never write `templates/<type>.md`, never set D19 meta
  keys (`folder:` / `filingParent:` / `folderNote:`), and §0 forbids the typed grid that would
  encode them. **So the encoded vocabulary is prose Duo's corpus never learns.** This spec makes
  **no** "maps onto Duo's declared half" claim. (A future option: have the encode step also write a
  minimal `templates/<type>.md` — but that reintroduces a declared-schema artifact §0 rejects, so
  it is **not adopted here**.)
- **Asymmetric link self-healing.** A loopkit note is **id-less** until Duo mints one (D10 HARD).
  `duo vault relink` resolves by `id:` first, then slug/basename. An id-less loopkit note can only
  hit the **slug fallback**, which Duo reports as ambiguous and never guesses. So loopkit notes get
  **strictly weaker** self-healing than native Duo notes, and the loopkit→Duo leg requires Duo to
  **mutate** the note (add `id:`). The round-trip is **not lossless-symmetric**; it is preserve-only
  with Duo-side healing (§9-D).
- **No-marker case.** If the user never enabled the OKF marker, the folder is **not an OKF vault** to
  Duo, and `duo vault publish` (OKF-mode-gated) **does not run** on it. A Duo user who opens an
  un-marked fork gets capture/search but not OKF publish/typed-filing until they opt in (§6). State
  this to the user rather than letting publish appear broken.

---

## 9. Decisions A–D (resolved)

| # | Decision | Resolution | Rationale |
| --- | --- | --- | --- |
| **A** | `kind:` vs `type:` | **Keep `kind:`; do NOT rename.** Encoded type-names become `kind:` **values**; `type:` appears only as the reserved index marker, never on a note. | The frozen contract wins (§4). This **overrides** the `loopkit-on-duo.md` Decision-A *recommendation* to introduce `type:`, on purpose. The cost is accepted and stated: Duo re-types/re-files notes each pass (§8). Honest round-trip claim = renders-on-GitHub + inert-`id:` only. |
| **B** | Vault root | **`knowledge/`.** | Keeps `work/`, `scripts/`, skills out of the graph; the marker lives at `knowledge/index.md`. |
| **C** | Ship the OKF marker by default? | **No — opt-in only**, Duo-detected or user-asked; never by `sync`, never during §0; placed as the file's first bytes with the listing fence (§6). | Default-shipping it stamps a schema/version header onto every fork (incl. the majority that never run Duo) and injects a non-optional first-run step — the over-formalization this design forbids. Fresh non-Duo forks stay frontmatter-free. |
| **D** | `id:` minting | **Preserve only, never mint.** | No ceremony without the host; the kit's own preserve-unknown-keys rule (§8 note conventions, added in PR #6 — not inherited from the root repo) carries a Duo-minted `id:` untouched in a no-Duo clone. **Acknowledged asymmetry (§8):** loopkit→Duo notes are id-less until Duo heals them; `relink` falls back to slug and reports ambiguity. Relaxing D (minting for Duo-bound vaults) is a deferred, §8-gated option — **not adopted here.** |

---

## 10. Acceptance tests

Concrete, checkable assertions. Each must pass before any `dist/` promotion.

| # | Guarantee | Assertion |
| --- | --- | --- |
| **T1** | never-fails-without-Duo | With `which duo` non-zero, `ingest`, `query`, `distill` each complete end-to-end; no skill invokes a `duo` verb without a by-hand fallback (§7). |
| **T2** | never-fails-without-Duo | No kit file requires a `duo` binary; `loop.manifest.json` adds no `duo` requirement. |
| **T3** | renders-on-GitHub | Every inter-note link is `./relative` rel-md; **zero** `[[wikilinks]]` and **zero** `/absolute` links persist after any `ingest`/`distill`/`query`. |
| **T4** | renders-on-GitHub | `knowledge/index.md` and notes render as readable markdown on GitHub from an arbitrary vendored sub-path. |
| **T5** | fresh-fork-stays-light | On a fresh fork, `knowledge/index.md` has **no frontmatter** (byte-identical to shipped); no marker until Duo-detect or user request. |
| **T6** | fresh-fork-stays-light | The §0 interview is the four plain-language questions only; it never mentions `okf_version`, `type:`, schema, or "vault." The kit is valid with **no** `vocabulary.md`. |
| **T7** | fresh-fork-stays-light | `managed_files` is unchanged: `vocabulary.md` and `knowledge/index.md` are **absent** from it. |
| **T8** | reduces-re-derivation (scoped) | A `query` touching an encoded concept resolves its `kind:` against `vocabulary.md` (golden is an authoritative constraint that wins on contradiction). Claimed for the **query path only**; no ingest-time claim. |
| **T9** | reduces-re-derivation (honest) | The "observed" rung is **never written to disk** (no count, no `observed in: N` line). No text claims the observed rung *reduces* re-derivation. |
| **T10** | reduces-re-derivation (best-effort) | The off-vocabulary / contradiction flags (§3.5) are suggest-only: `distill` may **flag**, but nothing rejects a note or blocks ingest. |
| **T11** | round-trips-with-Duo | A Duo-minted `id:` survives every `ingest`/`distill` rewrite untouched; loopkit never mints `id:`. |
| **T12** | round-trips-with-Duo | When the marker is present, a `duo vault publish` preserves the marker frontmatter byte-identically and rewrites only the body after `<!-- duo:listing -->`. |
| **T13** | renders-on-GitHub | When written, the marker is the **first bytes** of `knowledge/index.md`, above the H1 (else GitHub leaks the YAML as raw text). |
| **T14** | no-schema-by-the-back-door | `vocabulary.md` contains **no** `## Types` / `## Fields` / `## Observed` heading and no per-field/per-enum table. The marker write **includes** the `<!-- duo:listing -->` fence. |
| **T15** | keep-it-light | No user-facing prompt or `distill` output contains the rung words "emergent" / "observed" / "encoded" as status labels (§3.2, §7-rule). |
| **T16** | round-trips-with-Duo (honesty) | The spec contains **no** claim that Duo files loopkit notes cleanly, **no** claim that prose vocabulary maps onto Duo's declared half, and **no** claim of lossless-symmetric `id:`/relink. §8 states each divergence plainly. |

---

## 11. Phased rollout & the §8 promotion note

> **This whole spec is research input.** It validates *nothing* into `dist/loopkit`. Every phase
> below that touches `dist/loopkit` is gated, *per item*, by `CLAUDE.md` §8: validated · very-high
> confidence · **explicit human go/no-go** · shippable. "It seemed useful" is not authorization.

| Phase | Scope | Touches `dist/`? | Gate |
| --- | --- | --- | --- |
| **P0 — record** | This spec + the `wiki/` hypothesis pages. | No | None (research loop). |
| **P1 — golden vocabulary (user-side)** | Convention: the assistant writes `knowledge/golden/vocabulary.md` (user content) and resolves against it at **query** time. No skill edit, no manifest change. | No managed change | Confirm it reads cleanly with existing skills; surface to human. |
| **P2 — distill enhancements** | Add the live observed-count, the observed→encoded suggestion, and the off-vocabulary/contradiction flags to `distill/SKILL.md` (which must now **read** `vocabulary.md`). | **Yes** — `distill/SKILL.md` ∈ `managed_files` | §8 + explicit go/no-go. |
| **P3 — OKF marker, opt-in** | Assistant writes the marker (first-bytes + listing fence) to `knowledge/index.md` on Duo-detect/user request; document by-hand maintenance. | Possibly `CLAUDE.md`/`query` text (managed) | §8 + explicit go/no-go. |
| **P4 — ingest-time resolution (optional)** | Amend `ingest/SKILL.md` to read `vocabulary.md` first (and to scan `inbox/`), lifting resolution from query-only to both paths and making the capture fallback real. | **Yes** — `ingest/SKILL.md` ∈ `managed_files` | §8 + explicit go/no-go. Deferred; not implied by P1. |

**Build status (PR #6):** P0 ✓ (merged via PR #5) · P1 ✓ built · P2 ✓ built · P3 ✓ built ·
P4 ⏳ deferred. Details in §12.

---

## 12. As-built record (PR #6)

What actually shipped on branch `claude/loopkit-on-duo-build`, where it diverged from the design
above, and what is **not** complete. This section is the part to read to trust the rest as a record.
`main` stays v0.1.0 until [PR #6](https://github.com/dudgeon/loop-library/pull/6) merges.

### Phases

| Phase | Status | What landed (files) |
| --- | --- | --- |
| P1 — golden vocabulary, query-time | ✓ built | `CLAUDE.md` §4.1; `query/SKILL.md` step 1; `knowledge/golden/README.md` |
| P2 — distill reads vocabulary | ✓ built | `distill/SKILL.md` — read-only golden, suggest pinning (live count), off-vocabulary + contradiction flags, link hygiene |
| P3 — link convention + opt-in Duo | ✓ built | `CLAUDE.md` §8 (rel-md links; preserve-unknown-keys) + "Optional: open in Duo" appendix |
| release | ✓ | `loop.manifest.json` 0.1.0→0.2.0; `CHANGELOG.md`; `README.md`; `dist/REGISTRY.md` (marked *proposed*) |
| P4 — ingest-time resolution + `inbox/` scan | ⏳ deferred | not built; `ingest` unchanged (reads `PROJECT.md` + `index.md` only) |

### Acceptance tests (§10) — as built

| Test | Status | Note |
| --- | --- | --- |
| T2, T3, T5, T6, T7, T9, T14, T15 | ✓ verified | checked mechanically against the kit (no `duo` dep; no `[[ ]]`/`/absolute`; index frontmatter-free; §0 untouched; `managed_files` unchanged; live count not persisted; no schema grid + fence required; no rung words) |
| T8 | ✓ built | `query` resolves against `vocabulary.md`; **query-path only** by design |
| T10 | ✓ built | off-vocabulary + contradiction flags are **suggest-only**, by design |
| T11 | ✓ fixed | **the divergence** — preserve-unknown-keys rule added in PR #6 (see below) |
| T13, T14b | ✓ documented | marker rule (first bytes + `<!-- duo:listing -->` fence) stated in the Duo appendix; marker is opt-in, not shipped |
| T1, T4 | ◑ by construction | no-Duo completion / GitHub rendering follow from the above but were **not run live** in a real fork — confirm on dogfood |
| T12 | n/a (external) | `duo vault publish`'s byte-identical marker preservation is Duo's behavior; the kit only guarantees it writes the anchor fence |

### Divergences from the design

1. **T11 `id:` preservation — found in audit, fixed (PR #6).** §4/§8/§9-D assumed a Duo-minted `id:`
   survives rewrites via "OKF's preserve-unknown-keys rule." That rule is a **root-repo** guarantee;
   the vendored kit never carried it and never mentioned `id:`. As first built, T11 was **unbacked**.
   Fix: `CLAUDE.md` §8 now says *"keep frontmatter keys you didn't write."* Build now matches spec.
2. **§3.7 "distill doesn't read golden today" — superseded by P2, by design (not a contradiction).**
   That row is the *pre-build baseline* used to justify query-only resolution. P2 deliberately makes
   `distill` read `vocabulary.md`; the spec gated exactly that edit as P2 and the build performs it.
   Read §3.7 as "the baseline the build then advances," not as current state.

### Not complete (deferred or best-effort, on purpose)

- **P4 — ingest-time resolution + `inbox/` auto-scan.** `ingest` still reads only `PROJECT.md` +
  `index.md`. So resolution against the vocabulary is **query/distill-time only**, and Duo capture
  into `inbox/` is a **manual hand-off** (the assistant files it when pointed at it). §8-gated.
- **Vocabulary resolution is best-effort, not enforced (T10).** Nothing mechanically rejects an
  off-vocabulary `kind:`; `distill` flags it for the user. By design — loopkit ships no gate beyond
  the 3-line note contract.
- **Duo round-trip caveats (§8) are inherent, not bugs.** Duo re-types/re-files `kind:` notes as
  untyped; prose vocabulary is invisible to Duo's corpus; `id`-less notes get weaker `relink`. These
  follow from Decision A and are documented, not closed.

---

## Sources

This spec compiles from, and must stay consistent with:

- [Duo — OKF Note Vault](../wiki/sources/duo-2026-note-vault.md) — the vault's one-graph/two-serializer
  model, OKF-mode contract, verbs, no-sidecar rule, and the D-numbered decisions (D3/D8/D9/D10/D19/D20,
  P6/P8) cited throughout.
- [`/wiki/concepts/loopkit-on-duo.md`](../wiki/concepts/loopkit-on-duo.md) and
  [`/wiki/comparisons/duo-vault-vs-wiki.md`](../wiki/comparisons/duo-vault-vs-wiki.md) — the design
  and the substrate-vs-operating-model framing this spec makes normative.
- The shipped kit it extends — `dist/loopkit/CLAUDE.md`, `dist/loopkit/.claude/skills/{ingest,query,distill}/SKILL.md`,
  `dist/loopkit/loop.manifest.json`, `dist/loopkit/scripts/sync.sh` — verified against on
  2026-06-15 (the ground-truth audit behind the §3.7 timing table and the §6 `sync` claim).
- [Karpathy — "LLM Wiki"](../wiki/sources/karpathy-2026-llm-wiki.md) and
  [OKF Specification v0.1](../wiki/sources/google-2026-okf-spec.md) — the ingest/query/lint loop and
  the preserve-unknown-keys / graceful-degradation rules the design rests on.
