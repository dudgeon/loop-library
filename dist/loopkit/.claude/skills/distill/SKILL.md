---
name: distill
description: Keep this project's graph lean and trustworthy — merge duplicates, retire stale notes, resolve contradictions, fix links, resolve entities and flag type drift, and regenerate stamped views. Suggest-only; asks before deleting. Use periodically, before an important piece of work, or when the graph feels noisy. (This is loopkit's name for Karpathy's "lint".)
---

# distill

Keep the graph sharp — the cleanup that stops it from bloating or drifting. Read `CLAUDE.md` first.

## Steps
1. Review `knowledge/` (notes + `index.md`) and `PROJECT.md` (what's golden, what's locked). **Read**
   `knowledge/golden/` — including the `types/` notes — for context (you may read golden, never edit
   it).
2. Propose a **numbered list** of changes, each with a reason:
   - merge duplicates; retire stale or contradicted notes; resolve contradictions (golden wins — flag,
     don't silently overwrite);
   - **link hygiene** — fix broken links; rewrite any stray `[[wikilink]]` to relative markdown
     `[label](./note.md)`; reject any absolute `/path`;
   - **resolve entities** (`CLAUDE.md` §6) — turn vague references into canonical notes, here as well as
     at ingest; when a vault is present, defer to `duo vault schema`;
   - **type drift** — if a note's `type:` isn't among the types written down in `golden/types/`, or a
     recurring type isn't written down yet, *suggest* aligning it or pinning the type (the user pins —
     you never write golden yourself);
   - **edges on split notes** — if a note was decomposed, check each child kept its source/attribution
     edge;
   - flag any `work/` deliverable that has drifted from the notes it cites.
3. **Regenerate stamped views** (`CLAUDE.md` §8): any `type: index-view` note is rebuilt from the
   current graph and re-stamped — never hand-edited.
4. **Get the user's approval before deleting anything.** Apply only what's approved. Prefer tightening
   over erasing; never delete to hit a size target. **Preserve frontmatter keys you don't recognize**
   on every rewrite.
5. Never touch `knowledge/golden/` or any `locked: true` file. Work in git so every change is a
   reviewable diff.

## Don'ts
Don't delete without approval. Don't trim golden or locked content. Don't drop a key you didn't write.
Don't resolve a contradiction by guessing — surface it when it's not clear-cut.
