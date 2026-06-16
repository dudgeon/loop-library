# loopkit

A starter kit for a project that **learns as you use it.**

Most projects start cold every time — you re-explain the goal, re-paste the constraints, re-find
what you decided last week. This one is different: as you work, what you learn is filed into a small
**graph** of plain-markdown notes — each one *typed* (a finding, a person, a source) and *linked* to
the others — right here in the repo, and the assistant draws on it to help you produce your work. The
more you use it, the sharper it gets.

The catch with "remember everything" setups is bloat — heavy, stale, contradictory, until nobody
trusts them. This kit keeps a cleanup step in the rhythm, so the knowledge base stays lean and worth
trusting.

> The knowledge base is the product. Everything else just keeps it fresh and puts it to work.

## Start here
Open the project and tell the assistant what you're working on. The first time, it will **interview
you** — your goal, what you want to produce, and anything that should be locked (a template, hard
rules) — and set up the folders for you. You only do that once.

*(If your repo already has a `CLAUDE.md`, ask the assistant to merge loopkit's `CLAUDE.md` into it
rather than overwrite.)*

## The rhythm: ingest → query → distill
- **ingest** — add what you learn (a call, a doc, a decision, a finding). It's filed as a short note
  and linked to what's related.
- **query** — put the knowledge base to work: ask a question, or draft and advance your deliverable,
  grounded in what you've gathered. New conclusions get filed back.
- **distill** — keep it clean and lean: merge duplicates, drop what's stale, resolve contradictions.
  It proposes changes and asks before deleting anything.

## Golden context — the stuff that's locked
Some things shouldn't drift: a PRD template, team rules, an API contract. Keep them in
`knowledge/golden/`. The assistant treats them as the source of truth and won't change them without
asking. To lock something new, just say **"pin this."**

## Your deliverables
They live in `work/`. You can have **several**, and you can split one into sections so you can
**finalize them one at a time** — mark a section `locked: true` and the assistant won't rewrite it
without asking. See `work/README.md`.

## Already a Duo vault
The notes are plain markdown and the links are plain relative links, so everything renders on GitHub —
and the folder ships as a [Duo](https://github.com/dudgeon/duo) **vault**. If you use Duo, just open
the folder and select it; the marker's already in `knowledge/index.md`. **Nothing here needs Duo** —
it's an accelerator (capture, search, link-repair), never a dependency.

## Where things live
```
your project/
  PROJECT.md     your goal and deliverables (set up on first run)
  knowledge/     your notes — typed and linked
    templates/   your entity types (read by Duo and the assistant)
    golden/      locked context: definitions, rules, contracts
  work/          your deliverables
  CLAUDE.md      how the assistant works here
```
Everything is plain files in your repo — read them, edit them, commit them. Nothing depends on an
outside service.

## Principles
- The knowledge base is the product; the three operations just keep it sharp.
- Light beats complete — a lean, trustworthy knowledge base beats a giant doubtful one.
- Golden context is sacred — locked unless you change it deliberately.
- It's all yours and self-contained.

## Building on it
loopkit is a *foundation* — a richer agent (domains, a stakeholder map, a source-to-knowledge
pipeline) can be built on top of it. If that's you (or your agent), read
[`FOUNDATION.md`](FOUNDATION.md): the contract and the seam between what loopkit owns and what's yours.

## Where this comes from
loopkit packages a simple, proven idea: Andrej Karpathy's "LLM wiki," where an assistant keeps a
markdown knowledge base current with three operations — **ingest, query, lint.** We use the same
loop; we just call `lint` **`distill`**, because that's what it does for you. Work that benefits
from this — research that compounds, a document built from accumulating evidence — is "loopable,"
and loopkit is a way to make that kind of work easy to set up and keep running.

To update the kit's machinery later without touching your content, run `scripts/sync.sh`.
