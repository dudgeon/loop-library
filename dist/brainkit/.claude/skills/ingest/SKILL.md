---
name: ingest
description: Capture new material into this project's graph as a typed entity — resolve what it mentions to canonical notes (with you, at capture), expand its shorthand and link it, preserve the raw, append to any touched entity's timeline, and extract the reusable knowledge and tasks. Use whenever the user shares or refers to something the brain should remember — a call, a meeting note, a doc, a decision, a person, a task, a link.
---

# ingest

Fold new material into `knowledge/` as a typed entity, resolved and enriched so it's findable later,
and wired into the graph. Read `CLAUDE.md` first (the contract — §3 notes, §5 links, §6 resolution,
§7 enrichment, §8 timelines, §9 tasks).

## Steps
1. **Orient.** Read `PROJECT.md` (goal, work products, the `task_policy:` line, what's golden),
   `knowledge/index.md`, and the `knowledge/templates/` types so you know the kinds and definitions in
   play.
2. **Resolve, with the user (§6).** Turn vague references into canonical notes *now*, while the user
   has the context — don't store a vague reference or a silent flag. Vault-first: when a Duo vault is
   present read `duo vault schema` (types/entities/**aliases**); else resolve against existing notes →
   `golden/` → **ask**. When you resolve a shorthand, **write the alias onto the canonical entity note**
   (`aliases: [...]`) so next time auto-resolves. Never invent a name you can't verify.
3. **Enrich + preserve raw (§7).** Produce **one** enriched note that represents the source — acronyms
   expanded, entities linked (`the vendor` → `[Acme](./acme.md)`), terms canonical. Keep the verbatim
   original in a `## Raw` section (external-link only if that original is durable and immutable, and
   even then snapshot key excerpts in-file). The enriched body is a faithful transform, **not** the
   fidelity record — don't dump raw as the body, and don't make a separate "clean twin."
4. **File it** as a typed note with the floor — `summary:`, `type:`, `source:` — plus a `status:` from
   the type's ladder and whatever else it needs. **Preserve any frontmatter key you don't recognize**
   (an `id:`, an `owner:`); never mint an `id:`. If it extends an existing entity, enrich that note
   instead of making a near-duplicate.
5. **Link it (§5)** with relative-markdown edges — `[label](./other-note.md)`, never `[[wikilink]]`,
   never absolute. Put a payload (a citation's key quote, `requested_by`) in frontmatter next to the
   link. If one input decomposes into several notes, **copy the source/attribution edge onto each
   child.**
6. **Append timelines (§8).** For each entity the note **touches** — *an attendee or an explicitly-
   linked subject*, not an incidental mention — that carries `timeline: true`, append a dated one-line
   entry **inside** its `<!-- BEGIN generated:timeline -->` / `<!-- END generated:timeline -->` markers,
   pointing back to this note. (Incidental F3-enrichment mentions do **not** append.)
7. **Extract knowledge and tasks.**
   - *Knowledge:* pull genuinely reusable ideas/decisions into their own atomic `note`/`decision`
     entries with a lineage edge back carrying the key quote. One idea per note, named by what it
     teaches. Don't duplicate — enrich an existing note and add a citation. If a candidate would mostly
     restate the passage, it's a cleaned copy — skip it.
   - *Tasks (per `task_policy`, §9):* recognize action items. **Embodied** → a `type: task` node with
     owner / `requested_by` / `due` / `status: open` / a **`parent`** edge (refuse an edge that closes
     a cycle — walk the chain first). **Externalized** → hand off, keep only a pointer edge.
     Attribution and parentage ride edges that survive a split. Never write a task into a second file.
8. **Update `knowledge/index.md`.**

## Don'ts
Don't store a vague reference you could have resolved with the user. Don't dump raw material as the
note body, or make a synced clean-twin of a source. Don't append a timeline entry for an incidental
mention. Don't mirror a task into another file. Don't strip a frontmatter key you didn't write, mint an
`id:`, touch `golden/` or locked files, or author a big schema up front.
