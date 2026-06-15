---
name: distill
description: Keep this project's knowledge base lean and trustworthy — merge duplicates, retire stale notes, resolve contradictions, fix broken links, and flag deliverables that have drifted from the notes. Suggest-only; asks before deleting. Use periodically, before an important piece of work, or when the knowledge base feels noisy. (This is loopkit's name for Karpathy's "lint".)
---

# distill

Keep the knowledge base sharp — the cleanup that stops it from bloating. Read `CLAUDE.md` first.

## Steps
1. Review `knowledge/` (notes + `index.md`) and `PROJECT.md` (what's golden, what's locked). If
   `knowledge/golden/vocabulary.md` exists, **read** it for context (§4.1) — you may read golden,
   never edit it.
2. Propose a **numbered list** of changes, each with a reason: merge duplicates; retire stale or
   contradicted notes; resolve contradictions (golden wins — flag rather than silently overwrite);
   fix broken links; fix the minimal note contract (summary / kind / source); and flag any `work/`
   deliverable that has drifted from the notes it cites. Also, on the same list:
   - **link hygiene** — links between notes should be plain relative markdown (`[label](./note.md)`);
     rewrite any stray `[[wikilink]]` to that form (it keeps the notes readable on GitHub too);
   - **recurring kinds** — if the same kind of thing recurs across several notes and isn't yet in
     `vocabulary.md`, *suggest* pinning it (e.g. *"'initiative' shows up in 5 notes with an
     internal/external split — pin this as vocabulary?"*). You never write golden yourself; the user
     decides. Compute this live from the current notes — don't keep a count anywhere.
   - **vocabulary drift** — if notes use a `kind:` the vocabulary doesn't mention, or that conflicts
     with it (e.g. `kind: external-initiative` where the vocabulary says scope is a property of an
     initiative), flag it for alignment.
3. **Get the user's approval before deleting anything.** Apply only what's approved. Prefer
   tightening over erasing; never delete to hit a size target.
4. Never touch `knowledge/golden/` or any `locked: true` file. (You may **read** `vocabulary.md`;
   changing it is always a deliberate "pin this" the user approves.)
5. Work in git so every change is a reviewable diff.

## Don'ts
Don't delete without approval. Don't trim golden or locked content. Don't resolve a contradiction by
guessing — surface it for the user when it's not clear-cut.
