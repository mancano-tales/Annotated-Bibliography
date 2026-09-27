# Annotated Bibliography

**A method-first collection of structured academic reading notes and critical analytical closures.**

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
Old_Website_Posts/        historical source archive
prompts/                  versioned drafting prompts
code/                     safe Quarto rendering and maintenance scripts
tools/                    plan and NEWS utilities
0-governance/plan/        approved and historical work plans
0-governance/audit/       versioned corpus and tag audit reports
0-governance/archive/     retained content variants excluded from publication
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

## Tags and categories

Broad browse categories follow [`CATEGORIES.md`](CATEGORIES.md). Fine-grained concepts use lowercase kebab-case identifiers documented in the canonical [`TAGS.md`](TAGS.md) registry. Run the tag audit before adding or publishing tags:

```powershell
Rscript code/audit_tags.R
```

## Build locally

Requirements: [Quarto CLI](https://quarto.org/docs/get-started/) and R.

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
