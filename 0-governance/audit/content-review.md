# Corpus review and consolidation record

**Audit date:** 2026-09-27  
**Plan:** [`../plan/2026-09-27_Plano_Revisao_Metodologica_Site_e_Corpus.md`](../plan/2026-09-27_Plano_Revisao_Metodologica_Site_e_Corpus.md)

## Inventory

`Rscript tools/audit_content.R` inventories QMD front matter, draft status, source dates, categories, tags, DOI/citekey, normalized title, body hash, and duplicate candidates. After consolidation, the repository contains 156 QMDs: 129 in `posts/`, 8 retained alternative versions in `0-governance/archive/variants/`, and 19 in `Old_Website_Posts/`. The old website archive includes one legacy QMD without front matter; it is retained and is outside the current site build.

The inventory reports 12 remaining match candidates. They are not exact body duplicates. The CSVs beside this record are generated from source files and are retained as review evidence:

- `content-inventory.csv`
- `duplicate-candidates.csv`
- `tag-inventory.csv`
- `tag-usage.csv`

## Confirmed exact duplicate removed

`Old_Website_Posts/2026-01-12-Hall1989/Hall1989.qmd` was removed after comparing its body and metadata with `Old_Website_Posts/Hall2003.qmd`. Their Git blob IDs at the reviewed revision were identical (`c498e8800b47bc401a80b0f0ba9165ee83845d7f`); both identify Hall's 2003 article, carry the same original record date (`2026-01-12`), and have the same DOI, title, and categories. The correctly named `Hall2003.qmd` is retained.

`Old_Website_Posts/Hall1993.qmd` and `Old_Website_Posts/Template.qmd` share a title and DOI in their front matter, but their bodies differ substantially (2,905 versus 366 characters); both remain in the historical archive. Hemerijck's chapters 1 and 5, Inglot's introduction and chapter, and Durham's 2003 and 2005 works have distinct source citations or chapter ranges and remain separate.

## Canonical public versions and preserved alternatives

| Public fiche | Version selected and reason | Date retained from selected source | Retained privately for comparison |
|---|---|---|---|
| `posts/Andersen2024.qmd` | Claude Sonnet 4.6 version; most complete of three differently structured analyses (77,528 characters). | `2026-05-04` | Initial 2026-05-03 version and DeepSeek version |
| `posts/Barahona-etal2026.qmd` | Longer, more complete of the two same-title/citekey versions; shared section structure. | `2026-04-18` | Shorter `FIES-and-Tuittion-fees` version |
| `posts/Busemeyer2026.qmd` | Kept the source file with the full journal pagination in its citation; alternative has distinct prose and is preserved. | `2026-06-06` | Claude Sonnet 4.6 version |
| `posts/Costa-etal2021.qmd` | v13 version includes a fuller source-by-source account and the synthetic argument/critical-card format; v1 is a shorter, differently structured note. | `2026-04-19` | v1 version (`2026-04-16`) |
| `posts/Fairfield2013.qmd` | v2 version carries the later revision date and a complete citation with DOI; earlier text remains available. | `2026-05-25` | Earlier version (`2026-05-03`) |
| `posts/Kang-etal2021.qmd` | Sonnet version uses the article's “Late and unequal” title and a distinct author citekey; dates match. | `2026-04-19` | Perplexity “Best” version |
| `posts/Lupu-Pontusson2023Chp-1.qmd` | v2 version carries the more developed fiche structure; the earlier version remains available. | `2026-04-17` | Earlier version |

The eight alternatives remain source files under `0-governance/archive/variants/`; they are not included in the site listing or build. Public pages include Quarto `aliases` for old filenames so that links to renamed pages continue to resolve. No `date` or `last-updated` field was set to the audit date. Where the selected source was a later version, its own recorded date remains attached to the canonical fiche.

## Incomplete or corrupted source files withheld from the public build

Four QMD sources remain in `posts/` and in the tag/content audits, with their original dates and bodies preserved, but are marked `draft: true` and explicitly excluded from the public build until their content can be recovered or reviewed:

| Source | Reason for withholding |
|---|---|
| `posts/Dobbin-Schoonhoven2010.qmd` | Ends in the middle of a sentence in the critical-analysis table; its embedded HTML table is also unclosed. |
| `posts/Gomes-etal2019.qmd` | Ends in the first line of the synthetic-argument section. |
| `posts/Moe-Wiborg2017.qmd` | Ends midway through the third row of its critical-analysis table. |
| `posts/Sguissardi2008.qmd` | The final analytical rows contain repeated fragments and unrelated drafting instructions, so the analysis cannot be published reliably. |

This is reversible: restore a page to the render list only after reviewing and completing its source. Dates were not changed. `posts/Breen-Muller2020Incomplete.qmd` was already marked as a draft for the same completeness reason.

## Other editorial cleanup

- Canonicalized filenames for Barahona, Costa, Fairfield, Kang, and Lupu; removed temporary model/version labels or a misspelling from the single-source files for Andersson–Berger, Durham 2003, Ferre, Gingrich–Giudici, Mazzuca, Mello, and Offner. The original files remain in Git history or the comparison archive, dates were preserved, and old public paths are listed in `aliases`.
- Renamed five equivalent synthesis headings to the standard `Argumento Sintético`; the source conclusions and prose were not rewritten.
- Marked `Breen-Muller2020Incomplete.qmd` as a draft because its own filename marks it incomplete and its current text stops after chapter 3 of a ten-chapter book. It remains in the repository and is omitted from public listings.
- Corrected titles for the two Good Description slide decks. Their source dates remain `9 de agosto de 2026`; the decks are not part of the bibliography listing.
