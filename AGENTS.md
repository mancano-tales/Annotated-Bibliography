# AGENTS.md — Annotated-Bibliography

> 🚨 **CRITICAL AGENT RULES (COVENANT) — READ FIRST:**
> - **RULE 1:** You are operating under the **Agent Covenant** framework. Every commit is audited.
> - **RULE 2:** Any modification in `posts/`, `_quarto.yml`, or governance files REQUIRES an update in the root `NEWS.md` file, in the same commit.
> - **RULE 3:** Export a conversation only when the author asks; never export automatically at the end of a task.
> - **RULE 4:** Never run `git add .`, `git add -A`, or `git add -u`. Stage only in-scope files by explicit path.
> - **RULE 5:** Edit `AGENTS.md`; `CLAUDE.md` must contain only `@AGENTS.md`.
> - **For humans:** see [README.md](README.md) for the human sitemap.

---

This file provides guidance to AI Agents when working with code in this repository.

## What this repository is

A Quarto website hosting Tales Mançano's annotated bibliography (*fichamentos*) — structured, paragraph-by-paragraph academic reading notes in political science, political economy, and historical sociology. Posts are generated with AI assistance using versioned prompts in `prompts/`, reviewed, and stored as `.qmd` files in `posts/`.

## Commands

**Rendering — use the script, not `quarto render`:**

```powershell
# Render whatever is out of date (QMD newer than its HTML), safely
.\code\render-posts.ps1

# Render specific posts
.\code\render-posts.ps1 -Posts Ergen-Kohl2019, DeKadt-GrzymalaBusse2025

# Dry run
.\code\render-posts.ps1 -WhatIf
```

```bash
# Preview with live reload (localhost)
quarto preview
```

> ⚠️ **Do not run a bare `quarto render`.** A full project render **wipes `docs/` before it starts**. If it then fails partway — which happens here, because something on this machine holds brief locks on freshly written files (`os error 1224` / `os error 32` on `docs/search.json`) — you are left with a mutilated `docs/`: on 2026-07-21 this deleted 99 rendered posts plus the RSS feed and README outputs, ~246 spurious git changes. Recovery then was `git restore docs/`, because the HTML was committed.
>
> **Since 2026-07-31 that recovery route no longer exists**: `docs/` is no longer tracked (see NEWS 2026-07-31), so `git restore docs/` recovers nothing. A damaged `docs/` is a local render problem. GitHub Actions builds from source and publishes to `gh-pages`, but the last verified Pages setting (2026-09-27) still pointed to `main:/docs`; the workflow output will not be served until the repository owner changes that setting. Rebuild local output with `.\code\render-posts.ps1 -All`.
>
> [`code/render-posts.ps1`](code/render-posts.ps1) avoids this by always passing `--no-clean`, retrying with backoff on lock errors, cleaning up the temp files Quarto abandons when it aborts (`*.feed-full-staged`, `*-listing.json`, stray `.html` inside `posts/`), and verifying afterwards that nothing in `docs/` was lost. If you must render the whole project, use `-All` — it still passes `--no-clean`.

Requirements: Quarto CLI ≥ 1.4 (tested on 1.9.37) and R (for the audit scripts).

**R maintenance scripts** (edit the filename variable at the top of each script before running):

```r
# Fix LLM-generated formatting issues in a single post
# Set `nome_do_qmd` inside the script, then:
Rscript code/fix_spaces.R

# Audit and normalize categories across all posts in posts/
Rscript code/fix_categories.R   # writes category_audit.csv
```

## Architecture

```
_quarto.yml          # project config: output-dir=docs, bibliography, theme, navbar
index.qmd            # homepage listing (reads from posts/)
posts/               # Quarto sources; 131 use the Annotated Bibliography category
  notes/             # Zettelkasten-style concept notes (Descriptive Note type)
prompts/             # versioned LLM prompts (spreadsheets/, podcasts/, qmd-blog-posts/)
code/                # safe Quarto renderer and R maintenance scripts
references.bib       # master BibTeX file (~2.2 MB, managed via Zotero)
CATEGORIES.md        # canonical category taxonomy — single source of truth
code/fix_spaces.R         # cleans LLM formatting artefacts (stray leading spaces, *** → ---)
code/fix_categories.R     # normalises legacy/Portuguese category names to canonical English
category_audit.csv        # output of code/fix_categories.R
files/includes/      # HTML includes injected site-wide (Academicons, badge CSS)
_extensions/         # Quarto extensions (Font Awesome, Academicons, Iconify)
docs/                # local render output — NOT tracked; Pages source configuration is described below
Old_Website_Posts/   # archived legacy posts; do not add new content here
```

