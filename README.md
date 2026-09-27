# Annotated Bibliography

**A method-first collection of structured academic reading notes and critical analytical closures.**

[![Leia em português](https://img.shields.io/badge/Leia_em_Portugu%C3%AAs-pt--BR-009739?style=for-the-badge)](README.pt-br.md)

[![Publish site](https://github.com/mancano-tales/annotated-bibliography/actions/workflows/publish.yml/badge.svg)](https://github.com/mancano-tales/annotated-bibliography/actions/workflows/publish.yml)

**Website:** <https://mancano-tales.github.io/annotated-bibliography/> · **Method:** [How the analytical closure works](method.qmd) · [RSS feed](https://mancano-tales.github.io/annotated-bibliography/bibliography.xml)

## About

This open-access Quarto site documents a repeatable way to read academic work closely. Each fiche reconstructs a source's question, argument, design, and evidence before assessing what the evidence supports and where the inference stops. The emphasis is on the craft of analysis; the works cover multiple subjects and disciplines.

A fiche complements its source and does not replace it. Page references and paragraph markers help readers trace claims back to the original work.

## How a fiche closes

The final sections keep three tasks distinct:

1. **The source's conclusion** — what the authors conclude and the evidence they cite.
2. **Synthetic Argument** (*Argumento Sintético*) — a concise reconstruction of the claim, reasoning, support, and limits.
3. **Critical Analytical Card** (*Ficha Analítica Crítica*) — an assessment of the fit between question, design, evidence, inference, and scope.

The [method page](method.qmd) explains the sequence, quality checks, and cases where the template should adapt.

## Browse

- [Search the annotated bibliography](bibliography.qmd)
- [Read concept notes](notes.qmd)
- [Read about the method](method.qmd)

## Repository map

```text
posts/                    source-based fiches
posts/notes/              cross-work concept notes
prompts/                  versioned drafting prompts
code/                     safe Quarto rendering and maintenance scripts
tools/                    plan and NEWS utilities
repo-governance/plan/     approved and historical work plans
repo-governance/audit/    versioned corpus and tag audit reports
repo-governance/archive/  retained content variants excluded from publication
repo-governance/triage/   preserved legacy material awaiting review
_extensions/              Quarto extensions
files/includes/           site-wide HTML includes
index.qmd                 home page
bibliography.qmd          searchable fiche listing
method.qmd                analytical-closure method
notes.qmd                 concept-note listing
TAGS.md                  canonical tag registry and maintenance guide
CATEGORIES.md             canonical category taxonomy
references.bib            master BibTeX bibliography
```

`docs/` is local render output and is ignored by git. GitHub Actions builds the site and publishes to GitHub Pages.

Some recovered notes in `posts/` remain marked `draft: true` and are excluded from the site until their source and analysis are reviewed. Other legacy material is preserved in `repo-governance/triage/`; its disposition and duplicate checks are documented there.

## Tags and categories

Broad browse categories follow [`CATEGORIES.md`](CATEGORIES.md). Fine-grained concepts use lowercase kebab-case identifiers documented in the canonical [`TAGS.md`](TAGS.md) registry. Run the tag audit before adding or publishing tags:

```powershell
Rscript code/audit_tags.R
Rscript tools/check_paths.R
```

## Build locally

Requirements: [Quarto CLI](https://quarto.org/docs/get-started/), R, and the R package `here` for maintenance scripts.

```powershell
git clone https://github.com/mancano-tales/annotated-bibliography.git
cd annotated-bibliography

# Incremental safe render
.\code\render-posts.ps1

# Render the complete site
.\code\render-posts.ps1 -All

# Preview with live reload
quarto preview
```

Use the safe renderer rather than a bare `quarto render`; it protects local output when rendering fails.

## Citation and license

All content is © Tales Mançano. Original works remain the intellectual property of their authors. For citations, use the bibliographic record on the relevant page and link to the canonical site:

> Mançano, Tales. *Annotated Bibliography*. <https://mancano-tales.github.io/annotated-bibliography/>

---

*Site structure reviewed 2026-09-27. The original dates recorded on individual reading notes are preserved during editorial revisions.*
