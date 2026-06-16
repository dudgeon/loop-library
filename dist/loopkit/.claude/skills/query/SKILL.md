---
name: query
description: Put this project's graph to work — answer a grounded question, or draft and advance a deliverable in work/, using the typed notes, their links, and golden context, and file genuinely new conclusions back. Use when the user asks something the project should know, or asks to move a deliverable forward.
---

# query

Use the graph toward the goal, and file useful results back. Read `CLAUDE.md` first.

## Steps
1. Read `PROJECT.md` and `knowledge/index.md` first — don't blind-scan. Pull the relevant notes and
   **follow their links** one hop at a time; the edges are the point. Load `knowledge/golden/` —
   definitions — plus the `knowledge/templates/` types — as authoritative constraints, and **resolve
   names against them** so the same concept isn't reinvented.
2. Answer the question, or advance a deliverable in `work/`, citing the notes you used (link to them).
   Treat golden context as hard constraints — flag anything that conflicts with it rather than
   overriding it.
3. Respect locked work: don't rewrite a `locked: true` file without asking. Advance only the unlocked
   parts.
4. **File back:** when a genuinely new conclusion or connection emerges, add it as a typed note, link
   it into the graph, and update `knowledge/index.md` so it compounds for next time.
5. If the graph can't answer well, say so plainly and suggest what to ingest next — don't fabricate.

## Don'ts
Don't answer from memory when the graph should know. Don't overwrite golden or locked files. Don't drop
a frontmatter key you didn't write. Don't make a claim the notes don't support without flagging it.
