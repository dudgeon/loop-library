---
type: decision
statuses: [proposed, accepted, superseded]
---

# decision
A durable choice and its rationale — **what** was decided, **why**, and what it rules out. Carries a
`status:` (`proposed → accepted → superseded`), links to the `meeting`/`source` that produced it and to
what it affects, and — if it came from someone's request — a `requested_by` edge. Capture the reasoning,
not just the outcome: a decision whose "why" is recorded keeps paying off when the question comes back.
High-value for a deliverable.
