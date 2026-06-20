> Immutable raw mirror. This is a structured "Full Concept Report" of the eqctrl.io site
> (the "Karpathy+" knowledge/context system), compiled from https://eqctrl.io/ and its
> internal links and supplied verbatim by the maintainer on 2026-06-20 (the site itself was
> unreachable from the ingest environment's network egress allowlist — see repo issue #11).
> Author of the source material: Ethan Ouimet (@entropy_eq / eqctrl). The site documents the
> material as free to fork with credit. Canonical resource: https://eqctrl.io/.
> Note: the author runs GTM at HipAI (listed in the field kit, §18); treat product mentions
> accordingly. Preserved as supplied; do not edit after creation.

---

# eqctrl.io Knowledge/Context System — Full Concept Report

**Compiled:** 2026-06-20
**Source:** https://eqctrl.io/ and all internal links
**Author of source material:** Ethan Ouimet (@entropy_eq / eqctrl)
**Purpose:** Reference for agent work on enhancing knowledge/context graphs
**License note:** Source material is documented as free to fork with credit.

---

## 1. Executive Summary

eqctrl.io documents a complete, opinionated architecture for persistent LLM memory called **Karpathy+**. It is a file-based, model-agnostic knowledge system that gives an AI agent a shared memory between sessions. The core thesis: the context window is RAM, files are disk, and anything that should survive past a single session must live in owned files outside the chat. The system is designed to be built in an afternoon, maintained in minutes per week, and to close the failure mode of "silent drift" — where context diverges from reality without anyone noticing.

The site also documents an **Agent Operations** architecture (six agent archetypes with four governing principles), a **Claude surface/mode/effort guide**, a **Discovery Kit** (structured self-audit prompts), and field notes on enforcement philosophy.

---

## 2. Core Architecture: The Three-Layer Knowledge System

### 2.1 The Layers

The system has three layers, each with a distinct role:

```
Sources ──> Wiki ──> Schema ──> Session
(raw/messy)   (curated)   (~50 lines)   (context-aware LLM)
```

**Sources** (`wiki/sources/`): Raw inputs — transcripts, bookmarks, tool feeds, exports. Deliberately messy. The LLM curates them upward into the wiki layer. These are the unprocessed ore.

**Wiki** (`wiki/`): The curated canonical layer. Target size is 15–30 pages. Maintained by the LLM with human oversight. One durable fact or area per file. This is the "car" — the persistent, owned knowledge that outlasts any particular model.

**Schema** (`CLAUDE.md` or equivalent): Behavior rules plus wiki conventions. Approximately 50 lines. Contains zero knowledge — it only tells the LLM *how to read the wiki*. This is the bootstrap instruction set.

### 2.2 The Boundary Rule

One rule prevents the three-copy drift problem:

> Knowledge goes in `~/AI/` (or `KNOWLEDGE_ROOT`). Runtime goes in `~/.claude/` (or `RUNTIME_ROOT`).

Two clean, separate directories. Never collapsed. The separation IS the rule. This prevents the pattern where the same fact ends up in a rules file, a lessons file, and a corrections file, all drifting apart independently.

**Knowledge side** (`KNOWLEDGE_ROOT`): wiki/, project repos, career/personal/outputs, raw sources before curation.

**Runtime side** (`RUNTIME_ROOT`): Schema (CLAUDE.md), hooks, skills, settings, sessions, history, telemetry, auto-memory.

Inside the knowledge side, nothing sits loose at the root. Every file has a named drawer (bucket). The archive lives outside the fence so searches stay clean.

**Key principle:** Decide what folders your AI's search tools can see before you file anything. Once a tool has a boundary, where you put a file is a choice, not an accident.

### 2.3 Progressive Disclosure

The AI never reads the whole pile. Each session loads:
- The schema (~50 lines, always loaded)
- The index (under 50 lines)
- 2–4 topic pages relevant to the current task

This is the progressive disclosure gate. A system that requires loading everything before working is a system that gets skipped in long sessions. The index tells the model what to read for a given kind of task.

**Critical caveat:** A plan is not enough context on its own. Load the pages it references first. Plans decay faster than the project state they depend on.

---

## 3. The Three Operations

The wiki is not a static collection. It has three operations that keep it alive:

### 3.1 Ingest (Write)

After a fix, a decision, or a correction, the AI updates the page and appends to the log. Each log entry includes a `Judgment:` line — one sentence on *why*. The why is what future sessions actually use, not the what.

Example log entry format:
```
## 2026-06-08 -- moved the archive out of the search path
Searches kept surfacing dead drafts. Moved the archive outside
the knowledge folder; results are clean again.
Judgment: scoped tools decide where files live. State the
scope before filing anything.
```

### 3.2 Query (Read)

At the start of every session: read the index, pick the 2–4 pages that matter, work. The schema's bootstrap directive forces INDEX.md read on every session with no opt-out.

### 3.3 Lint (Check)

Once a week, one command runs a 13-step health checklist:

1. Process the update queue (`.update-queue` file)
2. Freshness check — compare `last_updated` frontmatter against git activity
3. Broken links — scan all pages for markdown links, verify targets exist
4. Task aggregation — collect all `- [ ]` items, age via git blame
5. Log gap check — flag if most recent log entry is >3 days old
6. Unprocessed sources — flag files in sources/ older than 5 days without `processed: true`
7. Log rotation — archive entries older than 30 days
8. Root cleanliness — flag anything not in the approved bucket list
9. Auto-memory drift check — diff key facts between runtime auto-memory and wiki
10. Plan reconciliation — compare plan's `last_reconciled` to `last_updated` of referenced projects
11. Heartbeat — write current timestamp to `.lint-heartbeat`, update INDEX.md
12. Report — present findings: auto-fixed items + needs-attention items for triage
13. Remote sync — optional git add/commit/push

The lint fixes mechanical stuff and asks the human about the rest. Triage responses: `do it` / `defer it` / `kill it`.

**Key rule:** Flag once via lint. Build infrastructure only when the pattern fires twice.

---

## 4. Defense in Depth: The Safety Nets

Discipline alone fails during fires. The system stacks several independent nets, each cheap and a little dumb. They only fail when ALL of them miss at once.

### 4.1 The Enforcement Layers

| Layer | What it catches |
|-------|----------------|
| Schema (house rules, ~50 lines) | Behavioral drift, wrong file placement |
| Session hook (tripwire) | Changed files that need wiki updates |
| Weekly lint (file check) | Stale pages, broken links, unprocessed sources |
| Git history (file check) | What changed and when, archive function |
| Heartbeat (timestamp) | Whether the system is actually running |
| Verifier (output check) | Whether scheduled jobs produced expected output |
| Completion gate (human) | Nothing is "done" until change works + docs reflect it |

### 4.2 Three Enforcement Modes

These split across three modes:

1. **File-state checks** — does the record match reality?
2. **Tripwires** — did a change happen that needs follow-through?
3. **Output verification** — did a scheduled job actually produce its expected output, on time?

One mode is blind to runtime, another is blind to staleness; together they cover the gaps.

### 4.3 The Completion Gate (Constitutional Rule)

Nothing is "done" until all three are true:
1. The change works (smoke test, verification)
2. The docs reflect the change (wiki page + log.md)
3. Any deploy or script change followed its checklist

This is described as the constitutional rule. Skipping it under pressure is the exact failure that caused most past incidents.

### 4.4 The Verifier Contract

Every net reads files. None can see whether a scheduled job is actually running. So each scheduled job declares an expected output path, and a verifier asks one question: did today's file appear? This closes the runtime-state gap.

---

## 5. The Snapshot Problem: Copies Drift, Links Don't

The moment a fact leaves the wiki, the copy stops updating. The AI's own notes, pasted instructions, last month's plan — all snapshots that start aging the moment they're made.

**Propagation is a snapshot.** Auto-memory, UI instructions, and forwarded session prompts are all snapshots, not live references. Copies detach from their source at propagation time. Verify at consumption, not at creation.

**Fix:** Where possible, remove duplicated facts from copies and point them to the wiki. A hardcoded page count will drift. A link cannot.

**Forwarded instructions rule:** When a session starts with a forwarded or terse instruction that references a plan or prior session, treat it as a claim, not a direction. Re-derive scope from current wiki before executing.

---

## 6. Three Causes of Death for Knowledge Systems

Every design choice exists to dodge one of these:

### 6.1 LOAD — Too heavy to read, so it gets skipped
The rules get too long, so the AI stops reading them. A system that only works on turn one doesn't work. Fix: keep the schema under ~80 lines, knowledge goes in pages not rules.

### 6.2 DRIFT — Three files, one fact, no agreement
A rules file, a lessons file, a corrections file. Same knowledge, three places, drifting apart. Two copies of anything will drift. Fix: the boundary rule + single canonical source in the wiki.

### 6.3 SILENCE — Nothing gets written down during a fire
You fix the urgent thing and capture nothing. Weeks later the same problem returns. Fix: defense in depth with mechanical enforcement, not discipline.

---

## 7. Wiki Structure and File Conventions

### 7.1 Directory Structure

```
wiki/
├── INDEX.md              # Read FIRST every session. Catalog + heartbeat.
├── log.md                # Chronological: changes, decisions, judgments
├── system/               # Infrastructure knowledge (ALL-CAPS filenames)
│   └── HOW-THE-WIKI-WORKS.md
├── projects/             # One page per project
├── patterns/             # Reusable patterns, regressions, conventions
├── personal/             # Bio, career, long-form reference
├── plans/                # Forward-looking plans
└── sources/              # Raw input before curation
```

Naming conventions: `system/` files are ALL-CAPS (visually distinct operating-manual pages). Everything else uses lowercase topic names. No archive directory inside wiki — git history IS the archive. Old pages are deleted, not moved.

### 7.2 Page Template

Every page uses a standardized template so lint has a contract and the LLM has a predictable parse target:

```markdown
---
last_updated: YYYY-MM-DD
tags: [project, active]
---
# Page Title

## Status        (project pages only) current state, read first
## Key Facts     quick-reference table or bullets
## Details       prose, the actual knowledge
## Tasks         - [ ] tracked items, - (?) thoughts
## Links         cross-references to other pages
```

Plans get one extra frontmatter key: `last_reconciled: YYYY-MM-DD` — semantically meaning all references in this plan have been re-verified against current project state as of this date. This is distinct from `last_updated`, which bumps on any edit.

### 7.3 INDEX.md Structure

The entry point every session reads. Kept under 50 lines, each line under 150 characters.

```markdown
---
schema_version: 1.2
last_updated: [TODAY]
---
# Wiki Index

Last updated: [TODAY] (N pages across M sections) | Last lint: [TODAY], 0 issues

## Projects
- [project-a](projects/project-a.md) -- [one-line status]

## System
- [HOW-THE-WIKI-WORKS](system/HOW-THE-WIKI-WORKS.md) -- Operating manual

## Patterns
- [regressions](patterns/regressions.md) -- Correction log
```

`schema_version` tracks the wiki's conventions, not its content. Bump it only when a session-visible convention changes (bootstrap directive, bucket taxonomy, mandated trigger phrase). Adding a page or updating a status does not bump it.

### 7.4 The Regressions File

Every mistake the AI makes that the user corrects, one line each, loaded every session. Described as the cheapest behavior change per word. Lives at `wiki/patterns/regressions.md`.

---

## 8. The Schema (CLAUDE.md) — Router, Not Warehouse

### 8.1 The Core Problem with Flat Config Files

The first instinct is to pour everything into CLAUDE.md. It works for a week, then grows until it's too large to load every session and too tangled to maintain. The model carries dead weight and still misses the one thing it needed.

### 8.2 The Pattern

CLAUDE.md stays lean and becomes the *router*: a short file the assistant reads first that tells it to load a wiki index, then pull only the few pages relevant to the work at hand. The *warehouse* is the wiki.

```
CLAUDE.md (always loaded, small)
↓ bootstraps
wiki/index.md (the front door)
↓ loads only what's relevant
topic pages · regressions · running log
```

### 8.3 What Goes Where

**In CLAUDE.md:** The bootstrap instruction ("read the index first"), a handful of non-negotiable rules, and pointers. Nothing that changes weekly.

**In the wiki:** Project state, infrastructure, conventions, regressions file, running log.

**The index:** The one page that tells the model what to read for a given kind of task.

### 8.4 Schema Template Structure

The schema includes these sections:
- **Bootstrap directive** — forces INDEX.md read before any response
- **Wiki instructions** — where knowledge lives, progressive disclosure rules, update queue processing
- **File placement rules** — the bucket taxonomy, prevents stray writes
- **Style rules** — user preferences for tone, formatting, brevity
- **Trigger phrases** — conversational controls ("log this", "do it / defer it / kill it", "switching to [domain]")
- **Forwarded instructions rule** — treat forwarded plans as claims, not directions; re-derive scope from current wiki

---

## 9. The Session Hook (Tripwire)

A Python script that runs at session end and writes changed project-file paths to `wiki/.update-queue`. The next session or lint pass reconciles it.

The hook is a tripwire, not a brain. It records that something changed. A future session reasons about the changes. It can be extended to flag `LOG GAP` when a session's edits skip `log.md` — an unlogged change should trip a wire, not vanish.

---

## 10. Agent Operations Architecture

The site documents a fleet of six agent archetypes governed by four principles.

### 10.1 The Six Archetypes

**1. The Attended Heartbeat** — The day starts with the human at the keyboard. The agent reads the board and drafts a brief. Nothing changes until the human approves, redirects, or defers each item. Only runs while the human is present. You don't automate direction.

**2. Scheduled Drafters** — Run on a clock and produce drafts/proposals. Never publish on their own.
- *Daily Runner*: drafts comments, summaries, next steps for pre-tagged items. Scope: draft + report.
- *Weekly Board Health*: walks the backlog, flags stale items, missing owners, scope drift. Scope: observe + report.
- *Idea Incubator*: takes one-line ideas, works them into short cases with effort estimates. Scope: draft.

Shape: clock fires → agent drafts → agent runs → human gate → review + act (only after ack).

**3. Sweepers & Digesters** — Pull from scattered places and boil down to one short daily digest. Nothing gets missed; not that nothing stays unread.
- *Commitment Sweep*: reads email, meeting transcripts, notes. Extracts promises, deadlines, follow-ups. Scope: read + report.
- *Link Digester*: watches a drop channel, reads/sorts/summarizes each link into buckets (build, reference, inspiration, monitor). Scope: read + triage.

**4. The Responder** — A listener that wakes on mention and replies in-channel. It speaks for the user; it doesn't act for the user. Can't create tasks, move records, or message outside its channel. The line is built into what it can touch, not a rule it's asked to follow.

**5. Intake Pollers** — Turn dropped links and half-formed ideas into sorted, scoped items ready for promotion or deletion.
- *Link Triage Poller*: reads new links, determines purpose, writes summary with suggested next step. Scope: read + sort + draft.
- *Idea Intake*: gathers one-line ideas, groups them, drops duplicates, feeds clean list to the incubator. Scope: collect + organize.

**6. Health & Hygiene Crons** — Recurring checks that report on system health but don't do the work.
- *Smoke Test*: checks key services are answering. Silence means green. Scope: probe + report.
- *Knowledge Hygiene*: walks the knowledge base for stale pages, dead links, aging entries. Staleness thresholds: 30 days for system pages, 90 for reference, 14 after a project last moved. Scope: audit + report.

### 10.2 The Four Governing Principles

**Principle 1: Steward Scope** — Every agent is a steward, not a principal. It drafts and reports; it doesn't decide and ship. The line isn't about what an agent can do — it's about what it can't take back. You can fix a draft before it matters; you can't unsend a message or un-merge code.

A clear yes is the gate. A deliberate act aimed at one specific thing. Doing nothing doesn't count. Not deleting, not complaining — none of that is a yes.

**Principle 2: Glass, Not Load-Bearing** — The dashboard is a window onto the system, not the system itself. Every button maps to a real write into real machinery (a labeled comment, a status change, a channel message). If the dashboard dies, the system keeps running. Timed agents fire on a clock, not on a heartbeat from the dashboard.

**Principle 3: Three Planes** — The system splits into three layers:
- *Work Plane*: system of record (tasks, drafts, history). One source of truth. Both agents and humans write here.
- *Ops Plane*: fleet state (agent events, service health, queue depth, last-moved timestamps). Built from what agents report, not from what the screen shows.
- *Surface Plane*: where the human steers (queue, approve, halt). Reads from ops plane, writes back to work plane through approved actions.

**Principle 4: A Human Gate on Everything That Matters** — Automation earns trust by being predictable. Each agent has a set, checkable scope (list of tools it can use, places it can write). The gate isn't training wheels — it's the design. A well-run fleet never graduates to "fully autonomous." It graduates to faster drafts approved with less friction. The gate stays. What changes is how long it takes to say yes.

---

## 11. Claude Surface/Mode/Effort Framework

### 11.1 The Mental Model

Claude is one model behind multiple interfaces (doors). What changes between them isn't intelligence — it's what Claude can touch: files, the internet, apps, a browser, the clock.

### 11.2 Surface Capability Matrix

| Surface | Your files | Open internet | Your apps | Browser | Clock |
|---------|-----------|---------------|-----------|---------|-------|
| Chat & apps | | | | | |
| Desktop app | † | | | † | |
| Phone | | | † | | |
| Claude Code | ✓ | ✓ | † | † | † |
| Rented server | ✓ | ✓ | † | | ✓ |

(† = with setup)

### 11.3 Memory Rings

Whatever you say lands in the smallest ring unless you put it somewhere that holds:
- **Account memory** (travels with you) — stable facts: role, preferences, tools
- **This Project** (stays on topic) — standing instructions and files for one topic
- **This chat** (resets) — scratch work, session-specific content

When both account memory and Projects cap out, you need a knowledge base — something the AI can read from any door with the same notes loaded. That's what Karpathy+ covers.

### 11.4 Effort Levels

Newer Claude models decide for themselves how long to think. The useful output curve flattens at high effort — the last two settings mostly buy overthinking and second-guessing. The default is right for most work.

### 11.5 Decision Tree for Surface Selection

Follow the first yes:
1. Does it need files on your computer? → Claude Code
2. Does it need email, calendar, or apps? → Desktop with connectors
3. Are you away from your desk? → Phone
4. Should it run by itself on a schedule? → A server
5. None of the above → Just open a chat

---

## 12. Enforcement Philosophy (from Field Notes)

### 12.1 The Model is the Engine; The Memory is the Car

When a new model ships, point it at the same wiki and it picks up where the last one left off — with your context instead of a blank chat. The model is the engine, and the engine swaps. The memory is the car. Stop optimizing the model layer and build a memory layer instead.

### 12.2 Enforcement Must Be Mechanical or Loud, Never Polite

A warning written to a log file nobody reads is functionally identical to no check at all. Enforcement must either fix the problem itself (mechanical) or interrupt someone who will (loud). The middle option — quietly noting the problem — is always a lie.

The rebuilt loop does two things: fixes what it can fix itself, and sends what it can't to a channel the human actually reads. The quiet-log option is eliminated entirely.

### 12.3 Your Dev Machine Lies to You

Checks must run somewhere that disagrees with your development environment. Example: macOS case-insensitive filesystem hides link drift that breaks on Linux. Every manual check run on the forgiving filesystem passed; the automated server check caught the real bug.

---

## 13. The Discovery Kit (Structured Self-Audit)

Eight sequential prompts that take a user from "stuck" to an adopted 90-day plan. Relevant to context systems because it demonstrates a structured progressive-disclosure conversation pattern:

1. **Ground rules** — establish inventory-before-judgment, running STATE summaries
2. **Evidence streams** — six-stream inventory (offerings, time, money, infrastructure, pipeline, life)
3. **Adversary passes** — three attack lenses (skeptic, operations lens, completeness critic)
4. **Interview** — eight questions (four fact, four want), producing four summary sentences
5. **Second lens** — value chain analysis as independent verification
6. **Competing plans** — three rival 90-day plans with named theses, then a synthesis judge
7. **Executable plan** — compile into week-one actions, slip order, ikigai ledger, standing rules, hour budget
8. **Durability** — state document for future chats, weekly refresh prompt, quarterly re-audit prompt

The ikigai ledger assigns every item exactly one verdict: KILL / PARK / HOBBY / BET / FLOOR.

---

## 14. Lineage and Influences

Five sources synthesized into one system:

| Source | Contribution |
|--------|-------------|
| **Karpathy** | The wiki pattern: ingest / query / lint |
| **Atlas Forge** | Compounding agency, nightly extraction |
| **arscontexta** | Progressive disclosure, semantic links |
| **Fraser Cottrell** | Memory folder, schema as behavior |
| **lorepunk** | Creative LLM collaboration |

The compounding principle is the spine. The wiki pattern is the skeleton. The boundary rule, the nets, and the completion gate are the author's answer to the failure modes each source named but didn't fully close.

---

## 15. Known Limits (Stated by the Author)

| Limit | Mitigation |
|-------|-----------|
| Hooks can't think | A hook is a tripwire, not a brain. Weekly check and rules file do reasoning. |
| Checks can't see running software | Everything reads files. A verifier closes the gap by checking scheduled job output. |
| Plans go stale faster than pages | A plan written Monday can be wrong by Friday. Fix: `last_reconciled` date stamp (designed, being built). |
| The rules file has a ceiling | Keep under ~80 lines. Knowledge goes in pages, not rules. |
| Every chat starts blank | Rules file points each session at the index, so there's no state to lose. |
| The AI keeps its own private notes | Those notes live outside the wiki and drift. Boundary rule + weekly diff keeps them honest. |

---

## 16. Common Failure Modes to Preempt

**Over-eagerness:** Don't write five detailed pages in the first session. The system matures through use. Start minimum viable; grow when you notice repeating context.

**Pretending to verify:** If you claim something is current, you checked it this session. Never assert based on remembered state from earlier. Re-read before reporting.

**Fighting progressive disclosure:** The temptation is to read more pages "just in case." Resist it. The rule prevents context bloat; breaking it for one task is how the failure mode returns.

**Creating helper abstractions:** If you're tempted to add a new script or frontmatter field, ask: has this problem fired twice? If no, wait.

---

## 17. Planned Extensions

- Plans will carry a freshness stamp so a stale plan can't pass as a current one (`last_reconciled` key + lint step)
- The weekly check will diff every claim in the AI's private notes against the wiki (full auto-memory audit)
- Real search lands when the wiki outgrows grep (~50 pages)

---

## 18. The Field Kit (Tools Referenced)

| Tool | Role in the system |
|------|-------------------|
| Claude Code | The harness everything runs through |
| HipAI | Context graphs as a product (author works with the team) |
| Moda | Agent workflows run daily |
| Linear | Where the work queue lives |
| Obsidian | The wiki's reading room |
| Granola | Meeting notes that feed the wiki |
| Fathom | Call recordings worth mining later |
| Discord | Where agents check in from the field |

---

## 19. Key Concepts Index for Agent Reference

For quick lookup, the most important concepts for knowledge/context graph enhancement:

- **Boundary Rule** (§2.2): Single canonical location for knowledge vs. runtime
- **Progressive Disclosure** (§2.3): Load index + 2-4 pages, never the whole pile
- **Three Operations** (§3): Ingest/Query/Lint as the living wiki lifecycle
- **Defense in Depth** (§4): Multiple cheap/dumb nets > one smart gate
- **Snapshot Problem** (§5): Copies drift; links don't. Verify at consumption.
- **Three Causes of Death** (§6): Load, Drift, Silence
- **Router Not Warehouse** (§8): CLAUDE.md as front door, not knowledge store
- **Completion Gate** (§4.3): Nothing done until change works + docs reflect it
- **Judgment Lines** (§3.1): Log the *why*, not just the *what*
- **Steward Scope** (§10.2): Draft and report, never decide and ship
- **Three Planes** (§10.2): Work/Ops/Surface separation
- **Glass Not Load-Bearing** (§10.2): Dashboard is a window, not the system
- **Mechanical or Loud** (§12.2): Enforcement must fix or interrupt, never quietly note
- **Plans Decay Faster Than Pages** (§7.2): `last_reconciled` vs `last_updated`
- **Schema Version** (§7.3): Tracks conventions, not content

---

*Source: eqctrl.io by Ethan Ouimet. Content documented as free to fork with credit.*
