---
type: Source
title: 'Google Cloud — "Introducing the Open Knowledge Format"'
description: Google's announcement framing OKF as the portable, vendor-neutral format that turns Karpathy's LLM-wiki pattern into an interoperability standard for the knowledge agents need.
tags: [okf, knowledge-base]
authors: [Sam McVeety, Amir Hormati (Google Cloud)]
published: '2026-06-12'
timestamp: 2026-06-14T00:00:00Z
resource: https://cloud.google.com/blog/products/data-analytics/how-the-open-knowledge-format-can-improve-data-sharing/
raw_mirror: ../sources/google-2026-okf-blog.md
note: Google-copyrighted blog post — digest only; see resource for the canonical text.
---

# Google Cloud — "Introducing the Open Knowledge Format"

The announcement post for OKF. Its thesis: agents are limited less by capability than by
*context*, and the missing piece is **a format, not another service**. Knowledge should be
just files, just markdown, just YAML — living in version control alongside the code it
describes, **readable by humans and parseable by agents with no translation layer**. It
explicitly credits Karpathy's LLM-wiki insight and formalizes it into an open standard.

# Key points
- **Format, not platform.** "The value of a knowledge format comes from how many parties
  speak it, not from who owns it." Never requires a proprietary account or SDK.
- **Minimally opinionated.** Exactly one required field (`type`); the spec defines the
  interoperability surface, not the content model.
- **Producer/consumer independence.** Who writes knowledge is cleanly separated from who
  consumes it; tooling at each end is swappable, the format is the contract.
- **Knowledge as a living wiki** that agents maintain (the bookkeeping) and humans curate
  (like code). Builds directly on Karpathy: "LLMs don't get bored… can touch 15 files in one
  pass."
- **Radical simplicity:** "No complex compression scheme, no new runtime, no required SDK."
- **Open and versioned for growth:** v0.1 is "a starting point, not a finished standard,"
  inviting issues, PRs, and adoption beyond Google products.

# Notable excerpts
- "OKF v0.1 represents knowledge as a directory of markdown files with YAML frontmatter…
  That's it. No complex compression scheme, no new runtime, no required SDK."
- "The answer to this problem isn't another knowledge service. You need a format."
- "Concepts link to each other with normal markdown links, turning the directory into a graph
  of relationships that is richer than the parent/child links implied by the file system."
- "the value of a knowledge format comes from how many parties speak it, not from who owns it."

# Compiled into
- [Progressive disclosure](/concepts/progressive-disclosure.md)
- [What makes a knowledge loop robust](/synthesis.md)
