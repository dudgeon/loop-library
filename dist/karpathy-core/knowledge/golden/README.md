# golden/ — locked context

Pinned context that must not drift: templates, hard rules, contracts, OKRs, definitions.

The assistant loads this first, treats it as the source of truth, and **won't change anything here
without asking**. `distill` never trims it; on a contradiction, golden wins. To pin something new,
tell the assistant **"pin this"** (or "make this golden" / "this is the rule").
