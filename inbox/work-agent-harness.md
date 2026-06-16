# INBOX — staged source (awaiting human-approved ingest)

> Raw drop per `CLAUDE.md` §3. **Not** auto-promoted to `sources/` or `wiki/`. Ingest only on the
> human's go. Captured 2026-06-15.

## Source: work-agent-harness (WAH)

- **Repo:** https://github.com/dudgeon/work-agent-harness
- **Local mirror on this machine:** `/Users/geoffreydudgeon/VSC Projects/work-agent-harness`
- **Author:** dudgeon
- **What it is:** a reusable, vendorable harness for AI-assisted *knowledge work* (PM-style, not
  SWE) in private corporate contexts — pure GitHub + local, agent-portable (Claude Code / Windsurf).
  Lineage: inspired by `home-brain` (personal KM). Inbox → triage → domain flow, skills-as-judgment,
  philosophy-driven behavior, self-reflection/recursive improvement.

## Why it belongs in the Loop Library (the relevance)

WAH is **prior art for an entity-graph knowledge system** — and the key research finding is what it
reveals about loops + vaults:

- **WAH hand-rolled the entity structure that a vault provides natively.** Typed entity *files*
  (people, projects, orgs, sources, stakeholders) from templates; an **entity-resolution** subroutine
  (`entity-verification`: resolve a vague mention → canonical entity + link, in order *context files
  → domain files → web → ask*); a **graph** built by hand (hub-and-spoke meeting-note→entity
  timelines, a cross-domain stakeholder map, source→knowledge **lineage**, `requested_by` /
  `attribution` edges that survive decomposition); **emergent-then-encoded taxonomy**
  (`meta/taxonomy.md` written only when volume warrants); and **maturity ladders** everywhere
  (`unread→read→processed`; `draft→solid→canonical`; entity proximity close/regular/extended).
- **Duo's OKF Note Vault is the productized version of that same model** — typed entities + templates,
  `vault schema` (≈ WAH's `context/` resolution table), aliases (≈ entity resolution), D19 filing
  (≈ domain routing), `graph backlinks` (≈ hub-and-spoke), capture→inbox→process (≈ `inbox-triage`).
  So the structure WAH built by hand is **vault-native**.

## The strategic frame (load-bearing for loopkit design)

**Build the next WAH _on_ loopkit, not _in_ it.** Loopkit should be the **entity-graph foundation**
on a Duo OKF vault (typed resolved entities + the link graph + emergent taxonomy) — **less expressive
than WAH**. WAH's richer pieces (domains, stakeholder proximity, source-synthesis lifecycle,
roadmaps/changelog, template-propagation) are the **application layer built on top**, not baked into
loopkit. The design constraint: **don't let loopkit's foundation foreclose those future pieces.**

## Key WAH skills/specs to compile on ingest (the model in detail)

- `skills/entity-verification.md` — the resolution-order subroutine (the heart of entity resolution).
- `skills/inbox-triage.md` — the process pass: decompose → resolve entities → hub-and-spoke timeline
  updates → CriticMarkup enrichment → file in domain → **domain-emergence** detection → archive.
- `skills/domain-source-synthesis.md` — source lifecycle (capture→read→process→extract), lineage,
  emergent taxonomy, `pattern:`-flag domain adoption.
- `skills/stakeholder-intelligence.md` — entities + relationship proximity + the stakeholder map.
- `skills/template-propagation.md` — typed-entity templates with `template`/`template_version`.
- `meta/specs/domain-lifecycle.md` — strategy→execution→feedback lifecycle over domains.
- `skills/README.md` — house style: skills "read like guidance from an experienced colleague, not a
  software spec" (When This Applies / The Goal / How to Think About It / Watch Out For).

## Suggested ingest framing (for when approved)

A Source concept + a Comparison page (`WAH ↔ Duo-vault entity structure` — "hand-rolled vs native")
and a feed into the loopkit-on-Duo design (entity-core foundation; foreclosure constraints).
