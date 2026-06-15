# SPEC-loop.md — the per-page schema

The on-disk contract for every concept in the `wiki/` bundle. It is **OKF v0.1-conformant**
(required `type`, path-as-identity, untyped markdown links, reserved `index.md`/`log.md`)
**plus** the Karpathy/provenance extensions this library adds. Unknown keys are tolerated
and **preserved on rewrite**.

Scope note: this library covers **agentic** and **automation/workflow** loops (per the
human's decision). Systems-thinking fields like `polarity` are *optional extras*, not part
of the core spine.

---

## Frontmatter

```yaml
---
# --- REQUIRED (OKF conformance) ---
type: Loop                 # non-empty. Controlled vocab (see _meta/taxonomy.md):
                           #   Loop | Pattern | Anti-pattern | Concept |
                           #   Comparison | Source | Overview | Synthesis
                           # Consumers MUST tolerate unknown values (treat as generic).

# --- RECOMMENDED (OKF surface) ---
title: ReAct Loop          # human-readable display name; if omitted, derive from filename
description: An agent loop that interleaves reasoning with tool actions, observing each
             result before the next step.   # exactly one sentence; used by index generators
tags: [agentic, reasoning, tool-use, plan-act-observe]   # short, lowercase, hyphenated;
                                                         # drawn from _meta/taxonomy.md
timestamp: 2026-06-14T00:00:00Z             # ISO 8601 of last meaningful change
resource: https://arxiv.org/abs/2210.03629  # OPTIONAL canonical URI of the underlying
                                            # artifact (paper/tool/system). Omit if abstract.

# --- LOOP-SPECIFIC (producer extensions; OKF permits arbitrary keys) ---
loop_family: agentic       # agentic | automation   (top-level kind; see taxonomy)
cadence: per-step          # per-step | per-request | continuous | scheduled | event-driven
trigger: subgoal-or-user-request     # what starts one iteration
exit_condition: goal-satisfied-or-max-steps   # how the loop terminates (first-class for loops)
maturity: stable           # stable | emerging | experimental | deprecated
status: active             # active | draft | superseded
aliases: [reason-act loop] # alt names, for search recall

# --- PROVENANCE (this hybrid's load-bearing addition) ---
summary: Interleaves chain-of-thought reasoning with environment actions so each action is
         conditioned on prior observations.   # 1–2 sentence preview, written at creation time
provenance: extracted      # extracted (cited source) | inferred (synthesis) | ambiguous (disagree)
confidence: 0.9            # OPTIONAL 0–1; enables memory-style decay / supersede passes
sources: [/sources/yao-2022-react.md]   # bundle-relative links to the Source concepts this
                                        # page compiles from. NON-EMPTY for Loop/Concept/
                                        # Pattern/Anti-pattern/Comparison pages.
related: [/loops/agentic/reflexion.md, /concepts/termination-conditions.md]   # cross-links;
                                        # relationship TYPE described in body prose
supersedes:                # concept ID this page replaces, if any (clean evolution)
---
```

### Conformance minimums
- **Any concept:** a parseable frontmatter block with a **non-empty `type`**. That's it.
- **Loop / Pattern / Anti-pattern / Concept / Comparison pages:** additionally require a
  non-empty `summary`, a non-empty `sources:`, a `provenance:` value, and a `# Citations`
  section in the body.
- **Source pages (`type: Source`):** require `resource:` (canonical URL) and SHOULD set
  `raw_mirror:` (path to the immutable mirror under `/sources/`, repo-relative, e.g.
  `../sources/karpathy-2026-llm-wiki.md`) and `authors:`.

### Identity & links
- **Concept ID = file path under `wiki/` minus `.md`.** No separate `id`.
- **Links** are bundle-relative absolute (`/loops/...`), resolved from `wiki/`. Untyped —
  meaning lives in prose. Broken links = not-yet-written knowledge (tolerated).

---

## Body conventions (favor structural markdown)

For a **Loop / Pattern** page, use these headings where applicable:

| Heading | Contents |
| --- | --- |
| `# Mechanism` | the iteration: what happens each cycle (numbered steps or an inputs→step→outputs table) |
| `# When to use` / `# When not to` | the conditions that make the loop fit / misfit |
| `# Failure modes` | non-termination, oscillation, runaway cost, context bloat (table form) |
| `# Examples` | concrete instances |
| `# Relationships` | prose stating the TYPE of each link in `related:` (OKF links are untyped) |
| `# Citations` | numbered `[1] [Title](url-or-/path)`; targets may be URLs or in-bundle paths |

For a **Concept** page: a short definition, why it matters for loops, how it shows up across
loop families, then `# Relationships` and `# Citations`.

For a **Source** page (`type: Source`): a one-paragraph digest, a `# Key points` list, a
`# Notable excerpts` block (short verbatim quotes), and `# Compiled into` (links to the wiki
pages built from it).
