---
name: query
description: Put this project's graph to work toward the deliverable — answer a grounded question, advance a work/ deliverable with citations, run gap analysis ("what's missing for this?"), or read the task and reading-queue views — and file genuinely new conclusions back. Use when the user asks something the brain should know, asks to move a deliverable forward, or asks what's open or unprocessed.
---

# query

Use the graph toward the work product, and file useful results back. Read `CLAUDE.md` first.

## Steps
1. **Start from the index.** Read `PROJECT.md` (goal, work products, `task_policy:`) and
   `knowledge/index.md` first — don't blind-scan. Pull the relevant notes and **follow their links**
   one hop at a time; the edges are the point. Load `knowledge/golden/` as authoritative constraints,
   and read `knowledge/templates/` (the types) to **resolve names against them** so the same concept
   isn't reinvented.
2. **Answer, or advance the deliverable.** Answer the question, or advance an unlocked deliverable in
   `work/`, **citing the notes you used** (link to them). Treat golden as hard constraints — flag a
   conflict rather than overriding it. Don't rewrite a `locked: true` file without asking.
3. **Gap analysis (when asked "what's missing?").** Read the target deliverable in `work/` and the
   graph, and surface what the deliverable still needs and what to **ingest** next to fill it. Propose;
   don't fabricate to fill the hole.
4. **Read the views (don't regenerate them here).** For "what's unprocessed?" read the reading-queue
   `index-view`; for "what's open under initiative Y / requested by Z?" traverse the `task` nodes and
   their `parent`/`requested_by` edges. (Regenerating a view is `distill`'s job, §12 / §8 — `query`
   only reads.)
5. **File back.** When a genuinely new conclusion or connection emerges, add it as a typed note,
   resolve and link it into the graph, and update `knowledge/index.md` so it compounds next time.
6. **Be honest about gaps.** If the graph can't answer well, say so plainly and suggest what to ingest
   — don't fabricate.

## Don'ts
Don't answer from memory when the graph should know. Don't regenerate a timeline or index-view here
(that's distill). Don't overwrite golden or locked files. Don't drop a frontmatter key you didn't
write. Don't make a claim the notes don't support without flagging it.
