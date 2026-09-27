# Legacy material triage

This directory preserves older source material that should not be published as part of the current annotated bibliography. Nothing here is deleted automatically. Review each group before moving, publishing, or removing it.

## Recovered reading notes held as drafts

These eight bibliographic QMDs were moved from the retired `Old_Website_Posts/` tree into `posts/` so they can be reviewed alongside the current corpus. Their original `date` and `last-updated` metadata were preserved. They are marked `draft: true` and explicitly excluded in `_quarto.yml` until the source, citations, and analysis are checked. Their former routes remain in `aliases`; Quarto will emit redirects only after a note is approved and returned to the render list:

- `posts/Albouy2012.qmd`
- `posts/Carnoy1984.qmd`
- `posts/Carnoy1989.qmd`
- `posts/Carnoy2024Ch3.qmd`
- `posts/Evans1995.qmd`
- `posts/Hall1993.qmd`
- `posts/Hall2003.qmd`
- `posts/Hay2019.qmd`

## QMD sources retained for editorial triage

- `old-qmd/Callaway-etal2025-Contdid.qmd` has no bibliographic citation. About 97% of its text is contained in the Carnoy 2024 note, while its opening notes on two-way fixed effects are distinct. It remains preserved until the author decides whether to extract those notes or discard the file.
- The other files under `old-qmd/` are course notes, incomplete drafts, a concept essay, a comment draft, a personal research-planning project, or blank/index shells. They are not source-based reading notes ready for public release. Their original subfolders and filenames are retained where possible.
- `old-qmd/Text Template.qmd` is a generic reading-prompt shell, not a source-based fiche. It is preserved for possible reuse or later removal.

## Support and local-only material

- `old-support/` holds old site metadata, a `.nojekyll` marker, course-note text files, and scripts/data for the personal planning project. These do not belong in the current site build.
- `local-generated/` contains only locally generated HTML and is ignored by Git. It is not part of the committed archive.
- `local-history/` contains the local `.Rhistory` and is ignored by Git because it includes machine-specific command history. It is preserved on this machine, not published.
- `Annotated-Bibliography.Rproj` was removed at the author's request because this repository no longer uses RStudio project files.

## Confirmed duplicate disposition

The old `Old_Website_Posts/Template.qmd` and `Old_Website_Posts/Hall1993.qmd` shared the Hall 1993 title, DOI, and record date. The Hall fiche is substantially more complete (2,905 body characters versus 366) and retains the analytic content; the empty-heading template was removed. The former `/Old_Website_Posts/Template.html` route is retained as alias metadata on `posts/Hall1993.qmd`; it will become a redirect if that draft is approved for publication.

The prior exact duplicate `Hall1989.qmd` was already removed in an earlier review after its Git blob matched `Hall2003.qmd`; the 2003 source remains canonical. That historical decision is documented in `repo-governance/audit/content-review.md`.
