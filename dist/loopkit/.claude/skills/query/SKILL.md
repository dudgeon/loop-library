---
name: query
description: Put this project's knowledge base to work — answer a grounded question, or draft and advance a deliverable in work/, using the accumulated notes and golden context, and file genuinely new conclusions back. Use when the user asks something the project should know, or asks to move a deliverable forward.
---

# query

Use the knowledge base toward the goal, and file useful results back. Read `CLAUDE.md` first.

## Steps
1. Read `PROJECT.md` and `knowledge/index.md` first — don't blind-scan. Pull the relevant notes,
   and load `knowledge/golden/` as authoritative constraints.
2. Answer the question, or advance a deliverable in `work/`, citing the notes you used. Treat golden
   context as hard constraints — flag anything that conflicts with it rather than overriding it.
3. Respect locked work: don't rewrite a `locked: true` file without asking. Advance only the
   unlocked parts.
4. File back: when a genuinely new conclusion or connection emerges, add it as a note (and update
   `knowledge/index.md`) so it compounds for next time.
5. If the knowledge base can't answer well, say so plainly and suggest what to ingest next — don't
   fabricate an answer.

## Don'ts
Don't answer from memory when the knowledge base should know. Don't overwrite golden or locked
files. Don't make a claim the notes don't support without flagging it.
