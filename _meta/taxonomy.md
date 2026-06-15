# taxonomy.md — controlled vocabulary

The shared vocabulary for `type`, `loop_family`, and `tags`. OKF mandates only that `type`
be non-empty and that consumers tolerate unknown values — so this list is **guidance, not a
hard gate**. Prefer an existing value; if you need a new one, add it here in the same change
(co-evolve with the human).

## `type` (the kind of concept)

| value | meaning |
| --- | --- |
| `Loop` | a named loop: an iterating process with a trigger, a cycle, and an exit condition |
| `Pattern` | a reusable way of *constructing* or *improving* loops (not itself one loop) |
| `Anti-pattern` | a loop construction that reliably fails; documents the failure + the fix |
| `Concept` | a cross-cutting idea loops rely on (termination, idempotency, provenance, …) |
| `Comparison` | a page that contrasts two or more loops/patterns |
| `Source` | a digest of one ingested source (lives in `wiki/sources/`) |
| `Overview` | a map of a sub-area |
| `Synthesis` | the evolving thesis — what makes loops robust |

## `loop_family` (top-level kind — scope of this library)

| value | meaning | examples |
| --- | --- | --- |
| `agentic` | LLM/agent loops that reason, act, and observe | ReAct, reflexion, plan-and-execute, agent harnesses |
| `automation` | machine/process loops that run work on a cadence or trigger | CI loops, scheduled agents, retro/improvement loops, human-in-the-loop review |

> Out of scope for now (the human scoped to agentic + automation): control-theory loops
> (PID, reconciliation) and systems-thinking feedback loops (reinforcing/balancing). If
> that scope expands, add `control` / `feedback` here and reintroduce `polarity` in the
> schema.

## `tags` (cross-cutting, free-ish but normalize here)

Short, lowercase, hyphenated. Current vocabulary:

- **mechanics:** `reasoning`, `tool-use`, `planning`, `observation`, `memory`, `reflection`,
  `verification`, `retrieval`
- **shape:** `plan-act-observe`, `generate-test`, `propose-critique-revise`, `map-reduce`,
  `fan-out`
- **lifecycle:** `ingest`, `query`, `lint`, `retro`, `human-in-the-loop`
- **properties:** `termination`, `idempotency`, `convergence`, `cost-control`,
  `context-management`, `provenance`
- **domain:** `knowledge-base`, `okf`, `agent-harness`

## Notes
- `type` and `loop_family` are independent: a `Pattern` can have `loop_family: agentic`.
- When a value here changes, run `/lint` to catch pages using the old term.
