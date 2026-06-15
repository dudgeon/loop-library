# CLAUDE.md — Operating manual for the Loop Library

This file is the **control layer**. It is what makes you (an LLM agent) a *disciplined
maintainer of this knowledge base* rather than a generic chatbot. Read it fully before
ingesting a source, answering a query, or editing any file.

This repo is a **hybrid** of two ideas:

- **Andrej Karpathy's "LLM Wiki"** — the *operating model*: the agent compiles and
  continuously maintains a persistent, interlinked markdown wiki instead of re-deriving
  answers from raw chunks on every query. The bottleneck of any knowledge base is
  *bookkeeping*; that is exactly what the agent automates. Source:
  [`/sources/karpathy-2026-llm-wiki.md`](sources/karpathy-2026-llm-wiki.md).
- **Google's Open Knowledge Format (OKF v0.1)** — the *on-disk contract*: a portable
  bundle of markdown files with YAML frontmatter, one "concept" per file, identified by
  path, linked into a graph, navigable via reserved `index.md` / `log.md` files. Source:
  [`/sources/google-2026-okf-spec.md`](sources/google-2026-okf-spec.md).

> **One-line rule:** OKF is the contract; Karpathy is the operating model; provenance is
> the addition both parents lack.

**Purpose — two engines that feed each other:**

1. **Research loop (`wiki/`, Purpose 2)** — this OKF bundle, maintained by `ingest → query →
   lint`, accumulating the state of the art in loop construction and recursive improvement.
2. **Loop kits (`dist/`, Purpose 1)** — vendorable, self-syncing prototypes that let any task
   *begin by defining a loop, then running it*. Each kit carries `loop.manifest.json` +
   `scripts/sync.sh` (managed machinery updates; user content preserved). See
   [`dist/REGISTRY.md`](dist/REGISTRY.md).

Research improves the kits; vendored kits throw off usage that becomes new research sources.
Designs and candidate patterns are developed and recorded in the wiki **first** (hedged with
provenance — e.g. the
[goal-directed task loop](wiki/loops/agentic/goal-directed-task-loop.md), currently an
unvalidated hypothesis), and only **promoted** into `dist/` once they clear the bar in §8.

**Two ceremonies.** The **root/meta loop is alpha** — malleable; iterate freely. Its primitives
live in [`loop/`](loop/): `GOAL.md`, `HYPOTHESES.md`, `TASKS.md`. The **`dist/` layer is shipped
product** — deliberate and gated (§8). Working definition (itself a hypothesis, see
[`loop/HYPOTHESES.md`](loop/HYPOTHESES.md)) of a loop's **enduring primitives**: a **goal**, a
**work product** (possibly self-referential), and **tasks/sub-goals** — held by the root loop on
itself, and the candidate shape for what a `dist/` kit ships.

---

## 1. The three layers (ownership is mechanical, not just convention)

```
loop-library/
  CLAUDE.md          ← LAYER 3 (control)   you read this; it governs everything
  README.md          ←   human-facing overview
  loop/              ←   the ROOT (meta) loop's primitives: GOAL · HYPOTHESES · TASKS (alpha — malleable)
  .claude/skills/    ←   the core operations as skills: ingest · query · lint
  sources/           ← LAYER 1 (immutable) raw source mirrors. READ-ONLY to the agent.
  inbox/             ←   staging: raw drops awaiting human-approved ingest
  wiki/              ← LAYER 2 (compiled)  the OKF bundle (research loop / Purpose 2). You write here.
  dist/              ←   PURPOSE 1: SHIPPED loop kits — deliberate, high-confidence only (see §8)
  _meta/             ←   schema + taxonomy (the rules, written down)
  scripts/           ←   lint + conformance (the retro loop, operationalized)
```

**Ownership rules — these are hard rules, not suggestions:**

1. **Never edit anything under `sources/`.** It is the source of truth — the immutable
   record of what a source actually said. You may *read* it and *cite* it. You may create
   a new source mirror only as the explicit final step of an approved Ingest. You never
   rewrite or "improve" one.
2. **Nothing is auto-promoted from `inbox/`.** Material dropped in `inbox/` is raw and
   un-curated. It becomes a source (in `sources/`) and compiled knowledge (in `wiki/`)
   only after the human approves the ingest. When in doubt, ask.
3. **`wiki/` is yours to maintain.** Every compiled page (loops, concepts, comparisons,
   synthesis) lives here, and every one of them **must cite at least one source**.
4. **`_meta/` changes are co-evolved with the human.** The schema and taxonomy are the
   constitution; propose changes, don't make them unilaterally.
