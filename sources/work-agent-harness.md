# work-agent-harness (WAH) — source mirror

> **Immutable mirror (LAYER 1).** A faithful digest of the `work-agent-harness` repo as read on
> 2026-06-18, with verbatim excerpts of its load-bearing rules. WAH is a repo, not a single document;
> this mirror captures its model and quotes the parts the wiki compiles from. Do not edit to "improve"
> it — it is the record of what the source said.
>
> - **Repo:** https://github.com/dudgeon/work-agent-harness
> - **Local mirror read:** `/Users/geoffreydudgeon/VSC Projects/work-agent-harness`
> - **Author:** dudgeon · **Captured:** 2026-06-18

## What it is

> "A reusable framework for AI-assisted knowledge work in private corporate contexts." A structured
> harness for product managers (and similar knowledge workers) to collaborate with AI coding agents
> (Claude Code, Windsurf Cascade) on **non-SWE** tasks, under corporate constraints (no cloud beyond
> GitHub), agent-portable (`AGENTS.md` primary, `CLAUDE.md` + `.windsurf/` thin mirrors).

Lineage: "inspired by [home-brain] … a personal knowledge management system that demonstrates:
Inbox → triage → domain flow … Skills-based workflows … Philosophy-driven behavior … Self-reflection
patterns where agents propose improvements to their own instructions."

## The model (how WAH organizes knowledge)

- **Fractal domain hierarchy.** "Domains nest to unlimited depth. Every level behaves identically —
  same templates, same linking conventions … Every level is just a domain with a README.md."
- **Concept-centered notes.** "Most domain files are built around concepts: frontmatter, evergreen
  definition, reverse-chronological timeline."
- **GitHub-native relative links only.** "No wikilinks — this is a GitHub repo … Over-link rather
  than under-link."
- **Endogenous vs imported** knowledge is marked with its origin (≈ a provenance flag).
- **Context vs domain.** Cross-domain material lives in `context/` (e.g. `context/stakeholder-map.md`,
  company info); domain-owned material lives in the domain.
- **`tasks.md` is the cross-domain source of truth**, with **mirrors** in domain files: "Tasks may
  also appear in domain files as mirrors for local context — `tasks.md` is authoritative when they
  disagree."

## Entity verification — the resolution subroutine (verbatim)

> "## Resolution Order — When resolving an entity, check these in order:
> 1. **Context files** — `context/*.md` (company info, stakeholder map, team details)
> 2. **Domain files** — relevant domain notes, project files, concept files
> 3. **Web research** — search to confirm details, find canonical names, get links
> 4. **Ask the user** — only after exhausting the above"

> "**Hallucinating 'better' names.** Never invent a more specific or formal-sounding name. An
> unverified upgrade is worse than a vague original. If you can't verify, store what you have and flag
> it." … "'The analytics tool' should become 'Amplitude' (with link). 'Sarah's manager' should become
> 'Sarah Chen's manager, David Park (VP Engineering).'"

## Inbox triage — the process pass (verbatim highlights)

> "1. List items in `inbox/` … 2. Read each note 3. **Enrichment pass**: annotate answerable
> questions and resolvable references with CriticMarkup … 4. Detect new or existing entities … 5.
> **Update entity timelines**: add hub-and-spoke entries for people and projects … 9. Move to
> appropriate domain folder … 10. **Check for domain emergence** … 12. Archive processed item to
> destination domain's `_archive/YYYY-Www/`."

- **CriticMarkup enrichment** — `{>>YYYY-MM-DD @agent: Annotation text. See [entity](path)<<}`, placed
  inline, **preserving the original text**. "Only annotate from **existing WAH content** … Never from
  web searches, speculation, or general knowledge."
- **Hub and spoke timelines** — "**Hub**: The archived meeting note in the destination domain's
  `_archive/` … **Spokes**: Person entities and project notes each get a lightweight timeline entry
  pointing back to the hub."
- **Domain emergence + bounded backfill** — clustering signals a new domain; "Backfill runs **once at
  domain creation**, not continuously."

