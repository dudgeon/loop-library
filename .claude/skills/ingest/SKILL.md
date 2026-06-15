---
name: ingest
description: Ingest a source into the Loop Library — read it, mirror it immutably, write its Source concept, and compile it into the wiki (loops/concepts/comparisons), updating indexes and the log. Use when the user adds a source (a paper, post, doc, transcript) or drops a file in inbox/ and wants it folded into the knowledge base.
---

# Ingest

Karpathy's first operation: a source → many compiled pages. The bottleneck is bookkeeping;
your job is to do all of it. Read [`CLAUDE.md`](../../../CLAUDE.md) §3 and the schema in
[`_meta/SPEC-loop.md`](../../../_meta/SPEC-loop.md) first.

## Preconditions
- The source must be **approved**: already in `sources/`, or the human OK'd a file in
  `inbox/`. **Never invent a source.** If it's only in `inbox/`, confirm before promoting.

## Steps
1. **Read** the source fully from `sources/<id>.md` (or the approved `inbox/` file).
2. **Discuss** the key takeaways with the human; ask what to emphasize. Ingest one source
   at a time and stay involved unless told to batch.
3. **Immutable mirror** — ensure `sources/<id>.md` exists (canonical name
   `<author-or-org>-<year>-<slug>.md`). If you just promoted it from `inbox/`, move it now.
   **Never edit a mirror after creation.**
4. **Source concept** — create/update `wiki/sources/<id>.md` with `type: Source`,
   `resource:` (canonical URL), `raw_mirror: ../sources/<id>.md`, `authors:`, a one-paragraph
   digest, `# Key points`, `# Notable excerpts` (short verbatim quotes), `# Compiled into`.
5. **Compile** into `wiki/`: create or update the **Loop**, **Concept**, and **Comparison**
   pages this source informs. One source typically touches several pages. Each compiled page
   must declare `type`, `summary:`, `sources:` (link back to `/sources/<id>.md`),
   `provenance:`, and a `# Citations` section. Tag each claim's basis honestly
   (extracted vs inferred).
6. **Indexes** — update `wiki/index.md` and each affected directory `index.md`.
7. **Log** — append a newest-first entry to `wiki/log.md`:
   `- ingest | <Source title> — <what changed>`.
8. **Verify** — run `scripts/conformance.sh` (must pass) and `scripts/lint.sh` (review
   warnings). A change isn't done until conformance is green.

## Don'ts
- Don't auto-promote from `inbox/` without approval. Don't edit `sources/`. Don't write a
  compiled page without at least one citation. Don't fill gaps with confident guesses —
  mark them `inferred` or flag them.