5. **`dist/` is shipped product — never write to it casually.** Adding, changing, or removing a
   kit in `dist/` is **shipping software**: it requires a validated pattern, very-high
   confidence, and an explicit human go/no-go. Notional or exploratory ideas live in `wiki/`
   (hedged with provenance) or as tasks — **never** in `dist/`. See §8.

---

## 2. The OKF bundle (`wiki/`)

`wiki/` is a self-contained, OKF-v0.1-conformant bundle. An OKF consumer should be pointed
at `wiki/`, not at the repo root. (The `sources/` raw layer sits outside the bundle; wiki
pages cite the in-bundle Source *concepts* at `/sources/<id>.md`, which in turn point at
the raw mirror via `raw_mirror:`.)

- **Every non-reserved `.md` file under `wiki/` is a "concept"** with a YAML frontmatter
  block whose **only required field is a non-empty `type`**.
- **Concept ID = path within the bundle, minus `.md`.** Identity *is* the path; there is no
  separate `id` field. `wiki/loops/automation/ingest-query-lint.md` → concept
  `loops/automation/ingest-query-lint`.
- **Reserved filenames** `index.md` and `log.md` are **not** concept docs and must not be
  used as such. They carry the meanings in §5.
- **Links are bundle-relative absolute paths** that begin with `/`, resolved from the
  `wiki/` root — e.g. `[ReAct](/loops/agentic/react.md)`. We do **not** use Obsidian
  `[[wikilinks]]`. A link asserts an (untyped) relationship; **state the relationship type
  in prose** near the link. Broken links are tolerated — they are "not-yet-written
  knowledge," not errors.
- **Frontmatter for what you query; body for what you read.** Keep the frontmatter small
  and OKF-shaped; put mechanism, failure modes, examples, and analysis in the body using
  structural markdown (headings, tables, fenced code).
- **Graceful degradation is mandatory:** tolerate missing optional fields, unknown `type`
  values, and missing index files; **preserve unknown frontmatter keys** on any rewrite.

The full per-page schema is in [`_meta/SPEC-loop.md`](_meta/SPEC-loop.md). The controlled
vocabularies (`type`, `loop_family`, tags) are in [`_meta/taxonomy.md`](_meta/taxonomy.md).

---

## 3. The maintenance loop: **Ingest → Query → Lint**

These are Karpathy's three core operations, implemented here as skills under
`.claude/skills/`. The loop is itself a loop — see
[`/loops/automation/ingest-query-lint.md`](wiki/loops/automation/ingest-query-lint.md).

### Ingest (`/ingest`) — a source → many pages
1. Confirm the source is approved (it's in `sources/` already, or the human OK'd a drop in
   `inbox/`). **Do not invent sources.**
2. Write/confirm the immutable mirror under `sources/<id>.md` (LAYER 1). Do this once.
3. Create or update the **Source concept** under `wiki/sources/<id>.md` (a digest +
   verbatim key excerpts + `resource:` canonical URL + `raw_mirror:` pointer).
4. Compile knowledge into `wiki/`: create/update the **loop**, **concept**, and
   **comparison** pages this source informs. One source typically touches several pages.
5. Update every relevant `index.md` (root + each affected directory).
6. Append a `log.md` entry (see §5 for format).
7. Every new/edited compiled page must: declare `type`, carry a one-sentence `summary:`,
   list its `sources:`, set `provenance:`, and include a `# Citations` section.

### Query (`/query`) — answer from the wiki, then file the answer back
1. Read [`wiki/index.md`](wiki/index.md) **first** — never blind-scan directories.
2. Drill into the relevant pages; traverse links one level at a time.
3. Answer **with citations** (bundle-relative links to the pages/sources used).
4. **Explorations compound:** if the answer is a genuinely new comparison, connection, or
   synthesis, file it back as a new `wiki/` concept page rather than leaving it in chat.
   Append a `query` entry to `log.md`.

### Lint (`/lint`) — periodic health check (the retro loop is the product)
Run [`scripts/lint.sh`](scripts/lint.sh) and [`scripts/conformance.sh`](scripts/conformance.sh),
then review for what a script can't catch:
- broken bundle-relative links; orphan pages (no inbound links); loops/concepts mentioned
  but not yet paged;
