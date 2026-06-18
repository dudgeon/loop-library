---
type: Concept
title: Loopkit on Duo — progressive enhancement by an optional host
summary: A design (unvalidated, not shipped) for making loopkit run better inside Duo as an OKF Note Vault while a Duo-less clone never fails — by adopting only compatibility moves that are inert or render-clean without Duo, and treating Duo as a detected, optional bookkeeping accelerator.
tags: [okf, knowledge-base, ingest, query, lint, agent-harness, idempotency]
timestamp: 2026-06-15T00:00:00Z
provenance: inferred
confidence: 0.5
sources: [/sources/google-2026-okf-spec.md, /sources/karpathy-2026-llm-wiki.md, /sources/duo-2026-note-vault.md]
related: [/comparisons/duo-vault-vs-wiki.md, /comparisons/loopkit-vs-root.md, /loops/automation/ingest-query-lint.md]
---

> **Status: design, unvalidated, NOT shipped.** This is a research-loop hypothesis about how the
> shipped `dist/loopkit` *could* evolve. It is **not** authorization to change `dist/` — that needs
> the §8 promotion bar + an explicit go/no-go. The Duo-side facts are grounded in the ingested
> [Duo Note Vault source](/sources/duo-2026-note-vault.md); the design itself stays `inferred`.

> **Direction changed (2026-06-16) → [`_meta/SPEC-loopkit-entity-foundation.md`](../../_meta/SPEC-loopkit-entity-foundation.md).**
> This page (and the now-superseded prose-vocabulary spec) under-read the user's goal. The goal is a
> **typed-entity graph with resolution** — and loopkit should be the **foundation the next
> work-agent-harness is built *on*, not *in*.** So the design now **adopts `type:` typed entities**
> (reversing the old Decision A), makes **payload-bearing rel-md edges** and **entity resolution**
> first-class, and replaces the prose `vocabulary.md` with an **emergent→encoded taxonomy** (types
> written down as templates when earned). The entity-foundation spec governs; this page is kept for
> the progressive-enhancement framing it still gets right (GitHub-clean OKF, no-Duo degradation).

## The principle: progressive enhancement

Loopkit is a **forkable, self-contained** OKF-flavored project: it must run with nothing but Claude
Code skills + plain files, and render cleanly on GitHub [2]. The goal is to let a Duo user get
*more* from the same kit without making the kit *depend* on Duo. Borrowed verbatim from web
progressive enhancement:

> **Baseline works everywhere; the host only adds.** Every Duo-facing move must be either
> **inert-when-absent** (an unused frontmatter key, an empty folder) or have a **no-Duo fallback**
> (the assistant does by hand what a `duo` verb would automate). **Nothing in loopkit may require a
> `duo` binary.** If `which duo` fails, every operation still completes.

This is the load-bearing test for every item below: *does a Duo-less clone still work and still
render on GitHub?* If no, it doesn't ship.

## Compatibility moves that cost nothing without Duo

These make a loopkit fork a *latent* Duo OKF vault while staying plain markdown for everyone else.

