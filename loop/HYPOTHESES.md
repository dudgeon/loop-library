# Hypotheses — root (meta) loop

Beliefs we hold with some confidence but have **not validated**. Distinct from `wiki/` (sourced
knowledge) and `TASKS.md` (work). A hypothesis graduates into `wiki/` knowledge when grounded, or
into a `dist/` primitive when proven. Alpha — add/revise freely.

| id | hypothesis | confidence | status |
| --- | --- | --- | --- |
| H1 | Goal definition is an enduring loop primitive | medium | open |
| H2 | A defined work product is an enduring loop primitive | medium | open |
| H3 | Tasks / sub-goals are a loop primitive worth defining | medium | open |
| H4 | These primitives are enduring and recur at every loop level (root and `dist` alike); a validated version is itself shippable | low–medium | open |
| H5 | A project hosts a **portfolio of loops** (≥2), not one; the unit of analysis is the set, not a single loop | medium | open |
| H6 | Loops accrete over time and are encoded heterogeneously (skills, agents, `CLAUDE.md`, `loop/`), so a project needs an explicit **loop registry** to track where each loop lives and its primitives | medium | open |
| H7 | A self-improving meta-loop (e.g. `session-harvest`) that revises project intent/heuristics from session evidence is a high-value loop class — and is itself the recursive improvement this library studies | low–medium | open |

## H1 — Goal definition is an enduring loop primitive
Every loop has a persistent goal that outlives any single iteration — even a minimal or
self-referential one ("make a great KB"). **Validated by:** recurring goal-definition across
loop types (supports) / a useful loop with no definable goal (refutes). **Links:**
[`GOAL.md`](GOAL.md), [goal-directed-task-loop](../wiki/loops/agentic/goal-directed-task-loop.md).
_(Your hypothesis, 2026-06-15.)_

## H2 — A defined work product is an enduring loop primitive
Every loop produces or maintains a work product; it may be **self-referential** (the root loop's
work product is this repo). **Validated by:** a useful loop with no identifiable work product
(refutes). **Links:** [`GOAL.md`](GOAL.md). _(Your hypothesis, 2026-06-15.)_

## H3 — Tasks / sub-goals are a loop primitive
Loops decompose into tasks / sub-goals, and defining this primitive is likely necessary.
**Validated by:** whether useful loops can run with no task/sub-goal decomposition. **Links:**
[`TASKS.md`](TASKS.md). _(Your hypothesis, 2026-06-15.)_

## H4 — Primitives are enduring and recur at every level
Goal, work product, and tasks recur for the root/meta loop and for shipped `dist` loops alike, so
a validated version of the primitive shape is itself shippable. This is the bridge between the
alpha root loop and the gated `dist/`. **Links:** [`TASKS.md`](TASKS.md) (T1). _(Inferred from
your framing; lower confidence.)_

## H5 — A project hosts a portfolio of loops, not one
The unit of analysis is the **set** of loops in a project, not a single loop. Even Karpathy
describes 1–2; real projects grow past that. **Already true here:** this repo runs ≥3 — the
root/meta loop ([`GOAL.md`](GOAL.md)), [ingest → query →
lint](../wiki/loops/automation/ingest-query-lint.md), and the candidate
[goal-directed-task-loop](../wiki/loops/agentic/goal-directed-task-loop.md). The "two engines"
framing in `CLAUDE.md` undercounts and should be revised to "portfolio" **once H5 holds** (pending
doc audit — do **not** edit `CLAUDE.md` yet). **Validated by:** counting loops across real
projects (supports) / a useful project running on exactly one loop (refutes). _(Your hypothesis,
2026-06-15.)_

## H6 — Loops accrete and are encoded heterogeneously → need a self-contained registry
Over time a project adds loops via skills, agents, and `CLAUDE.md` prose; encoding location
varies, so no single file shows you the whole portfolio. The fix is an explicit **loop registry**:
one record per loop (name · status · encoding location · the [H1–H3](HYPOTHESES.md) primitive
triple · `cadence` · `maturity`), with the chart a *rendered view* of it, not hand-drawn.
**Critically, the registry must be self-contained.** A project that *uses* loops has no research
wiki — only this repo does — so the registry cannot depend on wiki content (an earlier version
pulled `cadence`/`maturity` from `type: Loop` frontmatter; that coupling breaks the moment the
registry is vendored). The registry carries its own fields; a `catalog` link to a wiki page is an
optional cross-reference, never a data source. **Links:** [`TASKS.md`](TASKS.md) (T3),
[`LOOPS.md`](LOOPS.md). _(Your hypothesis, 2026-06-15; refined after the wiki-coupling correction.)_

## H7 — A self-improving intent loop (session-harvest) is a high-value class
A meta-loop that (1) reviews the current/prior session for changes to project intent, guided by a
**heuristics doc**, (2) validates proposed changes with the human, (3) executes the approved ones,
and (4) updates the heuristics doc from the feedback — so it gets better over time. It is itself an
instance of the recursive improvement this library studies (Purpose 2). **Links:**
[`TASKS.md`](TASKS.md) (T4), [`GOAL.md`](GOAL.md). _(Your example, 2026-06-15.)_
