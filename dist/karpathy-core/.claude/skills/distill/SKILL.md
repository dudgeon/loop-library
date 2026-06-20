---
name: distill
description: Keep this project's knowledge base lean and trustworthy — merge duplicates, retire stale notes, resolve contradictions, fix broken links, and flag deliverables that have drifted from the notes. Suggest-only; asks before deleting. Use periodically, before an important piece of work, or when the knowledge base feels noisy. (This is karpathy-core's name for Karpathy's "lint".)
---

# distill

Keep the knowledge base sharp — the cleanup that stops it from bloating. Read `CLAUDE.md` first.

## Steps
1. Review `knowledge/` (notes + `index.md`) and `PROJECT.md` (what's golden, what's locked).
2. Propose a **numbered list** of changes, each with a reason: merge duplicates; retire stale or
   contradicted notes; resolve contradictions (golden wins — flag rather than silently overwrite);
   fix broken links; fix the minimal note contract (summary / kind / source); and flag any `work/`
   deliverable that has drifted from the notes it cites.
3. **Get the user's approval before deleting anything** — ask with the structured **AskUserQuestion**
   prompt (the change + concrete options like *merge / retire / keep*), not a free-text question
   (`CLAUDE.md` §10). Apply only what's approved. Prefer tightening over erasing; never delete to hit a
   size target.
4. Never touch `knowledge/golden/` or any `locked: true` file.
5. Work in git so every change is a reviewable diff.

## Don'ts
Don't delete without approval. Don't trim golden or locked content. Don't resolve a contradiction by
guessing — surface it for the user when it's not clear-cut.
