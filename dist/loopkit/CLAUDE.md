# CLAUDE.md — how this project works

This project keeps a small **graph of typed notes** that gets sharper as you use it. As you work,
what you learn is filed as **entities** — typed markdown notes — linked to each other, and you (the
assistant) use that graph to help the user produce their deliverables. Three operations keep it
useful: **ingest, query, distill** (the same loop Andrej Karpathy's "LLM wiki" uses; `distill` is
what he calls `lint`). Read this file before you ingest, do work, or distill.

This kit is a **foundation**, not a finished application. It gives you the primitives — typed
entities, links that can carry a little data, and entity resolution — that a richer work agent is
built *on*. Keep it that way: **own the mechanism, not the vocabulary.** Ship the *kind* of thing (a
`person` note, a `status:` field); don't bake in one team's lifecycle, proximity tiers, or domain
scheme. Those are for the application to add on top. **Building that richer agent? Read
[`FOUNDATION.md`](FOUNDATION.md)** — the contract and the seam between what loopkit owns and what's
yours.

The notes are plain markdown and the links are plain relative-markdown, so everything renders on
GitHub — and the folder is already a **Duo vault**, so if you use Duo you can just open the folder and
select it (the marker is already in `knowledge/index.md`). Nothing here *requires* Duo; it's an
accelerator, never a dependency.

## 0. First run — set the project up
If `PROJECT.md` is still a template (TODO placeholders) or `knowledge/` is empty, this is a fresh
fork. **Don't guess what the user wants — interview them first.** Ask, in plain language:

1. **What are you trying to do?** — the goal.
2. **What do you want to produce?** — the deliverable(s): a PRD, a best-practices doc, a report.
3. **What should never drift?** — golden context to lock now: a template, hard rules, contracts.
4. **When will you tend it?** — roughly how often they'll add to it and clean it up.

Write the answers into `PROJECT.md`, create `knowledge/` (and `knowledge/golden/`), pin any golden
context they named, and — if one fits — start a deliverable in `work/` from a template. Until
`PROJECT.md` is filled in, the only thing to do is this setup. Don't author any types up front; they
emerge with use (§4).

## 1. The shape
```
this project/
  CLAUDE.md            how the assistant works here (this file)
  FOUNDATION.md        what loopkit is + how to build a richer agent on it
  PROJECT.md           the goal, deliverables, and what's golden — the source of truth
  knowledge/           the graph — typed markdown notes (entities) linked to each other
    index.md           one-screen catalog (kept current); carries the Duo-vault marker
    templates/         a note per entity type — read by Duo and by these skills
    golden/            locked context — definitions, rules, contracts
  work/                the deliverable(s) (may be several; sections can be locked)
    templates/         deliverable scaffolds (managed) — NOT entity types
  .claude/skills/      ingest · query · distill
  scripts/sync.sh      update the kit's machinery from origin
  loop.manifest.json   what sync.sh may overwrite (vs the user's content)
  CHANGELOG.md         kit version history
```
**Self-contained:** everything this project needs is in this repo. It doesn't depend on any outside
service, wiki, or parent repo. Duo, when present, reads these same files.

## 2. PROJECT.md is the source of truth
Read it before any operation — the goal, the deliverables, the named golden context, the cadence.
It's **co-evolved with the user**: propose changes to what the project is *for*; make only small,
clearly-implied fixes yourself. If a request conflicts with it, surface the conflict and ask.

## 3. Notes are typed entities (the contract)
Every `knowledge/` note is an **entity** — one thing, one file. It carries three frontmatter lines as
a **floor, not a ceiling**:

- `summary:` — one line.
- `type:` — what kind of thing this is (`finding`, `decision`, `person`, `source`, `topic`, …). This
  is the field that makes a note a typed node; it's also the field Duo files and heals on.
- `source:` — where it came from (a link, a person, a date; may be brief, or `unverified`).

Then:
- **Add any other typed attributes you need** — a `status:`, a date, an owner. The three lines are the
  minimum; richer notes carry more.
- **Keep frontmatter keys you don't recognize.** When you edit a note, never drop a key you didn't
  write — an `id:` a tool like Duo added, an application's `status:` or `owner:`. Don't strip metadata
  you didn't author. *(This is load-bearing: dropping an unknown key silently deletes someone's data.)*
- **`id:` is optional and you never mint it.** If a note has one (Duo mints a stable `id:` when it
  opens the vault), preserve it. Without one, links resolve by filename.
- One topic per file; lowercase-hyphenated names; keep each `index.md` to about one screen.

