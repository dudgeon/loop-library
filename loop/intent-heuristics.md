# Intent heuristics — the session-harvest detector

The working artifact of the [session-harvest loop](../wiki/loops/automation/session-harvest.md).
It lives here in the repo (not inside the skill) so it is versioned and you can edit it directly.

- **Review** reads this to decide what counts as a real intent-change vs. noise, and where each
  change lands.
- **Learn** updates this from your accept/reject feedback, so the detector improves over time.

Alpha — revise freely. This is the root loop's tuned notion of "what a meaningful change to *this*
project's intent looks like."

## Signals — likely a real intent-change

- A prior decision is **reversed** or a previously-shipped thing is withdrawn.
- A convention is **repeated 3+ times** or stated as a rule ("always…", "never…", "from now on…").
- Scope is **explicitly** narrowed or widened ("out of scope", "we also want…").
- A **belief** is asserted, raised, or lowered in confidence (→ a hypothesis).
- A **loop** is added, changed, re-encoded, activated, or retired (→ the loops list in `README.md`).
- The **goal / work-product / done-criteria** is restated or refined.

## Anti-signals — looks like drift but usually isn't

- One-off **exploration** the user didn't commit to ("let's try…", then moved on).
- A **tool failure / dead end** — a fix attempt, not a change of intent.
- **Thinking-out-loud** the user later walked back in the same session.
- Restating something **already** recorded (no new information).
- The agent's own suggestions the user didn't endorse.

## Targets — where each kind of change lands (and the ownership rule)

| Change | Target | Rule |
| --- | --- | --- |
| Goal / scope / work-product / done-criteria | [`GOAL.md`](GOAL.md) | edit freely (alpha) |
| New / changed belief or confidence | [`HYPOTHESES.md`](HYPOTHESES.md) | edit freely (alpha) |
| New work, priority, or status change | [`TASKS.md`](TASKS.md) | edit freely (alpha) |
| New / changed / retired loop, or its status | the "Loops in this project" list in [`README.md`](README.md) | edit freely (alpha) |
| Convention / operating rule | `CLAUDE.md` | **propose only** — co-evolve (§4) |
| Schema / taxonomy | `_meta/` | **propose only** — co-evolve |
| A shipped kit | `dist/` | **never via this loop** — gated (§8) |
| A source | `sources/` | **read-only — never** |

## Decisions log

Newest-first. Each entry: the proposed change, the user's call (accepted / rejected / edited), and
the session evidence. Seeded with this loop's own origin session (dogfooding).

### 2026-06-15
- **accepted** | "Collapse the generated loops registry" — at ~5 loops a hand list beats the
  machinery, and the registry's `--check` gave false anti-rot comfort (guarded source↔view, not
  view↔reality). Deleted `loops.registry.json` + `gen-loops.*` + `LOOPS.md` + the lint check; the
  loop portfolio is now a hand-maintained list in `loop/README.md`. *Evidence:* user asked to
  stress-test whether the registry was useful and flagged context-rot from non-use. *Signal
  learned:* generated tooling must earn its keep at the **current** scale and carry a *real* (not
  illusory) anti-rot guard.
- **accepted** | "The registry must be **self-contained** — it cannot read the wiki, because a
  user's repo *uses* loops but has no research wiki" → decoupled the generator from wiki frontmatter;
  `loops.registry.json` now carries all fields; `catalog` is an optional link only. *Evidence:* user
  corrected that future users' repos aren't *about* loops, so the registry can't rely on wiki
  content. *Signal learned:* "X must travel / be vendored" ⇒ remove dependencies on this-repo-only
  artifacts (the wiki).
- **accepted** | "A project runs a *portfolio* of loops, not one" → recorded as H5/H6, registry
  `LOOPS.md` created. *Evidence:* user stated the single-loop framing was wrong and asked for a way
  to see/relate a project's loops.
- **accepted** | "The registry is the set of loops *active in this project* (instances), distinct
  from the wiki catalog of loop *types*" → inverted the generator's drift-check, added a `status`
  field. *Evidence:* user flagged that the wiki will hold hundreds of unused loops, so "active here"
  is the registry's job.
- **accepted** | "session-harvest should be a real skill, with its heuristics doc in the repo, not
  gated in the skill" → built `.claude/skills/session-harvest/` + this file. *Evidence:* explicit
  user instruction.
