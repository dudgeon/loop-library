# Automation loops

Machine/process loops that run recurring work on a cadence or trigger.

* [Ingest → Query → Lint Loop](/loops/automation/ingest-query-lint.md) — the compile-and-maintain loop this repository runs on; ingest sources, answer queries, periodically lint.
* [Session-Harvest Loop](/loops/automation/session-harvest.md) — design (unvalidated, not shipped): the retro loop turned inward — harvest intent-changes from a session, validate with the human, apply, and improve the heuristics doc.