## 4. Types emerge, then get written down
Don't design a schema up front. Start flat — just give each note a sensible `type:`. When the same
type keeps showing up and is worth pinning, **write it down** as `knowledge/templates/<type>.md`
(named for the type): what the type is, the attributes it usually carries, and — if it has a
lifecycle — its **ordered status ladder** (e.g. `statuses: [unread, reading, read, processed]`). That
folder is **where a Duo vault reads types from**, so writing one there makes the type real to Duo
*and* to these skills at once — one scheme, not two. The type notes you write are **yours** — `sync` never touches them — and **both Duo and these skills
read them** (only this folder's `README.md` is kit machinery, kept current by `sync`). The assistant can refine a type as
the project teaches you what its types are. That's how a concept like "initiative" gets defined once
instead of reinvented — and `ingest` / `distill` resolve notes against it (§6–§7). Keep each as plain
prose + a little frontmatter, **not** a hand-maintained `## Fields` grid.

## 5. Links are edges (and can carry a little data)
A link between notes is an **edge** in the graph. Three faces of one edge: the link in the body, an
optional structured payload in frontmatter, and a sentence nearby saying what the link means.

- **Links are plain relative markdown** — `[label](./other-note.md)`. Never `[[wikilinks]]`, never
  absolute `/paths`. (If you type `[[Name]]` as a quick gesture, resolve it to a rel-md link before
  saving — nothing with `[[ ]]` lands in a commit.) This renders on GitHub and is exactly what a Duo
  OKF vault expects.
- **An edge can carry a payload.** `source:` is the floor; when a link needs to carry more — a
  citation's key quote, who requested the work — put that in frontmatter next to the link. Keep the
  vocabulary general; the application names specific edges.
- **Edges survive a split.** If you decompose one note into several, **copy the source/attribution
  edge onto each child** so every piece keeps its own back-reference.

## 6. Entity resolution — resolve vague references to the canonical note
Turn "the analytics tool" into the `Amplitude` note, "Sarah's manager" into the actual person. Do
this **at ingest and again at distill** — at capture and at cleanup — not just when answering.

- **When a Duo vault is present, the vault resolves.** `duo vault schema` is the live table of types,
  entities, and aliases — read it; don't keep a second index of your own.
- **Headless,** resolve against the notes already in `knowledge/`, then `golden/`, then ask the user.
  An illustrative order, not a law — an application can override it. Persist nothing.
- **Prefer a vague-but-correct name over a confident-but-invented one.** Never upgrade a name you
  can't verify. If you can't resolve it, keep what you have and flag it.

## 7. The three operations
- **ingest** — file new material as a typed entity note (§3): pick its `type:`, **resolve the entities
  it mentions** (§6), link it to related notes with rel-md edges (§5), and update `knowledge/index.md`.
  If it extends an existing entity, enrich that note instead of making a near-duplicate. Don't write
  into `golden/`.
- **query** — read `knowledge/index.md` first, then the relevant notes, plus `golden/` (definitions)
  as authoritative constraints and `knowledge/templates/` (the types) to resolve against. Answer, or
  advance a deliverable in `work/`, citing the
  notes you used. File genuinely new conclusions back as notes. If the graph can't answer, say so and
  suggest what to ingest — don't fabricate.
- **distill** — keep the graph lean and trustworthy (Karpathy's "lint"): propose a numbered list —
  merge duplicates, retire stale notes, resolve contradictions (golden wins), fix broken links and
  rewrite any stray `[[wikilink]]` to rel-md, **resolve entities** and flag a `type:` that drifts from
  a written-down type (§4), and regenerate any stamped view (§8). **Suggest-only:** get approval before
  deleting. Never touch `golden/` or locked work (§9–§10). You may *read* `golden/` for context.

## 8. Derived views are regenerated, never hand-cached
A roll-up — a map of people, a list of notes behind on a template — is its own note with
`type: index-view`. Its body is **regenerated from the graph and stamped** (when, from what), not
hand-maintained and not a live cache. Reserved files `index.md` / `log.md` are **not** entity nodes —
don't give them an entity node's graph links or attributes. (`index.md`'s `okf_version` / `type:
index` is the reserved-file *marker* — a different use of the field, not an entity `type:`.) A view is
always a separate node.

## 9. Golden context — locked
`knowledge/golden/` holds context that must not drift: definitions, hard rules, contracts. It's loaded
first and **wins on contradiction**. You **don't change anything under `golden/` without asking**, and
`distill` never trims it. **Promotion path:** when the user says "pin this", "make this golden", or
"this is the rule", move that item into `golden/` after confirming the exact content. (Writing down a
*type* is a different, lighter act — that goes to `knowledge/templates/`, §4, and isn't locked.)

## 10. Deliverables can be many, and locked in pieces
`work/` holds the deliverable(s) — there may be **several**, and one can be **split into section
files** so parts can be finalized one at a time. Add `locked: true` at the top of a file to lock it;
you then treat it like golden — no rewrites without asking. `query` advances the unlocked parts;
`distill` flags an unlocked part that has drifted. See `work/README.md`.

## 11. Ownership & safety
Write freely in ordinary `knowledge/` notes and **unlocked** `work/` drafts (keep `knowledge/index.md`
honest, and preserve keys you didn't write — §3). **Confirm before changing** `knowledge/golden/` and
any `locked: true` file; **propose** changes to `PROJECT.md`. Treat `.claude/skills/`, `scripts/`,
`loop.manifest.json`, `CHANGELOG.md`, and `work/templates/` as the kit's engine (updated by
`scripts/sync.sh`) — don't edit them casually. `sync.sh` overwrites only the managed files and deletes
nothing else, so your notes, your `golden/`, and your `work/` are safe. `distill` is destructive:
propose first, apply only what's approved, work in git, prefer tightening over deleting.

## 12. Keep it light — and keep it a foundation
Use only what the platform gives you: skills, this `CLAUDE.md`, plain files. No databases, no
hand-maintained schema grids. Three operations, one graph. Add a type or a folder only when a real
need shows up. And remember what this kit is *for*: it's the foundation a richer agent is built on, so
resist baking in the one obvious lifecycle — ship the mechanism, let the application bring the policy.
Talk to the user about *their* knowledge and *their* deliverable, not about graphs or theory.
