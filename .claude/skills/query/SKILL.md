---
name: query
description: Answer a question against the Loop Library wiki — read the index first, drill into relevant pages, synthesize with citations, and file genuinely new findings back as wiki pages. Use when the user asks a question about loops, patterns, or concepts that the knowledge base should answer.
---

# Query

Karpathy's second operation: answer from the compiled wiki, then **file good answers back** so explorations compound. Read `CLAUDE.md` §3 first.

## Steps

1. **Index first.** Read `wiki/index.md` to find candidate pages. Never blind-scan directories.
2. **Drill in.** Open the relevant pages; follow `related:` and in-body `/links` one level at a time to traverse the graph.
3. **Synthesize with citations.** Answer using bundle-relative links to the pages and `/sources/` concepts you used. Distinguish what the wiki *knows* (extracted) from what you're *inferring* — don't present synthesis as established fact.
4. **Pick an output form** that fits: prose, a comparison table, a checklist. (Slide/chart outputs are possible but rarely needed here.)
5. **File it back.** If the answer is a genuinely new comparison, connection, or synthesis, write it as a new `wiki/` page (`type: Comparison` / `Concept` / `Synthesis`) with full frontmatter + `# Citations`, update the relevant `index.md`, and append a `query` entry to `wiki/log.md`: `- query | <question> — filed as /path.md`.
6. If you filed a page, run `scripts/conformance.sh`.

## Gaps

If the wiki can't answer, say so plainly and propose the source(s) to ingest next — don't fabricate. A missing page is "not-yet-written knowledge," not an error.

When a follow-up needs the user to choose — which output form, which of several readings to pursue, whether to file a new page — ask with the structured **AskUserQuestion** prompt (concrete options), not a free-text question.