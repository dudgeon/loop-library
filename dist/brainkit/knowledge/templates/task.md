---
type: task
statuses: [open, in-progress, blocked, done]
---

# task
An action item, tracked as a **node** (default `task_policy: embodied`, `CLAUDE.md` §9). Carries a
`status:` from the ladder above — a **closeable/reopenable** transition, not a one-way maturity ladder —
an optional `due:`, an owner edge, a `requested_by`/`source` edge (who asked, and the note it came
from), and a **`parent`** edge to a parent task (decomposition) or the initiative / work-product it
advances.

The node is the **single source of truth — never mirror a task into another file.** `parent` edges
must not form a cycle (checked at ingest). `distill` surfaces a **stale** task (`open` past its `due:`,
or `open` with no linked-note activity in a long while) and **won't retire a task with open children**
(they re-parent first). Closing a task can surface its `requested_by` to notify the asker.

*(Under `task_policy: externalized`, a `task` note is just a **pointer** to the item in your real
tracker — a link, no mutable state mirrored here.)*