## Source → knowledge synthesis (verbatim highlights)

> "**The pattern in one sentence**: Sources are raw material; knowledge entries are the refined
> product; lineage connects them."

- Domains opt in via README frontmatter `pattern: domain-source-synthesis` + `source_types: […]`.
- **Source status ladder:** `unread → reading → read → processed`.
- **Knowledge status ladder:** `status: draft|solid|canonical` (`draft` initial extraction → `solid`
  validated by multiple sources/deep experience → `canonical` well-established).
- **`origin`:** `sourced | organic | both`. **`featured`:** ideas worth championing.
- **Stakeholder feedback + attribution that survives decomposition** — `attribution:` on the source
  points to the stakeholder's file; every extracted item carries `requested_by: stakeholder-name`
  "regardless of which subdomain it lands in." "**Attribution must survive decomposition.**"
- **Atomicity:** "One idea per knowledge entry … Name entries by what they teach, not where they came
  from." "**Lineage is the whole point.**" "**Don't duplicate, enrich.**"
- **Emergent taxonomy:** "Let the taxonomy emerge from the content, don't impose one preemptively" —
  a `meta/taxonomy.md` only when entries reach ~15–20.

## Stakeholder intelligence (verbatim highlights)

- **Relationship proximity (a spectrum, not rigid tiers):** "**Close collaborators** … **Regular
  contacts** … **Extended network** — Lightweight entries." Lives in `context/stakeholder-map.md`
  (cross-domain index) + individual profile files for closer contacts.
- "**One-sided updates.** When a meeting involves 4 people, all 4 profiles need updating … This is the
  most common mistake."

## Template propagation (verbatim highlights)

- Templates carry `version:` + a `changelog:`; derived docs carry `template:` + `template_version:`.
  When the template version exceeds a doc's, the doc is a propagation candidate. Changes are
  additive / structural / clarifying / subtractive; "**Always ask the user** before removing content."

## Domain lifecycle spec (`meta/specs/domain-lifecycle.md`, status: draft)

A **strategy → execution → feedback** envelope over domains: a `## Roadmap` (current focus, open
questions, goals), Projects, Tasks, optional PRDs; execution = source processing + work activity;
feedback = domain synthesis + a domain changelog; "insights feed **up** into strategy." Explicitly a
**child-of-strategy** reframing of source synthesis. (Still a draft with open questions Q1–Q5.)

## Skills house style (verbatim)

> "Skills should read like guidance from an experienced colleague, not a software spec:
> `## When This Applies` … `## The Goal` … `## How to Think About It` … `## Watch Out For`."
> "Skills encode **judgment patterns**, not mechanical checklists." "**Don't Over-Skill** … one-off
> requests, simple single-step tasks, things that vary too much, workflows still being refined."

## Self-improvement (verbatim)

> "After sessions with meaningful friction, proactively retro: 1. **Surface findings** … 2. **Propose
> instruction updates** … 3. **Ask permission** … before modifying any instruction files." Agents
> "Notice friction … Propose specific instruction updates … Get user approval … Learn from mistakes
> without being told."

## Cross-agent machinery (out of scope for a single-agent kit)

`AGENTS.md` is primary; `CLAUDE.md` + `.windsurf/rules|skills` are **mirrors** kept in sync via an
`agent-control-mirror-sync` rule + skill. A publishing/sync pipeline (filter, publish subsets to
public repos, push back to origin) is named as a goal but largely unbuilt ("Open Questions").

## Why it matters to the Loop Library (relevance)

WAH **hand-rolled the entity-graph KM system that a Duo OKF vault provides natively** — typed entity
files, an entity-resolution subroutine, a hand-built link graph (hub-and-spoke timelines, a
cross-domain stakeholder map, source→knowledge lineage, attribution edges that survive
decomposition), emergent-then-encoded taxonomy, and maturity ladders. It is prior art for the
entity-foundation work (loopkit) and the application layer built on it (brainkit).