- frontmatter that's missing `type`, `summary`, `sources`, or a `# Citations` section;
- contradictions between a page and a *newer* source (flag, don't silently overwrite);
- pages drifting toward mostly `inferred`/`ambiguous` provenance (flag for grounding);
- stale `timestamp`s relative to the sources they cite.
Record findings as a `lint` entry in `log.md` and fix what's safe.

> **Vocabulary:** the shipped kit ([`dist/loopkit`](dist/loopkit/)) calls this same operation
> **`distill`** for end users; at the root it stays `lint` because it also runs OKF conformance —
> more than distilling notes. See [`/comparisons/loopkit-vs-root`](wiki/comparisons/loopkit-vs-root.md).

> **Optional, later:** a search tool over `wiki/` (the index is enough at moderate scale;
> add hybrid BM25/vector search — e.g. `qmd` — only when page count outgrows the index).

---

## 4. Provenance (the hybrid's load-bearing addition)

Neither parent format distinguishes *what the wiki knows* from *what it guessed* — the gap
that causes compounding hallucinations. So every compiled page declares:

- `provenance: extracted | inferred | ambiguous`
  - **extracted** — directly supported by a cited source.
  - **inferred** — your synthesis across sources; reasonable but not stated in any one.
  - **ambiguous** — sources disagree; the body must say how.
- `sources:` — bundle-relative links to the Source concepts the page compiles from
  (non-empty for every Loop/Concept/Comparison page).
- a `# Citations` section in the body — numbered `[1] [Title](url-or-/path)`.

When a page is mostly `inferred`, say so plainly in the body. Prefer flagging a gap over
filling it with confident guesswork.

---

## 5. Reserved files & log format

- **`index.md`** (root + each directory): progressive-disclosure catalog. Body is one or
  more `#`-headed sections, each a bullet list of `* [Title](/bundle/relative/path.md) —
  one-line description`. **No frontmatter**, *except* the bundle-root `wiki/index.md`,
  which carries the only allowed index frontmatter: `okf_version: "0.1"`.
- **`log.md`** (bundle root; per-directory optional): chronological, **newest-first**.
  Use ISO date section headings and grep-able, op-typed bullets:

  ```
  ## 2026-06-14
  - ingest | Karpathy "LLM Wiki" — created source concept + ingest-query-lint loop
  - lint   | first conformance pass — 0 errors
  ```

  Ops: `ingest`, `query`, `lint`, `supersede`. Grep recent activity with
  `grep -nE '^- (ingest|query|lint|supersede)' wiki/log.md`.

---

## 6. Conformance (strict mode — the human chose this)

A change is **not done** until conformance passes. CI / pre-merge checks:

1. Every non-reserved `.md` under `wiki/` has a parseable YAML frontmatter block with a
   **non-empty `type`**.
2. The bundle-root `wiki/index.md` declares `okf_version: "0.1"`.
3. Every page with `type` in `{Loop, Pattern, Anti-pattern, Concept, Comparison}` has a
   **non-empty `sources:`** and a `# Citations` section.

`scripts/conformance.sh` enforces 1–3; `scripts/lint.sh` covers the softer checks.

---

## 7. Naming & style

- Files: lowercase, hyphenated slugs. Sources: `<author-or-org>-<year>-<slug>.md`.
- Keep `wiki/index.md` within one context window; if it outgrows that, split by directory.
- Favor tables and lists over prose in bodies.
- Write the one-sentence `summary:` at creation time so queries can preview without opening
  the file.
- Co-evolve this file: when a convention stabilizes, write it down here.

---

## 8. Shipping to `dist/` is deliberate (treat it like shipping software)

`dist/` holds **shipped product**. The default is **do not ship**. Exploration and design
happen in `wiki/` (as hedged hypotheses) and in the task register — not in `dist/`.

**Promotion bar (research → `dist/`) — all must hold:**
1. **Validated**, not notional — grounded in cited sources and/or real use, recorded in `wiki/`.
2. **Confidence: very-high** — tracked on the pattern's task in the parent loop.
3. **Deliberate human go/no-go** — an explicit decision, never a side effect of building.
4. **Shippable** — semver + CHANGELOG + `loop.manifest.json` + `scripts/sync.sh` + README, with
   the managed-vs-user file split.

**Hard rules:**
- Never create, edit, or delete anything under `dist/` without an explicit human decision for
  *that change*. "It seemed useful" is not authorization.
- A notional idea the human floats is an input to research, **not** a shipping instruction.
  Default to capturing it as a task/hypothesis and confirming before any `dist/` change.
- Promotion is its own step (a future `/promote`), separate from `/ingest` and `/query`.

See [`dist/REGISTRY.md`](dist/REGISTRY.md) for the live bar and what (if anything) is shipped.
