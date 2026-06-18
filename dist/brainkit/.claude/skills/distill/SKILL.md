---
name: distill
description: Keep this project's graph lean and trustworthy — merge duplicates, retire stale notes (respecting task hierarchy), resolve contradictions, fix links, resolve entities, flag type drift, re-derive the per-entity timelines, regenerate the index-views, and surface stale tasks. Suggest-only; asks before deleting. Use periodically, before an important piece of work, or when the graph feels noisy. (brainkit's name for Karpathy's "lint".)
---

# distill

Keep the graph sharp — the cleanup that stops it bloating or drifting. Read `CLAUDE.md` first.
**Suggest-only:** propose a numbered list, get approval before deleting, work in git.

## Steps
1. **Review.** `knowledge/` (notes + `index.md`) and `PROJECT.md` (golden, locked, `task_policy:`).
   **Read** `knowledge/golden/` for context (read, never edit) and `knowledge/templates/` (the types)
   to check notes against — you may *propose* a type change here too.
2. **Propose a numbered list**, each with a reason:
   - merge duplicates; retire stale or contradicted notes; resolve contradictions (golden wins — flag,
     don't silently overwrite);
   - **task integrity (§9):** a `task` with **open children is not retireable** — re-parent the
     children to the grandparent/initiative first; refuse/repair a `parent` edge that closes a cycle;
     surface **stale** tasks (`open` past `due:`, or `open` with no linked-note activity in a long
     while);
   - **link hygiene** — fix broken links; rewrite any stray `[[wikilink]]` to `[label](./note.md)`;
     reject any absolute `/path`;
   - **resolve entities (§6)** — vague reference → canonical note, here as well as at ingest;
     vault-first when present;
   - **type drift** — a `type:` not among the written-down types, or a recurring type not yet written
     down → *suggest* aligning or pinning it (the user pins);
   - **edges on split notes** — each child kept its source/attribution edge;
   - flag any `work/` deliverable that has drifted from the notes it cites.
3. **Re-derive timelines (§8).** For each `timeline: true` entity, rebuild the fenced
   `<!-- BEGIN generated:timeline -->`…`<!-- END … -->` region from the graph and re-stamp it. **Detect
   any hand-edit inside the fence** and surface it (suggest-only) so the fact is moved to a real note —
   **never silently clobber it.** Touch predicate: attendee or explicitly-linked subject only.
4. **Regenerate index-views (§12).** Any `type: index-view` note — the reading-queue (sources below
   `read`/`processed`), a people map, a drift list — is rebuilt from the current graph and re-stamped,
   never hand-edited.
5. **Apply only what's approved.** Prefer tightening over erasing; never delete to hit a size target.
   **Preserve frontmatter keys you don't recognize** on every rewrite. Never touch `knowledge/golden/`
   or any `locked: true` file.

## Don'ts
Don't delete without approval. Don't retire a task with open children. Don't clobber a hand-edited
timeline — surface it. Don't trim golden or locked content. Don't drop a key you didn't write. Don't
resolve a contradiction by guessing — surface it when it's not clear-cut.
