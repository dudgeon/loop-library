# sources/ — immutable raw layer (LAYER 1)

The curated source documents this library is compiled from. **This directory is the source of
truth and is read-only to the agent:** it reads and cites these files but never edits them.
Each is mirrored once, at ingest, then left alone.

Naming: `<author-or-org>-<year>-<slug>.md`.

Each source has a compiled **digest** at `wiki/sources/<same-id>.md` (`type: Source`) which
links back here via `raw_mirror:` and to the canonical URL via `resource:`. To fold a source
into the wiki, run `/ingest`.

Current sources:

- `karpathy-2026-llm-wiki.md` — Karpathy's "LLM Wiki" gist.
- `google-2026-okf-spec.md` — Open Knowledge Format Specification v0.1 (Apache-2.0 upstream).
- `google-2026-okf-blog.md` — Google Cloud "Introducing the Open Knowledge Format" (digest;
  blog is Google-copyrighted — keep verbatim use minimal, prefer the canonical URL).
