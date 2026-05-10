# Prompt Engineering — IA Planilhando Textos

This directory contains the versioned prompts used to generate AI-assisted academic reading notes (*fichamentos*) for this repository. Each prompt is designed to be attached alongside a PDF to an LLM chat session.

## Directory Structure

```
prompts/
├── spreadsheets/       # v03–v08: Output as Markdown tables (for Google Sheets/Excel)
├── podcasts/           # Analytical podcast script generator (NotebookLM)
├── qmd-blog-posts/     # v09–v17: Output as Quarto .qmd blog posts (current paradigm)
└── README.md           # This file
```

## Naming Convention

```
v{XX.X}_{YYYY-MM-DD}_{short-description}.md
```

- **Version** with zero-padding for natural sort order (`v03.0`, `v08.1`, `v14.1`)
- **Date** in ISO format
- **Description** in kebab-case summarizing the main change or feature

---

## Evolution Timeline

### Phase 1: Spreadsheet Output (`spreadsheets/`)

The original prompts produced **Markdown tables** for pasting into Google Sheets or Excel — one row per paper, columns for each analytical dimension.

| Version | Date | Key Change |
|:-------:|:----:|:-----------|
| **v03.0** | 2026-03-07 | Initial spreadsheet prompt. Raw table output with basic columns (citation, year, authors, research question, methods, findings, observations). No citation-key, no BibTeX |
| **v06.0** | 2026-03-08 | Added Zotero-compatible `citation-key` column, separated "Secondary Questions", introduced DGP (Data Generation Process) chain notation |
| **v07.0** | 2026-03-12 | Added `Model` column for LLM identification ("Modelo") |
| **v08.0** | 2026-03-13 | Added `Institution`, `Document Type`, `BibTeX Entry`, and `Timestamp` columns. Most bibliometrically complete spreadsheet version |
| **v08.1** | 2026-03-13 | Added "Ontological Consistency" check to `<thinking_guidance>` |

### Phase 2: Quarto Blog Posts (`qmd-blog-posts/`)

Starting with v09, the output paradigm shifted from tabular data to **full `.qmd` documents** — paragraph-by-paragraph reading notes with an integrated Critical Analytical Card.

| Version | Date | Key Change |
|:-------:|:----:|:-----------|
| **v09.0** | 2026-04-18 | **Paradigm shift:** Output changes to `.qmd` blog post. Introduces paragraph-by-paragraph summary (§1, §2…) + HTML-styled Critical Analytical Card table. Two-stage prompt |
| **v11.0** | 2026-04-18 | Added Etapa 3 (verification checklist), `system-ui` CSS fallback, paragraph ambiguity rules, explicit "mode transition" between descriptive and critical sections |
| **v12.0** | 2026-04-19 | Analytical Card changes from HTML table to **collapsible JSON** block. Checklist adds JSON validation rules |
| **v13.0** | 2026-04-19 | Analytical Card changes from JSON to **collapsible Markdown table** (abandons HTML and JSON). Adds `Prompt Version` to timestamp block |
| **v13.1** | 2026-04-19 | **English-language version** of v13.0. Same structure, output in English |
| **v13.2** | 2026-04-19 | Fork of v13.0 + Etapa 4 for **direct GitHub publishing** via MCP tool (`create_or_update_file`). Targets `mancano-tales.github.io` repo |
| **v14.0** | 2026-04-19 | **Structural reorder:** Analytical Card now appears *before* the paragraph-by-paragraph summary. Added handling for long texts (>50 pages). Introduced `Institution` dimension (13 total). Added `lang: "pt"` to YAML |
| **v14.1** | 2026-05-07 | Added **canonical category taxonomy** (Layer A: Type, Layer B: Theme, Layer C: Geography). References `CATEGORIES.md`. Introduced `tags` vs `categories` distinction |
| **v15.0** | 2026-04-19 | Clean **refactoring** as a self-contained, renderable Quarto document (has its own YAML front matter). Consolidation of v14.0 + v14.1 features |
| **v17.2** | 2026-05-08 | Most complete version. Added: text type identification (article/book/anthology), **Argumentative Map** for books, per-section length control, `coverage` YAML field, substantive footnote handling, anthology divergence tracking, `Etapa 0` (full reading before output) |

### Lateral: Podcast Script (`podcasts/`)

| Version | Date | Description |
|:-------:|:----:|:------------|
| **v02.0** | 2026-03-08 | Analytical podcast script generator for NotebookLM. Adversarial tone, four-block structure: Puzzle & Claim → DGP → Analytical Sabatina → Theory & Verdict. Based on the analytical framework from v06 |

---

## Current Recommended Prompt

The **current production prompt** is `v17.2` (or its successor in Google Drive). For English-language output, adapt from `v13.1`.

## How to Use

1. Open any LLM with PDF attachment support (Claude, ChatGPT, Gemini, etc.)
2. Attach the academic PDF
3. Paste the contents of the desired prompt version
4. The LLM will generate a `.qmd` file ready for the `posts/` directory

## Key Design Decisions

- **Adversarial-but-constructive** reviewer persona across all versions
- **Paragraph-by-paragraph** coverage ensures no content is lost
- **Critical Analytical Card** separates description from evaluation
- **Zotero-compatible citation keys** for bibliography integration
- **Quarto callouts** for visual hierarchy (`.callout-note`, `.callout-important`, `.callout-tip`)
