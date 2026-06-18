---
type: source
statuses: [unread, reading, read, processed]
---

# source
Raw material we want to mine — an article, a talk, a doc, a transcript. Carries a `status:` from the
ladder above (`unread → reading → read → processed`), an origin (`source_url:` or who/where it came
from), and `aliases:` for any shorthand it's known by. The verbatim original is kept in a `## Raw`
section in-file — or, only if the original is durable and immutable, a link to it with the key excerpts
snapshotted in-file (`CLAUDE.md` §7). Reusable ideas are extracted into `note`s with a lineage edge
back that carries the key quote; don't duplicate — enrich (`CLAUDE.md` §10).
