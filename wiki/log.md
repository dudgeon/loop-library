# Loop Library — log

Chronological, newest-first. Grep recent activity:
`grep -nE '^- (ingest|query|lint|supersede)' wiki/log.md`.

## 2026-06-15
- query  | filed comparison: loopkit ↔ root (/comparisons/loopkit-vs-root.md) — correspondence + which v0 decisions the root adopts vs rejects (root = reference impl, kit = distilled floor).
- lint   | COLLAPSED the generated loop registry (loops.registry.json + gen-loops.* + LOOPS.md + the lint check) → hand-maintained loops list in loop/README.md; aligns root with loopkit (no generated map). Documented lint = loopkit's distill.
- lint   | DECOUPLED registry from wiki: a registry must travel with any repo that *uses* loops (no research wiki there). gen-loops no longer reads wiki frontmatter; loops.registry.json is self-contained; `catalog` is an optional cross-ref link. Refined H6.
- lint   | clarified registry model: loop/LOOPS.md = loops ACTIVE in this project (instances) + status; wiki = catalog of loop *types*. Inverted gen-loops drift-check (no longer flags unregistered catalog pages); added Status column + dashed non-active nodes.
- lint   | session-harvest → alpha skill (.claude/skills/session-harvest/) + repo heuristics doc (loop/intent-heuristics.md, not gated in skill); added Mechanism diagrams to session-harvest + ingest-query-lint pages; updated session-harvest hedge.
- query  | reframed: a project hosts a PORTFOLIO of loops, not one (H5–H7 in loop/); filed Session-Harvest Loop design (/loops/automation/session-harvest.md); opened T3 (loop registry + viz) + T4 (session-harvest).
- supersede | WITHDREW vanilla-loop kit from dist/ — shipped prematurely from a notional idea. dist/ now governed by a promotion bar (CLAUDE.md §8); goal-directed-task-loop demoted to unvalidated hypothesis + open research question.
- query  | repo purpose defined (build vendorable loop kits + a research loop) — filed Goal-Directed Task Loop (/loops/agentic/goal-directed-task-loop.md); updated synthesis.
- lint   | wired dist/ (Purpose 1): vanilla-loop kit documented as a wiki loop; indexes updated.

## 2026-06-14
- ingest | OKF blog (Google Cloud) — added source concept; informs progressive-disclosure + synthesis.
- ingest | OKF Specification v0.1 — added source concept; informs progressive-disclosure, provenance, ingest-query-lint loop, synthesis.
- ingest | Karpathy "LLM Wiki" — added source concept; compiled the ingest-query-lint loop and the progressive-disclosure + provenance concepts.
- lint   | bootstrap — established the bundle: root index (okf_version 0.1), per-directory indexes, synthesis (draft).
