# loop/ — the root (meta) loop's primitives

This repo is itself a loop. This folder holds that **root/meta loop's primitives** — the small
set of enduring things every loop seems to need.

**Two ceremonies (set 2026-06-15):**
- The **root/meta loop is alpha** — malleable; iterate freely. This `loop/` folder is alpha.
- **`dist/` is shipped product** — deliberate, gated, very-high-confidence only (`CLAUDE.md` §8).

## Hypothesized loop primitives (under test — see [`HYPOTHESES.md`](HYPOTHESES.md))
- **Goal** — the loop's enduring intent. → [`GOAL.md`](GOAL.md)
- **Work product** — what the loop produces/maintains (may be self-referential). → [`GOAL.md`](GOAL.md)
- **Tasks / sub-goals** — the actionable decomposition. → [`TASKS.md`](TASKS.md)
- **Hypotheses** — beliefs we're testing. → [`HYPOTHESES.md`](HYPOTHESES.md)

This `loop/` folder **is this repo's PROJECT** (loopkit's term for it): the goal, beliefs, work, and
the loops we run, in one place.

A project runs **more than one** loop (hypotheses H5/H6). The loops this repo runs — hand-maintained;
add a row when you add a loop:

| loop | encoded in | reads / writes |
| --- | --- | --- |
| root / meta loop | this `loop/` folder | GOAL · HYPOTHESES · TASKS |
| ingest → query → lint | `.claude/skills/` + `CLAUDE.md` §3 | the `wiki/` corpus |
| session-harvest | `.claude/skills/session-harvest/` | the session + heuristics → intent docs |
| goal-directed task loop | a `wiki/` hypothesis page (unshipped) | goal+reqs → an artifact |

(We removed the generated `LOOPS.md` registry: at ~5 loops a hand list beats the machinery, whose
topology can't be auto-derived and whose source rots if unmaintained — see [`TASKS.md`](TASKS.md) T3.)

The bet (hypothesis H4): these primitives are enduring and recur at every level, so a *validated*
version of this shape is itself a candidate to ship as a `dist/` kit — that's task **T1**.
Prototype the shape here (alpha), validate it, then ship.

> Distinction from neighbors: `wiki/` is **sourced knowledge** (what sources say); `loop/` is
> **this loop's live state** (our goal, beliefs, and work). A hypothesis here graduates into the
> `wiki/` when grounded, or into a `dist/` primitive when proven.
