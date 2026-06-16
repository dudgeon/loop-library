# Loop Library — log

Chronological, newest-first. Grep recent activity:
`grep -nE '^- (ingest|query|lint|supersede)' wiki/log.md`.

## 2026-06-16
- supersede | REDIRECTED loopkit design: the progressive-enhancement / prose-vocabulary spec under-read the goal. New spec _meta/SPEC-loopkit-entity-foundation.md — loopkit = the entity-graph FOUNDATION the next work-agent-harness is built ON, not IN (typed type: nodes, payload-bearing rel-md edges, resolution leaning on the Duo vault, emergent→encoded taxonomy as templates). Designed + foreclosure-tested by a 23-agent pass (0 future WAH pieces foreclosed; 9 at-risk → affordances; 4 mechanisms flagged "still to design"). Old SPEC-loopkit-on-duo.md + PR #6 parked; loopkit-on-duo.md banner updated; T7 redirected + T8 opened.
- ingest | STAGED work-agent-harness in inbox/ (spec + repo link, awaiting approved ingest) — WAH hand-rolled the entity structure a vault provides natively; the relevance for the entity-foundation redesign.
- query  | SPEC written: _meta/SPEC-loopkit-on-duo.md (golden candidate) — loopkit as a Duo-optional OKF vault. Hardened by an adversarial multi-agent pass (18 agents; 3 blockers + 4 majors + 23 completeness items). REFRAME: schema-as-a-file rejected (violates loopkit §7 + Duo no-sidecar) → encoded vocab = golden PROSE, "observed" rung computed live. A–D resolved (A overridden: keep kind:); re-derivation guarantee is query-path only. Reconciled loopkit-on-duo.md to point at the spec; T7 → active. Ground-truth re-verified vs shipped skills + sync.sh.
- ingest | Duo "OKF Note Vault" (vault skill ref, ENH-208·216) — staged in inbox (approved), mirrored byte-identical to /sources/duo-2026-note-vault.md, wrote Source concept /wiki/sources/duo-2026-note-vault.md; re-grounded duo-vault-vs-wiki + loopkit-on-duo (resolved the prior ingest FLAG, T6 done). Pages stay provenance:inferred (framing is synthesis; Duo facts now sourced).
- query  | filed comparison: Duo Note Vault ↔ wiki/loopkit (/comparisons/duo-vault-vs-wiki.md) — same OKF substrate, three operating models; vault as candidate runtime. Filed design: Loopkit on Duo (/concepts/loopkit-on-duo.md) — progressive enhancement, unvalidated, not shipped.
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
