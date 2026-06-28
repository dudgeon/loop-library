# CLAUDE.md — how this project works

> **Editing this file?** It's machinery: the `sync` skill may *offer* you an upstream version of it.
> Local edits here are safe — sync curates with your approval and preserves (or merges) your tweaks,
> it never bulk-overwrites — but durable customization still belongs in `PROJECT.md` or
> `knowledge/templates/` (both yours), where it's unambiguously yours.

This project is a **second brain**: a small **graph of typed notes** that gets sharper as you use it,
in service of a deliverable. As you work, what you learn is filed as **entities** — typed markdown
notes, linked to each other — and you (the assistant) use that graph to help the user produce their
**work product(s)**. Three operations keep the knowledge useful: **ingest, query, distill** (Andrej
Karpathy's "LLM wiki" loop; `distill` is what he calls `lint`); a fourth, **sync**, keeps the kit's own
machinery current from upstream (§11). Read this file before you ingest, do work, or distill.

**North star:** *recursive loops that build knowledge to improve one or more declared work products.*
Knowledge is never an end in itself — it accrues to make a deliverable better, and each pass makes the
next intake cheaper. Two things follow, and they shape every operation below:

- **Retrieval is the point.** Knowledge that can't be found or linked later can't improve a work
  product — so intake pays an enrichment tax up front (resolve, expand, link).
- **Trust is the point.** A deliverable should draw on knowledge whose maturity and lineage are known
  — so knowledge carries a status ladder and a traceable source edge.

brainkit is the **application layer** on **loopkit** (the entity-graph foundation — its contract is in
[`FOUNDATION.md`](FOUNDATION.md)). brainkit keeps that contract **unchanged** and adds *policy*: a few
starter entity types, retrieval-grade intake, per-entity timelines, maturity/lineage, and a task
model. It stays **light** — it does *not* add a domain system, a stakeholder-proximity scheme, a
source-synthesis engine, or a strategy/roadmap layer. The *why*, and what's deliberately excluded, are
in [`DESIGN.md`](DESIGN.md).

## 0. First run — set the project up
If `PROJECT.md` still has TODO placeholders or `knowledge/` has no notes, this is a fresh fork.
**Don't guess — interview the user first.** Ask, in plain language:

1. **What are you trying to do?** — the goal.
2. **What do you want to produce?** — the **work product(s)** (a PRD, a best-practices doc, a report);
   they live in `work/`.
3. **Which things deserve a running history?** — the entity kinds that should carry a **timeline**
   (people, initiatives). You'll set `timeline: true` on those types (§8). Defaults: the shipped
   `person` type carries one.
4. **How should tasks be handled?** — set `task_policy` (§9): **`embodied`** (default — tasks live in
   the graph as nodes), `externalized` (you have a real tracker; brainkit hands off and keeps a
   pointer), or `off`.
5. **What should never drift?** — golden context to lock now: a template, hard rules, definitions.
6. **When will you tend it?** — roughly how often they'll ingest, query, and distill.

Write the answers into `PROJECT.md` (including the `task_policy:` line, §2), create `knowledge/golden/`
if needed, pin any golden context, and — if one fits — start a deliverable in `work/` from a template.
The starter entity types are already in `knowledge/templates/` (§4); refine them to the user's world,
don't invent a big schema up front.

## 1. The shape
```
this project/
  CLAUDE.md            how the assistant works here (this file)
  FOUNDATION.md        the loopkit foundation this is built on (the contract + the seam)
  DESIGN.md            why brainkit is shaped this way, and what it deliberately excludes
  PROJECT.md           goal, deliverables, task policy, what's golden — the source of truth
  knowledge/           the graph — typed markdown notes (entities) linked to each other
    index.md           one-screen catalog (kept current); carries the Duo-vault marker
    templates/         a note per entity type — brainkit ships starters; they're yours
    golden/            locked context — definitions, rules, contracts
  work/                the deliverable(s) (may be several; sections can be locked)
    templates/         deliverable scaffolds (managed) — NOT entity types
  .claude/skills/      ingest · query · distill · sync
  loop.manifest.json   origin + which machinery files sync may update (vs your content)
  CHANGELOG.md         kit version history
```
**Self-contained:** everything this project needs is in this repo. No outside service, wiki, or parent
repo. Duo, when present, reads these same files.

## 2. PROJECT.md is the source of truth
Read it before any operation — the goal, the deliverables, the **task policy**, the named golden
context, the cadence. It carries a `task_policy: embodied | externalized | off` line near the top
(default `embodied`); ingest, query, and distill read it there on entry. It's **co-evolved with the
user**: propose changes to what the project is *for*; make only small, clearly-implied fixes yourself.
If a request conflicts with it, surface the conflict and ask.

## 3. Notes are typed entities (the contract — from loopkit, unchanged)
Every `knowledge/` note is an **entity** — one thing, one file. Three frontmatter lines are a **floor,
not a ceiling**:
- `summary:` — one line.
- `type:` — what kind of thing this is (`source`, `meeting`, `note`, `person`, `task`, …). This is the
  field that makes a note a typed node; it's also what Duo files and heals on.
- `source:` — where it came from (a link, a person, a date; may be brief, or `unverified`).

Then:
- **Add any other typed attributes you need** — a `status:`, a date, an owner, `aliases:`.
- **Keep frontmatter keys you don't recognize.** Never drop a key you didn't write — an `id:` Duo
  added, an `owner:` an app set. *(Load-bearing: dropping an unknown key silently deletes data.)*
- **`id:` is optional and you never mint it.** Preserve one if present; without one, links resolve by
  filename.
- One topic per file; lowercase-hyphenated names; keep each `index.md` to about one screen.

## 4. Types: starters ship, the rest emerge then get written down
brainkit ships a few **starter types** in `knowledge/templates/` (`source`, `meeting`, `note`,
`decision`, `person`, `task`) so a fresh fork isn't empty. **They're yours** — refine them, add
attributes, add new types as the project teaches you what it tracks. That folder is **where a Duo vault
reads types from**, so a type written there is real to Duo *and* to these skills at once. A type is
plain prose + a little frontmatter (its `statuses:` ladder if it has a lifecycle; `timeline: true` if
it carries a history) — **not** a hand-maintained `## Fields` grid. Don't author a big schema up front;
let new types emerge and write each down when it earns it. (The starter templates are **seed-once**:
shipped once, never overwritten by `sync` — see §15.)

## 5. Links are edges (and can carry a little data) — from loopkit, unchanged
A link is an **edge**. Three faces: the link in the body, an optional payload in frontmatter, and a
sentence nearby saying what it means.
- **Plain relative markdown** — `[label](./other-note.md)`. Never `[[wikilinks]]`, never absolute
  `/paths`. (Resolve a quick `[[Name]]` gesture to rel-md before saving — nothing with `[[ ]]` lands
  in a commit.)
- **An edge can carry a payload** — a citation's key quote, who requested the work — in frontmatter
  next to it.
- **Edges survive a split.** Decompose one note into several → copy the source/attribution edge onto
  each child.

## 6. Entity resolution — resolve with the user, at intake (F1)
Turn "the analytics tool" into the `Amplitude` note, "Sarah's manager" into the actual person — and do
it **interactively, while the user has the context**, not as a silent guess or a deferred flag.
- **Vault-first.** When a Duo vault is present, consult `duo vault schema` (the live types/entities/
  **aliases** table) **first** — it's the resolution table; don't keep a second index. Headless, fall
  back: existing `knowledge/` notes → `golden/` → **ask the user** — and ask with the structured
  **AskUserQuestion** prompt (the reference + the candidate notes as concrete options; §17), not a
  free-text guess.
- **Record the alias.** When you resolve a shorthand ("SLT" → Senior Leadership Team; "the vendor" →
  `Acme`), write the alias onto the **canonical entity note** (`aliases: [SLT, …]`) so the next capture
  auto-resolves. That's the compounding loop. (The note is the only index; persist nothing elsewhere.)
- **Never upgrade a name you can't verify.** A vague-but-correct name beats a confident-but-invented
  one. If you can't resolve it, keep what you have and flag it.

Resolution runs at **ingest** and again at **distill**.

## 7. Enrichment at intake — make raw capture retrievable (F3)
Raw capture (especially meeting notes full of shorthand) becomes **one enriched note** that *represents*
the source: acronyms expanded, entities linked (`the vendor` → `[Acme](./acme.md)`), terms made
canonical. **Augment into a single note — don't make a synced "clean twin" of the same content.**
- **Preserve the raw.** Keep the verbatim original in a `## Raw` section in the same file. An external
  link to the original (a Doc, a recording) is allowed **only when that original is durable and
  immutable**; for anything mutable or expiring, capture verbatim in-file — and even in external-link
  mode, snapshot the key verbatim excerpts in-file, so a dead link never erases the user's words.
- **The enriched body is a faithful transform, not the fidelity record.** It may substitute canonical
  names and expand acronyms inline; the exact wording lives only in `## Raw`. (This is the deliberate
  *dump-vs-preserve* distinction — the body is the substance, `## Raw` is the quarantined fidelity
  copy. It is *not* the same as "dump raw material verbatim," which we don't do.)
- **Extraction is separate from cleaning.** The genuinely reusable ideas/decisions get pulled *out*
  into their own `note`/`decision` entries with a lineage edge back (§10) — never a cleaned copy of the
  whole source. Test: an extraction states one atomic idea in its own words with the key quote on its
  lineage edge; if a candidate would mostly restate the passage, it's a cleaned copy — drop it and
  enrich the source instead.

## 8. Per-entity timelines — write-time, re-derivable (F2)
A type may declare `timeline: true`. Entities of that type carry a `## Timeline` section on their own
note, holding dated, summary-level history. It is **maintained at write time, never computed at query
time**, and is a **regenerated view** (loopkit §8), so it must stay re-derivable from the graph:

- **The regenerated region is fenced** with `<!-- BEGIN generated:timeline -->` /
  `<!-- END generated:timeline -->` markers and a stamp (when, from how many notes). `ingest` **appends**
  a dated entry inside the markers when it files a note that touches the entity; `distill`
  **re-derives** the whole fenced region from the graph and re-stamps it.
- **The touch predicate (shared by append and heal):** an entity is *timeline-touched* by a note **iff
  it is an attendee or an explicitly-linked subject** of that note. An incidental mention surfaced only
  by F3 enrichment does **not** append a timeline entry. Same rule at ingest and distill → no drift.
- **Re-derivable, always.** Each entry summarizes a linked note; the authoritative event lives in that
  note, not in the timeline. **A fact must never live *only* in a timeline.** If a user hand-edits
  inside the fenced region, `distill` **detects it and surfaces it** (suggest-only) so the fact can be
  moved to a real note — it is never silently clobbered. The timeline template says: this section is
  machine-owned; add facts to the event note, not here.

A cross-entity roll-up (if ever wanted) is a separate `type: index-view` node — same regenerate-and-
stamp rule (§12), never per-entity hand-maintenance.

## 9. Tasks — typed nodes, one source of truth (default: embodied)
Task **extraction** — recognizing an action item in raw capture ("David to send the SOC2 doc by Fri")
— runs at ingest regardless of policy, in parallel with knowledge extraction. The **sink** is set by
`task_policy` in `PROJECT.md`:

- **`embodied` (default):** a task is a `type: task` **node** — owner edge, `requested_by`/`source`
  edge, `due:`, `status:` (ladder `[open, in-progress, blocked, done]`), and a **`parent` edge** to a
  parent task (decomposition) and/or the initiative / work-product it advances. The node **is** the
  single source of truth — **no mirror** in any other file.
- **`externalized`:** brainkit extracts and hands the task to the user's real tracker, keeping at most
  a **pointer edge** (a `task` node linking to the external item) — never a copy of mutable state.
- **`off`:** no task handling.

**Why nodes, not a list:** a task under an initiative, sourced from the meeting that raised it,
attributed to the asker, is *knowledge* — it wires "what needs doing" to "what we're building." That's
the north star. Rules that keep it honest:
- **Single source of truth, no mirrors** — the breaker brainkit exists to avoid.
- **`parent` integrity:** at ingest, walk the parent chain and refuse/repair an edge that would close a
  cycle. At distill, a task with **open children is not retireable** — re-parent the children to the
  grandparent/initiative first (suggest-only, git-reviewed).
- **Attribution + parentage survive a split** (§5).
- **Status is closeable/reopenable** (not a monotonic maturity ladder). "Stale" = `open` past its
  `due:` (or `open` with no linked-note activity in a long while) — what `distill` surfaces. Closing a
  task can surface its `requested_by` for a notify-the-asker note (no mirroring needed).

## 10. Source → knowledge: maturity, lineage, and gaps
This is how raw material becomes deliverable-grade knowledge.
- **Two ladders** (declared on the types): `source` runs `unread → reading → read → processed`;
  `note` (knowledge) runs `draft → solid → canonical`. Status tells you what's trustworthy enough to
  pull into a deliverable, and what raw material is still unmined.
- **Lineage.** Every extracted claim links back to its source with the **key quote on the edge** (§5).
  Don't duplicate — enrich: a new source on a known idea updates the existing note and adds a citation.
- **Gap analysis (a `query` mode).** Ask "what's missing for *this* deliverable?" — read the `work/`
  target and the graph, and surface what to ingest next. This closes the recursive loop. Propose; don't
  fabricate.
- **Reading-queue view.** "What's unprocessed?" is a regenerated `type: index-view` over source status
  (§12) — `distill` rebuilds it, `query` reads it.

## 11. The operations
- **ingest** — capture new material as a typed entity (§3): **resolve** what it mentions (§6),
  **enrich** it and preserve the raw (§7), **link** it (§5), **append** to any touched entity's
  timeline (§8), **extract** reusable knowledge and tasks (§7, §9), set the right `status:`, and update
  `knowledge/index.md`. Don't write into `golden/`.
- **query** — read `knowledge/index.md` first, then the relevant notes (follow edges one hop at a
  time), plus `golden/` (constraints) and `knowledge/templates/` (types) to resolve against. Answer, or
  advance a deliverable in `work/`, **with citations**; run gap analysis when asked; read the
  reading-queue and task views. File genuinely new conclusions back. If the graph can't answer, say so
  and suggest what to ingest — don't fabricate.
- **distill** — keep the graph lean and trustworthy: merge duplicates, retire stale notes (respecting
  task `parent` integrity, §9), resolve contradictions (golden wins), fix links and rewrite any stray
  `[[wikilink]]`, **resolve entities** (§6), flag `type:` drift (§4), **re-derive timelines** and
  **regenerate index-views** (§8, §12), and flag a `work/` deliverable that has drifted. **Suggest-only**
  — get approval before deleting; preserve unknown keys; never touch `golden/` or locked work.
- **sync** — refresh the kit's **machinery** from canonical brainkit, **selectively**. A curation task,
  not a script: read what changed upstream (`managed_files` only), reason about which improvements are
  worth adopting *here*, and pull in only what you approve — **merging, never clobbering, the local
  tweaks you made on purpose**. Touches nothing outside `managed_files`; suggest-only, in git.

## 12. Derived views are regenerated, never hand-cached — from loopkit, unchanged
A roll-up (a reading queue, a people map, a drift list) is its own `type: index-view` note, its body
**regenerated from the graph and stamped** — not hand-maintained, not a live cache. Per-entity
timelines (§8) are the same discipline applied *inside* a note via fenced markers. Reserved
`index.md` / `log.md` are **not** entity nodes.

## 13. Golden context — locked — from loopkit, unchanged
`knowledge/golden/` holds context that must not drift: definitions, hard rules, contracts. Loaded
first, **wins on contradiction**; `distill` never trims it. Don't change anything under `golden/`
without asking. **Promotion:** on "pin this" / "make this golden" / "this is the rule", move the item
into `golden/` after confirming the exact content. (Writing down a *type* is the lighter act — that
goes to `knowledge/templates/`, §4, and isn't locked.)

## 14. Deliverables can be many, and locked in pieces — from loopkit, unchanged
`work/` holds the deliverable(s) — there may be several, and one can be split into section files
finalized one at a time. `locked: true` at the top of a file means treat it like golden — no rewrites
without asking. `query` advances the unlocked parts; `distill` flags an unlocked part that has drifted.
See `work/README.md`.

## 15. Ownership & safety
Write freely in ordinary `knowledge/` notes and **unlocked** `work/` drafts (keep `knowledge/index.md`
honest; preserve keys you didn't write — §3). **Confirm before changing** `knowledge/golden/` and any
`locked: true` file; **propose** changes to `PROJECT.md`. The kit's **engine** is upstream-owned
machinery — the **`sync`** skill (§11) can pull upstream improvements into the files listed in
`loop.manifest.json` (the skills, this `CLAUDE.md`, `FOUNDATION.md`, `DESIGN.md`, `work/templates/`, the
two README machinery docs), **with your approval and preserving any local tweaks** — it *curates*, it
never bulk-overwrites, so a deliberate edit here is safe. Everything else is yours and out of scope for
sync: `PROJECT.md`, your notes and `golden/`, **your `knowledge/templates/` type notes** (the shipped
starters are seed-once — landed in this fork, deliberately *not* managed), and your `work/`. `distill`
is destructive: propose first, apply only what's approved, work in git, prefer tightening over deleting.

## 16. Keep it light
Use only what the platform gives you: skills, this `CLAUDE.md`, plain files. No databases, no
hand-maintained schema grids, **no hand-synced second copy of anything** (no mirrored task list, no
hand-copied timeline, no babysat roll-up — the graph and the regenerate step do that work). Add a type
or a folder only when a real need shows up. Talk to the user about *their* knowledge, *their* tasks,
and *their* deliverable — not about graphs or theory.

## 17. How to ask
Retrieval-grade intake means asking the user a lot — entity matches (§6), an ambiguous alias, which
note to enrich vs. split, whether to retire. Make those asks with the structured **AskUserQuestion**
prompt: a short question and 2–4 concrete options (e.g. the candidate canonical notes), so a
confirmation is one tap, not a paragraph. The user can always pick "Other." Reserve free-text questions
for genuinely open design talk — not for the routine resolve/merge/delete confirmations of curation.
