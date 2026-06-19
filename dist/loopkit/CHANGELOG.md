# Changelog

All notable changes to loopkit. This project follows semantic versioning.

## 0.1.0 — 2026-06-16 (candidate)
**First release — the entity-graph foundation.** loopkit is the typed-entity graph a richer work
agent is built *on*, not *in*. It descends from the Karpathy LLM-wiki loop (shipped standalone as
**karpathy-core**) and adds the entity-graph + Duo OKF-vault layer. Candidate — pending real-use
validation.

- **Typed entities.** Notes are typed nodes (`type:`); the three lines (`summary:` / `type:` /
  `source:`) are a **floor, not a ceiling** — a note carries whatever else it needs.
- **Preserve unknown frontmatter keys.** No rewrite (ingest/query/distill) drops a key it didn't
  write — a Duo `id:`, an app's `status:`/`owner:`. This is what lets a richer layer attach data safely.
- **Links are edges that can carry data.** Plain relative-markdown (`[label](./note.md)`) — never
  `[[wikilinks]]`, never `/absolute`. `source:` is the floor; a link can carry a payload. Edges are
  **copied onto each child** when a note is split.
- **Entity resolution** — vague reference → canonical note — runs in **both `ingest` and `distill`**,
  deferring to `duo vault schema` when a vault is present, else in-fork → golden → ask.
- **Types emerge, then get written down** at `knowledge/templates/<type>.md` — where a Duo vault reads
  types, also read by the skills (not locked). A type's ordered status ladder lives there. A fresh
  fork ships zero types and stays flat.
- **Ships as a Duo vault.** `knowledge/index.md` carries the OKF marker, so a downloaded fork is
  already a vault — just select it in Duo. Inert and GitHub-clean for everyone else.
- **Derived views** (a stakeholder map, a drift list) are `type: index-view` notes, regenerated and
  stamped — never hand-cached. Reserved `index.md`/`log.md` stay reserved.
- **Ships `FOUNDATION.md`** — a self-contained foundation contract so people and agents building a
  richer layer on top can grok the model and the seam without leaving the kit.

The pure ingest/query/distill primitive this grew from ships separately as **karpathy-core** v0.1.0.
An earlier prose-vocabulary attempt (PR #6) was explored and discarded before this.

_2026-06-18 (docs): clarified the managed-vs-user split — `sync` overwrites the two machinery READMEs
`knowledge/templates/README.md` and `knowledge/golden/README.md`; your type notes and golden notes
beside them are untouched. Corrected a blanket "sync never touches `knowledge/templates/`" wording in
`CLAUDE.md` §4, `FOUNDATION.md`, the templates README, and the manifest note that contradicted
`managed_files`. (Surfaced by brainkit's foreclosure pass.)_
