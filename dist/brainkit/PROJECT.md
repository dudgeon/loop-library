# PROJECT.md — what this project is

> The assistant fills this in with you on first run (see `CLAUDE.md` §0). Until then it's a
> template. Every operation reads this first, so keep it current.

## Goal
TODO — what are you trying to do?

## Work product(s)
TODO — what do you want to produce? (lives in `work/`; you can have more than one, and split one into
sections you lock as they're finalized). Knowledge here accrues to make *these* better.

## Task policy
`task_policy: embodied`

How tasks are handled (`CLAUDE.md` §9): **`embodied`** (default — tasks are nodes in the graph),
`externalized` (you have a real tracker; brainkit hands off and keeps a pointer — record the tracker
here), or `off`. The three operations read this line on entry.

## Knowledge base
TODO — what kind of knowledge accumulates here? (lives in `knowledge/`). Note which entity kinds should
carry a **timeline** (set `timeline: true` on those types in `knowledge/templates/`, `CLAUDE.md` §8) —
e.g. people, initiatives.

## Golden context (locked)
TODO — what should never drift? Templates, hard rules, contracts, OKRs, definitions → `knowledge/golden/`

## Cadence
TODO — roughly when will you ingest, query, and distill?
