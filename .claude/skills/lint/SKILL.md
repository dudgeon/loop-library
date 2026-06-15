---
name: lint
description: Health-check the Loop Library wiki — run the conformance and lint scripts, then review for what scripts can't catch (contradictions vs newer sources, provenance drift, orphan/missing pages, stale timestamps) and fix what's safe. Use periodically, before merging, or when the user asks to clean up or audit the knowledge base.
---

# Lint

Karpathy's third operation, and the actual product: the retro loop that keeps the wiki
healthy as it grows. Read [`CLAUDE.md`](../../../CLAUDE.md) §3 and §6 first.

## Mechanical pass (scripts)
1. Run `scripts/conformance.sh` — strict OKF checks. **Must exit 0.** Fix every FAIL:
   missing/empty `type`, missing `okf_version` in `wiki/index.md`, compiled pages missing
   `sources:` or `# Citations`.
2. Run `scripts/lint.sh` — advisory warnings: broken bundle-relative links, compiled pages
   missing `summary:`, orphan pages with no inbound link.

## Judgement pass (you)
Review what scripts can't:
- **Contradictions:** a page vs a *newer* source. Flag it; don't silently overwrite — surface
  to the human, then reconcile and note the supersession.
- **Provenance drift:** pages trending toward mostly `inferred`/`ambiguous`. Re-ground from
  sources or mark clearly.
- **Missing pages:** loops/concepts referenced (or linked) but not yet written.
- **Stale timestamps:** pages older than the sources they cite.
- **Taxonomy drift:** `type`/`tags`/`loop_family` values not in `_meta/taxonomy.md`.

## Close out
- Fix what's safe; list what needs the human.
- Append a `lint` entry to `wiki/log.md`: `- lint | <pass scope> — <result>`.
- Re-run `scripts/conformance.sh` to confirm green.