GitHub Actions ([`.github/workflows/publish.yml`](.github/workflows/publish.yml)) renders the site on every push to `main` and publishes to `gh-pages`. The last verified GitHub Pages setting (2026-09-27) still used legacy `main:/docs`; the repository owner must switch Pages to **GitHub Actions** (or `gh-pages`) before that workflow output is served.

> ⚠️ This repository setting can only be changed by the owner in Settings → Pages. Until Pages is configured for **GitHub Actions** or the `gh-pages` branch, it may continue serving the legacy `main:/docs` source instead of the workflow output.

## Post format

### Annotated bibliographies (`posts/*.qmd`)

Every annotated bibliography in `posts/` follows this structure:

```yaml
---
title: "Fichamento: [ARTICLE/CHAPTER TITLE]"
subtitle: "[AUTHOR(S) (YEAR)]"
author: "Tales Mançano"
date: "YYYY-MM-DD"
last-updated: "YYYY-MM-DD"
categories: [Annotated Bibliography, THEME, OPTIONAL-THEME, OPTIONAL-GEOGRAPHY]
tags: [kebab-case-concept, ...]
format:
  html:
    toc: true
    number-sections: true
    theme: cosmo
    highlight-style: github
    execute: false
---
```

After the YAML, each post has:
1. APA 7 citation
2. Collapsible BibTeX callout (citekey pattern: `Author-etal2005`)
3. Paragraph-by-paragraph summary organized by section (`##`) and subsection (`###`) with paragraph references `[§1–§5]`
4. Synthetic Argument (`.callout-note` block)
5. Critical Analytical Card — *Ficha Analítica Crítica* — a Markdown table evaluating research question, puzzle type, methods, DGP, findings, limitations, theoretical perspective, and key references

### Zettelkasten / concept notes (`posts/notes/*.qmd`)

The `posts/notes/` subfolder hosts **synthetic concept notes** — Zettelkasten-style entries about a single theoretical concept, debate, or analytical framework, rather than a single bibliographic work. These are different from annotated bibliographies:

- **Layer A category:** always `Descriptive Note`
- **Naming convention:** `ConceptOrDebate-MainAuthorYear.qmd` (e.g. `VoC-Hall-Soskice2001.qmd`)
- **Structure:** free-form, but should include: (1) statement of the central puzzle or concept, (2) key mechanisms/pillars, (3) synthesis, (4) extensions/critiques, and (5) a reference list
- **Tags:** use existing kebab-case tags; concept notes are a good place to synthesize tags that appear across many annotated bibliographies
- **Purpose:** to distill cross-cutting theoretical knowledge that would otherwise be scattered across many individual fichamentos

Do **not** apply `fix_spaces.R` to notes, as they are written directly (not LLM-generated from PDFs).

## Category system

Governed by [`CATEGORIES.md`](CATEGORIES.md). Three layers, ≤5 categories total per post:

| Layer | Rule | Examples |
|-------|------|---------|
| **A — Post type** | Exactly 1, always first | `Annotated Bibliography`, `Essay` |
| **B — Substantive theme** | 1–4 from the canonical list | `Political Economy`, `Higher Education`, `Inequality` |
| **C — Geographic scope** | 0–1, only if the work is explicitly regional | `Brazil`, `Western Europe` |

Fine-grained concepts go in `tags` (kebab-case), not categories. A tag may be promoted to a category only after appearing in 5+ posts. All changes to allowed categories must be made in `CATEGORIES.md` first, then reflected in `fix_categories.R`.

## fix_spaces.R behaviour

Runs 4 passes on a single `.qmd` to:
- Replace `***` with `---` (LLM frontmatter delimiter artefact)
- Strip content before the first `---` and after the last `::::`
- Remove a single leading space from lines outside code blocks and indented YAML blocks
- Normalise indentation of the `format:` block in the YAML to the canonical 2/4-space structure


