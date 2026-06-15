---
name: session-harvest
description: Harvest changes to this project's intent from the current or a prior session — guided by the repo's heuristics doc — validate them with the user, apply only the approved ones, and update the heuristics doc so detection improves over time. Use at the end of a session, after a substantial change, or when the user wants to reconcile intent drift in GOAL / HYPOTHESES / TASKS / CLAUDE.
---

# Session-Harvest

The retro loop turned **inward**: instead of keeping the `wiki/` corpus current against new
sources (that's [`/ingest`]), this keeps the project's **stated intent** current against new
sessions. It is an **alpha** operation and the loop it runs is an unvalidated hypothesis — see
[`wiki/loops/automation/session-harvest.md`](../../../wiki/loops/automation/session-harvest.md),
task [`T4`](../../../loop/TASKS.md), hypothesis [`H7`](../../../loop/HYPOTHESES.md).

**The load-bearing rule: nothing reaches an intent doc except through the human Validate gate.**
This loop edits the project's constitution; it must never apply an un-approved change.

## The heuristics doc (read it first, update it last)

The detector lives in the repo, **not** in this skill, so it is versioned and human-editable:
[`loop/intent-heuristics.md`](../../../loop/intent-heuristics.md). **Review** reads it (what counts
as real drift vs. noise, and which doc each change lands in); **Learn** appends to it.

## Steps

1. **Review** — read [`loop/intent-heuristics.md`](../../../loop/intent-heuristics.md), then scan
   the session (current, or a prior one the user names) for evidence that intent changed: a
   decision reversed, a convention that stabilized (repeated 3+ times), scope explicitly
   narrowed/widened, a new belief, a new/changed/retired loop. Match against the doc's **Signals**;
   discard **Anti-signals** (one-off exploration, tool failures, thinking-out-loud later walked
   back).
2. **Propose** — draft a *small, specific* numbered list of candidate changes. Each item names its
   **target doc** (per the heuristics doc's Targets table), the **exact edit**, and the **session
   evidence** behind it. Apply nothing yet.
3. **Validate** — present the list to the user; they accept / reject / edit each item. **Mandatory.**
   If the user is absent, stop here with the proposal — do not apply.
4. **Execute** — apply **only approved** items, respecting ownership:
   - **Edit freely (alpha):** `loop/GOAL.md`, `loop/HYPOTHESES.md`, `loop/TASKS.md`, and the
     "Loops in this project" list in `loop/README.md` (hand-maintained).
   - **Propose only — never self-apply:** `CLAUDE.md` and anything under `_meta/` (the constitution
     / schema are co-evolved with the human, `CLAUDE.md` §4). Surface these as a separate "needs
     your go-ahead" list.
   - **Never touch:** `dist/` (shipping is gated, §8) and `sources/` (read-only).
5. **Learn** — update [`loop/intent-heuristics.md`](../../../loop/intent-heuristics.md) from the
   feedback: append accepted/rejected calls (with evidence) to the **Decisions log**, and refine
   **Signals / Anti-signals** when a rejection or edit reveals a better rule. This is the step that
   makes the loop compound — don't skip it.
6. **Verify** — if you touched any `wiki/` page, run `scripts/conformance.sh` (must pass) and
   `scripts/lint.sh`.

## Don'ts

- Don't apply *any* change the user didn't approve. Don't self-edit `CLAUDE.md` or `_meta/` —
  propose them. Don't touch `dist/` or `sources/`. Don't propose a change without citing the
  session evidence for it. Don't invent drift to look productive — an empty harvest is a fine
  outcome; say so.
