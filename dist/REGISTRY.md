# dist/ — shipped loop kits (Purpose 1)

`dist/` is the **shipping target** for vendorable loop kits. Shipping here is treated like
**shipping software**: deliberate, versioned, and reserved for patterns we have **extremely
high confidence** in. Nothing lands here by default.

## Currently shipped

_None._ The bar has not yet been met by any pattern.

## The promotion bar (research → `dist/`)

A pattern may be promoted from the research loop (`wiki/`) into `dist/` only when **all** hold:

1. **Validated** — grounded in cited sources and/or real use, recorded in `wiki/`, not notional.
2. **Confidence: very-high** — tracked on its task in the parent loop (see the repo's
   task register, once established).
3. **Deliberate human review** — an explicit go/no-go, not a side effect of building something.
4. **Shippable** — semver + CHANGELOG + `loop.manifest.json` + `scripts/sync.sh`, README, and
   the managed-vs-user file split below.

This gate is the thing whose *absence* let a notional idea ship prematurely. It now exists.

## Under research (not shipped)

- **vanilla-loop** (a goal-definition + output-requirements scaffold) — **withdrawn from
  `dist/` on 2026-06-15** as premature; it was a notional idea, not a validated pattern. It is
  now an open research question in the parent loop. It ships only if it clears the bar above.

## Sync mechanism (the design we'll use when we ship)

Each shipped kit will carry a self-describing `loop.manifest.json` splitting files into:

- **`managed_files`** — the loop machinery (skill, templates, scripts, docs). `scripts/sync.sh`
  overwrites these from origin.
- **`user_files`** — the vendor's content (their goal, requirements, logs, runs). `sync.sh`
  never touches these.

This is the OKF "self-describing bundle" idea applied to a code artifact: a vendored copy knows
where it came from and updates only its engine. (Design retained here; no kit ships it yet.)
