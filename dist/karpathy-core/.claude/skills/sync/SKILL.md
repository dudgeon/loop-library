---
name: sync
description: Curate upstream improvements into this kit — a research task, not a script. Read canonical karpathy-core upstream, reason about what genuinely improved, and pull in only the changes you and the user find compelling, preserving local tweaks. Suggest-only; never bulk-overwrites. Use when the user wants to refresh the kit's machinery from origin.
---

# sync

Bring this kit's **machinery** up to date with canonical karpathy-core — **selectively**. Sync is a
**curation task you run as an agent**, not a deterministic copy: the point is to *learn what changed
upstream* and pull in only the improvements that are worth it here, **without clobbering the local
tweaks the user made on purpose**. Read `CLAUDE.md` first. **Suggest-only:** propose, get approval,
work in git.

> **Why this is a skill, not a script.** A script can only overwrite by a fixed rule, which nukes
> intentional local edits to managed files — the exact failure this replaces. What "improved upstream"
> and "worth adopting *here*" mean are judgment calls, so a human-in-the-loop agent does it — the same
> way `distill` curates the knowledge base. Sync is non-deterministic by design.

## Inputs
- **origin** — where canonical upstream lives: the first thing the user hands you, else
  `$KARPATHY_CORE_ORIGIN`, else the `origin` field in `loop.manifest.json`. A git URL or a local path;
  the kit may sit in a subdirectory (e.g. `dist/karpathy-core`). Point it at karpathy-core's **own**
  upstream — never a sibling kit (loopkit/brainkit), or you'd pull a sibling's skills over this one's.
- **machinery list** — `loop.manifest.json` → `managed_files`: the files upstream owns (the skills,
  this `CLAUDE.md`, the machinery README, `work/templates/`). Everything else is the user's and is
  **out of scope** — never propose changing it: `PROJECT.md`, their `knowledge/` notes and `golden/`,
  their `work/` deliverables.

## Steps
1. **Fetch upstream.** Clone the origin (shallow) or read the local path; locate the kit (it may be in a
   subdirectory). If no origin is set, **ask the user for it** — don't guess.
2. **Survey what changed.** For each file in `managed_files`, compare upstream vs local, and read
   upstream's `CHANGELOG.md` to understand *what* changed and *why*. Sort each file into:
   - **upstream-only** — changed upstream, untouched locally → a candidate improvement;
   - **local-only** — the user tweaked it, upstream didn't → leave it; note that it will diverge;
   - **both changed** — needs a real merge → surface the conflict, never silently pick a side;
   - **same** — skip silently.
3. **Reason about value — don't dump diffs.** For each upstream-only / both-changed file, say in a
   sentence *what the change does* and whether it's worth adopting **here**, given how the user has set
   this kit up (read `PROJECT.md` and their golden context). A bugfix to a skill usually is; a doc
   reword may not be. This judgment is the whole reason sync is an agent and not `cp`.
4. **Curate with the user.** Present the compelling changes with the structured **AskUserQuestion**
   prompt — per file or per coherent group — options like *adopt upstream / keep mine / show the diff /
   merge by hand*. The user pulls in only what they find compelling. Nothing lands without an explicit
   yes.
5. **Apply only what's approved**, in git so every change is a reviewable diff. For a **both-changed**
   file, **merge the upstream improvement into the local tweak** rather than overwriting — preserve the
   user's intent. If the user adopted enough that the kit now tracks a newer upstream version, note it
   — but treat `loop.manifest.json`'s `origin` and `version` as **the user's own fields**: never
   replace their real `origin` with upstream's `TODO:` placeholder, even when they adopt other manifest
   changes.

## Don'ts
Don't bulk-overwrite. Don't touch anything outside `managed_files`. Don't clobber a file the user
tweaked on purpose — merge or ask. Don't relay raw diffs without judgment. Don't pull a change just
because it's newer; pull it because it's better *here*. Don't point `origin` at a sibling kit.
**Don't overwrite the user's `origin` or `version` in `loop.manifest.json`** — those fields are theirs
even though the file is machinery; offer only the genuine upstream machinery changes around them.
