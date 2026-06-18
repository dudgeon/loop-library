# CLAUDE.md — how this project works

This project keeps a **knowledge base that stays sharp**: as you work, useful context is filed into
a small set of plain-markdown notes, and you (the assistant) use them to help the user produce their
deliverables. Three operations keep the knowledge base useful — **ingest, query, distill**. (This is
the same loop Andrej Karpathy's "LLM wiki" uses; `distill` is what he calls `lint`.) Read this file
before you ingest anything, do work, or distill.

## 0. First run — set the project up
If `PROJECT.md` is still a template (it has TODO placeholders) or `knowledge/` is empty, this is a
fresh fork. **Do not guess what the user wants — interview them first.** Ask, in plain language:

1. **What are you trying to do?** — the goal.
2. **What do you want to produce?** — the deliverable(s): a PRD, a best-practices doc, a report.
3. **What should never drift?** — golden context to lock now: a template, hard rules, contracts.
4. **When will you tend it?** — roughly how often they'll add to it and clean it up.

Then write the answers into `PROJECT.md`, create `knowledge/` (and `knowledge/golden/`), pin any
golden context they named, and — if one fits — start a deliverable in `work/` from a template.
Until `PROJECT.md` is filled in, the only thing to do is this setup.

## 1. The shape
```
this project/
  CLAUDE.md            how the assistant works here (this file)
  PROJECT.md           the goal, deliverables, and what's golden — the source of truth
  knowledge/           the knowledge base — plain markdown notes
    index.md           one-screen catalog (kept current)
    golden/            locked context: templates, rules, contracts — never trimmed
  work/                the deliverable(s) (may be several; sections can be locked)
    templates/         starting scaffolds (managed)
  .claude/skills/      ingest · query · distill
  scripts/sync.sh      update the kit's machinery from origin
  loop.manifest.json   what sync.sh may overwrite (vs the user's content)
  CHANGELOG.md         kit version history
```
**Self-contained:** everything this project needs is in this repo. It does not depend on any
outside service, wiki, or parent repository.

## 2. PROJECT.md is the source of truth
Read it before any operation — the goal, the deliverables, the named golden context, the cadence.
It is **co-evolved with the user**: propose changes to what the project is *for*; make only small,
clearly-implied fixes yourself. If a request conflicts with it, surface the conflict and ask.

## 3. The three operations
- **ingest** — file new material into `knowledge/` as a short note, one topic per file, with a
  one-line `summary:`, a `kind:` label, and a `source:` line (where it came from). Link it to
  related notes and update `knowledge/index.md`. Don't write into `golden/`.
- **query** — read `knowledge/index.md` first, then the relevant notes, plus `golden/` as
  authoritative constraints. Answer the question or advance a deliverable in `work/`, citing the
  notes you used. File genuinely new conclusions back as notes. If the knowledge base can't answer,
  say so and suggest what to ingest — don't fabricate.
- **distill** — keep the knowledge base lean and trustworthy (this is Karpathy's "lint"): propose a
  numbered list — merge duplicates, retire stale notes, resolve contradictions (golden wins), fix
  broken links, and flag any deliverable that has drifted from its notes. **Suggest-only:** get
  approval before deleting. Never touch `golden/` or locked work (§4–§5).

## 4. Golden context — locked
`knowledge/golden/` holds context that must not drift: templates, hard rules, contracts, OKRs,
definitions. It is loaded first and **wins on contradiction**. You **do not change anything under
`golden/` without asking**, and `distill` never trims it. **Promotion path:** when the user says
"pin this", "make this golden", or "this is the rule", move that item into `golden/` after
confirming the exact content. Changing golden is always deliberate.

## 5. Deliverables can be many, and locked in pieces
`work/` holds the deliverable(s) — there may be **several**, and one deliverable can be **split into
section files** (e.g. a PRD as `work/prd/01-problem.md`, `02-plan.md`, …) so parts can be finalized
one at a time. Add `locked: true` at the top of a file to **lock** it: you then treat it like golden
— you won't rewrite a locked file without asking. `query` advances the **unlocked** parts from the
knowledge base; `distill` flags an unlocked part that has drifted. See `work/README.md`.

## 6. Ownership & safety
Write freely in ordinary `knowledge/` notes and **unlocked** `work/` drafts (keep
`knowledge/index.md` honest). **Confirm before changing** `knowledge/golden/` and any `locked: true`
file; **propose** changes to `PROJECT.md`. Treat `.claude/skills/`, `scripts/`,
`loop.manifest.json`, `CHANGELOG.md`, and `work/templates/` as the kit's engine (updated by
`scripts/sync.sh`) — don't edit them casually. `distill` is destructive, so: propose first and apply
only what's approved; work in git so every change is a reviewable diff; prefer tightening over
deleting; never delete to hit a size target.

## 7. Keep it light
Use only what the platform already gives you: skills, this `CLAUDE.md`, and plain files. No
databases, no elaborate schemas. Three operations, one knowledge base (split into labelled folders
only if a real need shows up). Prefer fewer, better notes. Talk to the user about *their* knowledge
and *their* deliverable — not about loops or theory.

## 8. Note conventions (the only hard rule)
Every `knowledge/` note carries three frontmatter lines: `summary:` (one line), `kind:` (a short
label like note/finding/decision/recommendation), and `source:` (where it came from — a link, a
person, a date; may be brief, or `unverified`). Sourcing is light at capture, but a **real source
reference is required** for anything in `golden/` and for any finalized recommendation or
deliverable claim — "why do we believe this?" is the whole value. One topic per file;
lowercase-hyphenated names; keep each `index.md` to about one screen.

## 9. The one-line rule
The knowledge base is the product; ingest / query / distill just keep it sharp — grounded always in
`PROJECT.md`, and never at the expense of golden context.
