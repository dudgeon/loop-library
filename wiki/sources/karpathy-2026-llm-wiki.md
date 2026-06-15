---
type: Source
title: 'Karpathy — "LLM Wiki"'
description: Karpathy's pattern for building personal/team knowledge bases where the LLM incrementally compiles and maintains an interlinked markdown wiki instead of re-deriving answers via RAG.
tags: [knowledge-base, ingest, query, lint, agent-harness]
authors: [Andrej Karpathy]
published: '2026-04'
timestamp: 2026-06-14T00:00:00Z
resource: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
raw_mirror: ../sources/karpathy-2026-llm-wiki.md
---

# Karpathy — "LLM Wiki"

An "idea file" describing a pattern for knowledge bases built with LLMs. Instead of RAG —
where the model rediscovers knowledge from raw chunks on every query, with no accumulation —
the LLM **incrementally builds and maintains a persistent, interlinked wiki** that sits
between the human and the raw sources. Knowledge is *compiled once and kept current*, not
re-derived per query. The human curates sources, explores, and asks questions; the LLM does
all the reading, summarizing, cross-referencing, filing, and bookkeeping. Deliberately
abstract — meant to be handed to an agent that co-instantiates a concrete version.

# Key points
- **Three layers:** immutable **raw sources** (LLM reads, never writes) → the **wiki**
  (LLM-owned compiled markdown) → the **schema** (`CLAUDE.md`/`AGENTS.md`) that makes the
  LLM a disciplined maintainer rather than a generic chatbot.
- **Three operations:** **Ingest** (source → summary + updated entity/concept pages + index +
  log; one source may touch 10–15 pages), **Query** (read index → read pages → answer with
  citations; file good answers back as pages), **Lint** (periodic health check:
  contradictions, stale claims, orphans, missing pages, data gaps).
- **Two navigation files:** `index.md` (content catalog, read first) and `log.md`
  (append-only chronological record with grep-able prefixes).
- **Why it works:** the real cost of a knowledge base is *bookkeeping*, not reading/thinking;
  humans abandon wikis because maintenance outgrows value; LLMs "don't get bored… can touch
  15 files in one pass," so maintenance cost approaches zero.
- **Lineage:** an instance of Vannevar Bush's Memex (1945), with the LLM solving the
  "who does the maintenance" problem.
- Modular and optional: index-based navigation replaces embedding RAG at moderate scale
  (~100 sources); add a real search tool (e.g. `qmd`) only when the wiki outgrows the index.

# Notable excerpts
- "the wiki is a persistent, compounding artifact. The cross-references are already there.
  The contradictions have already been flagged."
- "You never (or rarely) write the wiki yourself — the LLM writes and maintains all of it."
- "Obsidian is the IDE; the LLM is the programmer; the wiki is the codebase."
- "LLMs don't get bored, don't forget to update a cross-reference, and can touch 15 files in
  one pass."
- "good answers can be filed back into the wiki as new pages… your explorations compound."

# Compiled into
- [Ingest → Query → Lint loop](/loops/automation/ingest-query-lint.md)
- [Progressive disclosure](/concepts/progressive-disclosure.md)
- [Provenance](/concepts/provenance.md)
- [What makes a knowledge loop robust](/synthesis.md)
