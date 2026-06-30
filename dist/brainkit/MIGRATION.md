# MIGRATION.md — for an agent landing in a brainkit vault of unknown age

**Read this first if you are an assistant operating a brainkit vault and you are not certain it is
v2.** It is self-contained on purpose: an old or hand-modified fork may ship a `CLAUDE.md` /
`FOUNDATION.md` that contradicts v2, so this guide assumes **no other doc is trustworthy** and tells
you how to (1) detect the version, (2) behave safely for that version, and (3) run the one-time
v1→v2 migration when the user asks.

The whole guide rests on one rule: **when in doubt, do the most restrictive thing and ask.** Never
restructure a vault you can't confidently identify.

---

## 1. Detect the version

You are detecting the **contract version** (v1 vs v2) — the thing that governs `id:`/folder behavior —
**not** the kit's release number. They differ: kit `0.2.0` is still **contract v1** (it was only the
sync-skill change; `id:` is still "never mint"); **contract v2 starts at kit `0.3.0`**. So the
contract-tier markers (`contract_version` / `brainkit_version`) are the authoritative signals and the
release number is a weaker proxy. Check **in order, cheapest first** — first confident hit wins:

| # | Signal | Reads as |
|---|---|---|
| 1 | `knowledge/index.md` frontmatter has `brainkit_version: 2` | **contract v2** |
| 2 | `FOUNDATION.md` frontmatter has `contract_version: 2` | **contract v2** |
| 3 | `loop.manifest.json` `"version"` is **≥ 0.3.0** | **contract v2** · `0.1.x`–`0.2.x` → **contract v1** |
| 4 | `CHANGELOG.md` top heading is `## 0.3.0` or later | **contract v2** |
| 5 | *Heuristic fallback (when the stamps above conflict or are absent — i.e. a hand-modified fork):* read the actual rule text. | see below |

**The convention text is authoritative over a stale stamp.** A fork can carry `version: 0.3.0` but
still say "never mint an id:" in its rules — trust the *rule*, not the number. Grep the rule docs
(`FOUNDATION.md`, `CLAUDE.md`) for these exact phrases:

- **v1 signature** — any of: `never minted by loopkit` · `you never mint` · `Don't mint your own` ·
  `id: is optional, never minted`. → treat as **v1 semantics**.
- **v2 signature** — any of: `tool-mintable` · `shared, tool-mintable integrity tag` ·
  `may mint an id:`. → treat as **v2 semantics**.

**If the text matches neither** (a fork reworded it): **treat as v1 — the most restrictive — and warn
the user that the vault's `id:`/folder convention is unrecognized.** Do not guess upward.

---

## 2. Behave by version (before any migration)

**Most-restrictive-wins:** if signals conflict, apply the v1 column until the user confirms a migration.

| Behavior | On a **v1** (or ambiguous / unrecognized) vault | On a **v2** vault |
|---|---|---|
| `id:` | **Preserve** any present `id:`, **never drop** it — but **never mint** one. | Mint at create / explicit backfill; always preserve; never reuse or rewrite. |
| Links | Resolve and heal **by filename**. | Heal **id-first**, then filename. |
| Folders | Leave the **flat bag** as-is. **Never re-file** notes into a parent-derived path. | A note with a `parent:` edge files inside the parent's folder, recursively (the WBS projection). |
| Re-organizing | **Don't.** Only *offer* migration. | Re-parent → re-file is loss-free via `id:` (suggest-then-apply). |

This v1 restraint mirrors how a Duo host treats *any* foreign OKF bundle (locked decision D5:
mint `id:` at most, **never auto-re-file**) — respect the bundle as you found it, and only *offer* to
upgrade it.

---

## 3. The one-time v1 → v2 migration

Run only on the user's explicit go-ahead. It is **idempotent** (safe to re-run) and must be **atomic
and reversible** — never leave the vault half-upgraded (docs saying v2 while templates still say v1).

**Order matters. Do all of it in one guided pass, or none of it.**

1. **Snapshot first (reversibility).** `git commit` the vault if it's a repo, else copy it to a
   `.bak`. There is no other undo — the `sync` skill and the hand-edits below change files in place.
2. **Pull the v2 machinery.** Run the **`sync` skill** and accept the contract-v2 updates it surfaces —
   it curates the *managed* files against canonical brainkit (`CLAUDE.md`, `FOUNDATION.md`, `DESIGN.md`,
   the skills, `loop.manifest.json`, `CHANGELOG.md`, `README.md`, and **this `MIGRATION.md`**), merging
   rather than clobbering any local tweaks. It does **not** touch your notes, your `golden/`, your
   `PROJECT.md`, or your type templates.
3. **Hand-update what sync can't reach (the seed-once gap).** Your `knowledge/templates/<type>.md` and
   the starter `knowledge/index.md` are **seed-once** — deliberately *not* in `managed_files`, so the
   `sync` skill never offers to change them, which also means it can **never** update them. By hand, in
   this pass:
   - Stamp `brainkit_version: 2` into `knowledge/index.md` frontmatter (keep `okf_version: "0.1"`).
   - Add `primary_axis: parent` to `PROJECT.md` if you want the derived folder tree on (it is the v2
     default behavior; the line just records the choice and which edge is the axis).
   - In each type template that has a parent relationship, name its parent edge (e.g. a `task` and a
     `note` carry `parent:`). Show the diff before applying.
4. **Backfill `id:` (idempotent, byte-preserving).** For every note missing an `id:`, mint one: a
   short opaque URL-safe token (≥ 8 chars), **checked unique against every other `id:` already in the
   vault**, spliced into the frontmatter without reflowing the rest of the file. Skip any note that
   already has one. (If a Duo host is available, prefer letting it mint via its own `ensureNoteId` —
   it satisfies the same contract.)
5. **(Optional) materialize the derived folder path.** Only if the user opted into the axis: re-file
   each note with a `parent:` edge under its parent's folder, recursively. This is loss-free **because
   step 4 gave every note a stable `id:`** — inbound links heal id-first. Do it as suggest-then-apply,
   never silently.
6. **Verify.** Re-read `knowledge/index.md` to confirm the `brainkit_version: 2` stamp, then run
   `distill`: it re-derives the timelines/index-views and relinks id-first, and will surface any note
   it couldn't heal. A clean distill = a consistent v2 vault.

**Do not run step 2 (the `sync` skill) alone and stop.** Sync brings the v2 docs but leaves v1
templates and un-backfilled `id:`s — an internally inconsistent vault whose docs say v2 and whose data
says v1. The migration is the *whole* pass or nothing.

---

## 4. What the `sync` skill does and does NOT migrate (so you set expectations)

- **Migrates (curates + merges, with your approval):** the files listed in `loop.manifest.json`
  `managed_files` — the rule docs, the skills, the version/changelog, and this guide. `sync` is a
  curation task, not a bulk overwrite; it preserves local tweaks.
- **Never touches:** your `PROJECT.md`, your `knowledge/` notes and `golden/`, your
  `knowledge/templates/` type notes, the starter `knowledge/index.md`, and your `work/` deliverables.
- **Therefore:** every v2 *type-convention* change (the `parent:` edge naming, the `id:` line in a
  template) reaches an existing vault **only** through the hand-update in §3.3 — there is no mechanical
  path, by design (it's the price of you owning your templates). An agent that assumes templates
  auto-updated will be wrong on every pre-`0.3.0` fork.
