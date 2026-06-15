# golden/ — locked context

Pinned context that must not drift: templates, hard rules, contracts, OKRs, definitions.

The assistant loads this first, treats it as the source of truth, and **won't change anything here
without asking**. `distill` never trims it; on a contradiction, golden wins. To pin something new,
tell the assistant **"pin this"** (or "make this golden" / "this is the rule").

A common one is **`vocabulary.md`** — a plain-language note of the recurring things this project
tracks (e.g. *"we track initiatives, each with a scope of internal or external, and an owner"*) so
the assistant names them consistently instead of reinventing them. Keep it prose, not a table of
fields. See `CLAUDE.md` §4.1.