| Move | Why it helps in Duo | Why it's safe without Duo |
| --- | --- | --- |
| **Relative markdown links** `[Display](./note.md)` between notes | exactly Duo OKF's at-rest link form; never `[[wikilinks]]` | renders on GitHub from any vendored path (unlike the root wiki's `/absolute` links, which assume a bundle root) |
| **OKF marker** on the knowledge-root `index.md` (`okf_version:`, `type: index`) | makes the folder a one-click Duo OKF vault; `duo vault publish` can own the listing | inert frontmatter, ignored by anything that doesn't parse it. *Spec refinements:* **opt-in, not default**, and must be the file's **first bytes** + carry the `<!-- duo:listing -->` fence |
| **An `inbox/` folder** in the knowledge base | `⇧⌘N` quick-capture lands notes here; same processing work-list | just a folder; manual drops work identically (the spec notes `ingest` must learn to scan it — P-gated) |
| **Preserve unknown frontmatter keys** (e.g. Duo's `id:`) on every distill/ingest rewrite | lets Duo's stable-`id` `relink`/`mv` self-heal moved links | a key the kit ignores; OKF mandates graceful degradation on unknown keys [2] |
| ~~**`type:` as the note field**~~ — **rejected by the spec (Decision A): keep `kind:`.** Encoded type-names become `kind:` *values* (`kind: initiative`). | (Duo would type/file on `type:`; the spec accepts that loopkit notes read as untyped to Duo rather than break the frozen contract) | the note contract stays the frozen `summary:`/`kind:`/`source:` |

## Enhancements that light up only with Duo

Same *outputs*, automated bookkeeping — Karpathy's bottleneck handed to a tool that solved it [1]:

- **Capture → inbox.** `⇧⌘N` / `duo vault capture` drops atomic inbox notes the kit's `ingest` then
  files. Fallback: the user drops a file in `inbox/` and the assistant files it.
- **Listings via `duo vault publish`.** Regenerates `knowledge/index.md` (+ a `log.md`) from the
  corpus. Fallback: the assistant keeps `index.md` current by hand (already the kit's rule).
- **Link-safe moves via `duo vault mv` / `relink`.** Moves rewrite inbound links (or self-heal by
  `id:`). Fallback: the assistant rewrites links in the same commit, as it does today.
- **Corpus via `duo vault schema`** as the resolution table for `query`/`ingest`. Fallback: read
  `knowledge/index.md` first, as the kit already does.
- **Work-list via `duo graph orphans` / `backlinks`** feeding `distill`. Fallback: the assistant's
  manual lint review.

## The Duo-user workflow (the target experience)

1. **Fork** loopkit on GitHub; `git clone` locally.
2. **Open** the folder in Duo; **set the knowledge root as the default OKF vault** (its `index.md`
   carries the `okf_version` marker, so Duo recognizes it).
3. **Capture** with `⇧⌘N` → notes land in loopkit's `inbox/`.
4. **`/ingest`** (loopkit skill) files inbox notes into `knowledge/` with relative-md links + types;
   or run Duo's "process my vault" pass — same work-list.
5. **`/query`, `/distill`** operate on the same knowledge base; Duo's verbs accelerate (publish
   listings, `mv` for safe moves, `schema` for the corpus).
6. **Push to GitHub** → renders cleanly: relative links resolve, no `[[wikilinks]]`, frontmatter
   inert. A Duo-less collaborator clones the same repo and every skill still runs.

## Decisions A–D — resolved in the spec

These were open questions here; [`_meta/SPEC-loopkit-on-duo.md`](../../_meta/SPEC-loopkit-on-duo.md)
§9 resolves them (each remains §8-gated before any `dist/` change):

- **A. `kind:` vs `type:`** → **keep `kind:`; do NOT rename** (overrides this page's earlier
  recommendation). Encoded type-names become `kind:` *values*; the frozen 3-line contract wins, and
  the spec accepts the cost (Duo reads loopkit notes as untyped) plainly.
- **B. Vault root** → **`knowledge/`** (keeps `work/`/`scripts/`/skills out of the graph).
- **C. Ship the OKF marker by default?** → **No — opt-in only** (Duo-detected or user-asked);
  default-shipping it would tax every non-Duo fork. First-bytes + listing-fence placement required.
- **D. `id:` minting** → **preserve only, never mint**; the spec acknowledges the resulting
  asymmetry (loopkit notes are id-less until Duo heals them; `relink` falls back to slug).

The spec also adds the **emergent → observed → encoded** vocabulary lifecycle, a **query-path-only**
re-derivation guarantee, and 16 acceptance tests. It is a **golden candidate**, not shipped.

# Citations
[1] [Karpathy — "LLM Wiki"](/sources/karpathy-2026-llm-wiki.md) — the bookkeeping the optional host
    (Duo) would automate is exactly the bottleneck the ingest/query/lint loop targets.
[2] [OKF Specification v0.1](/sources/google-2026-okf-spec.md) — the self-contained-bundle contract,
    relative-link form, and the graceful-degradation-on-unknown-keys rule that make the inert
    compatibility moves safe.
[3] [Duo — OKF Note Vault](/sources/duo-2026-note-vault.md) — the verb behavior (capture, publish,
    mv/relink, schema corpus, templates/filing rules) and the OKF-mode at-rest contract cited above.
    Ingested 2026-06-15 (ENH-208 · ENH-216).
