# brainkit

A **second brain** for work that compounds — a project that gets sharper every time you use it, and
turns what you learn into the deliverable you're trying to produce.

Most tools either *store* things (and rot into a junk drawer) or *retrieve* things (and rediscover the
same answers from scratch every time). brainkit does neither. As you work, what you learn is filed as
a small **graph** of plain-markdown notes — each one *typed* (a meeting, a person, a finding, a task)
and *linked* to the others — right here in your repo. The assistant draws on that graph to advance your
work, and keeps it lean so you can trust it.

> The north star: **recursive loops that build knowledge to improve one or more declared work
> products.** Knowledge isn't the goal — a better deliverable is. The knowledge just gets you there
> faster each time.

## What makes it a *brain* (not just notes)

- **It resolves things as you capture them.** Share a messy meeting note full of shorthand and the
  assistant asks, *right then,* who "the vendor" is and what "SLT" stands for — then links them to the
  real entities and remembers the alias, so next time it just knows. Your notes stay findable.
- **It keeps a timeline for the things that need one.** Mark a type (a `person`, an `initiative`) as
  timeline-bearing and the assistant maintains a dated history on it — regenerated from the graph, not
  hand-copied, so it never drifts.
- **It tracks tasks as part of the graph.** A task isn't a line in a separate list — it's a node, with
  who asked for it and which initiative it serves. "What's open under this initiative?" is just a
  question to the graph.
- **It knows what it knows.** Sources move `unread → reading → read → processed`; findings move
  `draft → solid → canonical`; every claim traces back to its source. Ask *"what's missing for this
  deliverable?"* and it tells you what to go learn next.

## The rhythm: ingest → query → distill
- **ingest** — capture what you learn (a call, a doc, a decision, a person, a task). It's resolved,
  enriched, linked, and filed — with the raw kept intact.
- **query** — put the brain to work: answer a question, or draft and advance your deliverable in
  `work/`, grounded in what you've gathered, with citations. New conclusions get filed back.
- **distill** — keep it clean: merge duplicates, retire stale notes, heal the timelines, resolve
  contradictions. It proposes changes and asks before deleting anything.

## Start here
Open the project and tell the assistant what you're working on. The first time, it will **interview
you** — your goal, the **deliverable(s)** you want to produce, which **entities deserve a timeline**,
and how you want **tasks** handled — then set up the folders. You only do that once.

*(If your repo already has a `CLAUDE.md`, ask the assistant to merge brainkit's in rather than
overwrite.)*

## Golden context — the stuff that's locked
Some things shouldn't drift: a PRD template, team rules, a definition. Keep them in
`knowledge/golden/`. The assistant treats them as the source of truth and won't change them without
asking. To lock something new, just say **"pin this."**

## Your deliverables
They live in `work/` — you can have **several**, and split one into sections you **finalize one at a
time** (mark a section `locked: true`). `query` advances the unlocked parts from your notes, with
citations. See `work/README.md`.

## Already a Duo vault
The notes are plain markdown and the links are plain relative links, so everything renders on GitHub —
and the folder ships as a [Duo](https://github.com/dudgeon/duo) **vault**. If you use Duo, just open
the folder and select it; the marker's already in `knowledge/index.md`. **Nothing here needs Duo** —
it's an accelerator (capture, search, link-repair, live entity/alias resolution), never a dependency.

## Where things live
```
your project/
  PROJECT.md     your goal, deliverables, and task policy (set up on first run)
  knowledge/     your notes — typed and linked
    templates/   your entity types (brainkit ships a few starters; they're yours to edit)
    golden/      locked context: definitions, rules, contracts
  work/          your deliverables
  CLAUDE.md      how the assistant works here
```
Everything is plain files in your repo — read them, edit them, commit them. Nothing depends on an
outside service.

## Principles
- The knowledge base is the product; the three operations keep it sharp and put it to work.
- Pay the enrichment tax at capture, so retrieval is cheap forever after.
- One source of truth — never a hand-synced second copy of anything.
- Light beats complete — a lean, trustworthy brain beats a giant doubtful one.
- It's all yours and self-contained.

## Where this comes from
brainkit is the **application layer** on [loopkit](FOUNDATION.md) — the entity-graph foundation —
which in turn packages Andrej Karpathy's "LLM wiki" (an assistant keeps a markdown knowledge base
current with **ingest, query, lint**; we call `lint` **`distill`**). brainkit adds the policy that
makes intake high-fidelity and knowledge deliverable-grade. The model is grounded in a real
hand-rolled predecessor (a work-agent harness); brainkit keeps its good ideas and drops the
hand-maintained machinery a typed-entity graph makes unnecessary. The *why* and the seam are in
[`DESIGN.md`](DESIGN.md); the foundation contract is in [`FOUNDATION.md`](FOUNDATION.md).

To update the kit's machinery later without touching your content, run `scripts/sync.sh`.
