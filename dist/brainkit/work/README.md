# work/ — your deliverables

This folder holds what you're producing. A few things the assistant follows:

- **You can have several deliverables here** — not just one.
- **Split a deliverable into sections** when that helps (e.g. `prd/01-problem.md`,
  `prd/02-plan.md`), so you can work on and finalize parts independently.
- **Lock a finished piece** by adding `locked: true` at the top of its file. The assistant then
  treats it like golden context — it won't rewrite a locked file without asking. This is how you
  finalize sections one at a time.
- `query` drafts and advances the **unlocked** parts from your `knowledge/` notes, with citations.
- `distill` flags an unlocked deliverable that has drifted from the notes it cites.
- `templates/` holds starting scaffolds. They're part of the kit's machinery (the **sync** skill may
  offer upstream updates to them), so copy a template into a new file to start a deliverable rather than
  editing the template in place.
