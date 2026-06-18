---
type: Source
title: work-agent-harness (WAH)
description: A vendorable harness for AI-assisted PM-style knowledge work (pure GitHub + local, agent-portable) that hand-rolls an entity-graph KM system — typed entity files, an entity-resolution subroutine, hub-and-spoke timelines, a stakeholder map, source→knowledge lineage with attribution that survives decomposition, emergent taxonomy, and maturity ladders.
tags: [knowledge-base, entity-graph, ingest, query, lint, agent-harness, provenance, prior-art]
authors: [dudgeon]
published: '2026'
timestamp: 2026-06-18T00:00:00Z
resource: https://github.com/dudgeon/work-agent-harness
raw_mirror: ../sources/work-agent-harness.md
---

# work-agent-harness (WAH)

A reusable harness for **AI-assisted knowledge work** (product-management-style, not SWE) in private
corporate contexts — pure GitHub + local, agent-portable across Claude Code and Windsurf. Descended
from `home-brain` (personal KM). Its load-bearing relevance to this library: **WAH built, by hand,
the typed-entity graph that a Duo OKF Note Vault provides natively** — making it the prior art behind
[loopkit](/concepts/loopkit-on-duo.md) (the entity-graph foundation) and [brainkit](/concepts/brainkit.md)
(the application layer rebuilt on that foundation without WAH's hand-rolled machinery).

# Key points

- **Hand-rolled entity graph.** Typed entity *files* (person, project, org, source, stakeholder) from
  templates; a **fractal domain hierarchy** ("every level is just a domain with a README.md"); concept
  notes with frontmatter + evergreen body + reverse-chronological timeline; GitHub-native relative
  links only.
- **Entity-verification subroutine.** A resolution **order** — context files → domain files → web
  research → ask the user — with a hard "never invent a 'better' name you can't verify" rule. Called
  by other skills, not usually invoked directly.
- **Inbox → triage → domain** process pass: read → **CriticMarkup enrichment** (annotate from
  existing content, preserving the original text) → entity detection → **hub-and-spoke timeline**
  updates → file in domain → **domain-emergence** detection + bounded backfill → archive.
- **Source → knowledge synthesis.** "Sources are raw material; knowledge entries are the refined
  product; lineage connects them." Source ladder `unread→reading→read→processed`; knowledge ladder
  `draft→solid→canonical`; `origin: sourced|organic|both`; **attribution (`requested_by`) survives
  decomposition** across subdomains.
- **Stakeholder intelligence.** Relationship **proximity** as a spectrum (close / regular / extended);
  a cross-domain `context/stakeholder-map.md`; "when a meeting involves 4 people, all 4 profiles need
  updating."
- **Template propagation.** Templates carry `version:`; derived docs carry `template_version:`;
  structural changes propagate, "always ask before removing content."
- **Emergent-then-encoded taxonomy** (`meta/taxonomy.md` only when volume warrants); **maturity
  ladders everywhere**; **self-reflection / session retros** propose edits to the agent's own skills.
- **Domain-lifecycle spec (draft).** A strategy→execution→feedback envelope (roadmaps, open questions,
  goals, PRDs, domain changelog) over domains — explicitly beyond knowledge compilation.
- **Cross-agent + publishing machinery.** `AGENTS.md` primary with `CLAUDE.md`/`.windsurf` **mirrors**
  kept in sync; a publishing/sharing pipeline named as a goal (largely unbuilt).

# Notable excerpts

- "Sources are raw material; knowledge entries are the refined product; lineage connects them."
- "Never invent a more specific or formal-sounding name. An unverified upgrade is worse than a vague
  original."
- "**Attribution must survive decomposition** — every extracted item … must carry
  `requested_by: stakeholder-name` regardless of which subdomain it lands in."
- "Tasks may also appear in domain files as mirrors for local context — `tasks.md` is authoritative
  when they disagree." *(the hand-synced-mirror pattern this library treats as a breaker)*
- "Skills should read like guidance from an experienced colleague, not a software spec."

# Compiled into

- [WAH ↔ Duo-vault entity structure — hand-rolled vs native](/comparisons/wah-vs-duo-vault.md)
- [brainkit — the WAH application layer rebuilt on loopkit](/concepts/brainkit.md)
