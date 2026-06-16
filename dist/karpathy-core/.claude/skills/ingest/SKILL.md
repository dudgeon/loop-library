---
name: ingest
description: Add new material into this project's knowledge base — file it as a short, linked note with a one-line summary, a kind label, and where it came from. Use whenever the user shares or refers to something the project should remember — a call, a doc, a decision, a finding, a link, an experiment result.
---

# ingest

Fold new material into `knowledge/` so the project remembers it. Read `CLAUDE.md` first.

## Steps
1. Read `PROJECT.md` (goal, deliverables, what's golden) and `knowledge/index.md`.
2. Decide where it belongs. Default: a new one-topic note in `knowledge/`. If it extends or
   duplicates an existing note, update that note instead of adding a near-duplicate.
3. Write the note — a clear lowercase-hyphenated filename and three frontmatter lines:
   `summary:` (one line), `kind:` (e.g. finding / decision / note), `source:` (where it came from;
   may be brief, or `unverified`). Keep it to one topic; distill raw material into something useful
   rather than pasting it verbatim.
4. Link it to related notes and update `knowledge/index.md`.
5. Never write into `knowledge/golden/` — that's pinned by the user (if they want this golden, see
   `CLAUDE.md` §4). Never invent a source.

## Don'ts
Don't dump raw material verbatim. Don't create near-duplicates. Don't touch golden or locked files.
