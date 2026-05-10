# 📚 Annotated Bibliography

**🌐 Language / Idioma:** &nbsp; [🇬🇧 English](#-annotated-bibliography) · [🇧🇷 Português](README.pt-br.md)

---

**Structured academic reading notes in political science, political economy, and historical sociology**

[![Quarto Publish](https://github.com/mancano-tales/Annotated-Bibliography/actions/workflows/publish.yml/badge.svg)](https://github.com/mancano-tales/Annotated-Bibliography/actions/workflows/publish.yml)

🔗 **Live site:** [mancano-tales.github.io/Annotated-Bibliography](https://mancano-tales.github.io/Annotated-Bibliography)

---

## About

This repository is an open-access, searchable collection of **structured annotated bibliographies** (*fichamentos*) produced by [Tales Mançano](https://mancano-tales.github.io) as part of his Master's research in political science. The site is built with [Quarto](https://quarto.org/) and automatically deployed to GitHub Pages.

Each entry is a detailed, paragraph-by-paragraph analytical summary of an academic work — book, journal article, book chapter, or working paper — accompanied by a **critical analytical card** (*Ficha Analítica Crítica*) that evaluates the text's research question, methods, data generation process, theoretical framework, findings, and limitations.

The bibliography currently contains **99 annotated entries — and counting** — covering topics in:

- **Comparative political economy** and **welfare state** research
- **Education policy and politics** — especially higher education, student finance, and educational inequality
- **Historical institutionalism** and institutional change
- **Development economics** and economic history
- **Social investment** and social policy
- **Democracy**, party politics, and redistribution
- **Brazilian politics** — with a focus on education policy, FIES, PROUNI, and inequality

---

## Who Is This For?

- **Graduate students** looking for structured summaries of key works in political economy, education policy, or comparative politics
- **Researchers** seeking critical engagement with the methodological strengths and limitations of specific studies
- **Anyone** interested in the political economy of education, welfare states, or Latin American development

---

## Structure of Each Entry

Every annotated bibliography post follows a standardized format generated with the aid of AI (LLMs), guided by a carefully iterated prompt (see [`Repo-Prompts/`](Repo-Prompts/)). Each entry contains:

1. **YAML metadata** — title, author, date, categories, and tags
2. **Full citation** (APA 7th edition) and **BibTeX entry** (collapsible)
3. **Critical Analytical Card** (*Ficha Analítica Crítica*) — a structured table evaluating:
   - Research question and puzzle type
   - Central argument and conclusion
   - Methods and data generation process (DGP)
   - Findings and contributions
   - Critical analysis of findings (identification threats, confounders, scope conditions)
   - Recognized and unrecognized limitations
   - Theoretical perspective and key references
4. **Argumentative Map** (for books) — a table showing how each chapter contributes to the central thesis
5. **Paragraph-by-paragraph summary** — organized by sections (`##`) and subsections (`###`) with paragraph references (`[§1–§3]`)
6. **Synthetic Argument** — a final callout summarizing the central thesis, what the text demonstrates vs. what remains as hypothesis, and its contribution to the broader debate

---

## Repository Structure

```
Annotated-Bibliography/
├── posts/                    # 99 annotated bibliography entries (.qmd)
├── Old_Website_Posts/        # Archived/legacy posts from earlier site versions
├── Repo-Prompts/             # Versioned AI prompts used to generate entries
├── files/
│   └── includes/             # HTML includes (Academicons, Altmetric, Dimensions badges)
├── _extensions/              # Quarto extensions (Font Awesome, etc.)
├── _quarto.yml               # Quarto project configuration
├── index.qmd                 # Homepage with searchable listing
├── CATEGORIES.md             # Canonical category taxonomy (single source of truth)
├── references.bib            # Master BibTeX bibliography (~2.2 MB)
├── fix_categories.R          # R script to normalize/audit categories across posts
├── fix_spaces.R              # R script for formatting fixes
├── category_audit.csv        # Output of the category audit script
├── custom.css                # CSS for inline Altmetric/Dimensions badges
├── styles.css                # Additional site styles
├── .github/workflows/
│   └── publish.yml           # GitHub Actions: auto-publish to GitHub Pages on push
└── docs/                     # Rendered site output (deployed via gh-pages)
```

---

## Category System

Posts are organized using a **three-layer taxonomy** documented in [`CATEGORIES.md`](CATEGORIES.md):

| Layer | Purpose | Examples |
|:------|:--------|:---------|
| **A — Post type** (exactly 1) | Format of the document | `Annotated Bibliography`, `Descriptive Note`, `Essay` |
| **B — Substantive theme** (1–4) | Disciplinary field + topics | `Political Economy`, `Higher Education`, `Inequality` |
| **C — Geographic scope** (0–1) | Regional focus, if any | `Brazil`, `Latin America`, `Western Europe` |

Fine-grained concepts (e.g., `causal-inference`, `path-dependence`, `affirmative-action`) go in **tags** (kebab-case), not categories. A tag can be promoted to a category only after appearing in 5+ posts.

---

## AI-Assisted Workflow

The annotated bibliographies are produced using a structured **AI-assisted workflow**:

1. The researcher reads the full text (PDF)
2. The PDF is submitted to an LLM (typically Claude, DeepSeek, or Perplexity) alongside a detailed **prompt template** (`Repo-Prompts/`)
3. The LLM generates a structured `.qmd` file following the standardized format
4. The researcher reviews, corrects, and enriches the output

The prompt has been iteratively refined over **17+ versions** (from v2 to v17.2). Its structure reflects the cumulative experience of the author across multiple academic environments:

- The **PLEA program** (*Programa de Leitura e Escrita Acadêmica*) at the University of São Paulo (USP), following Marcus Sacrini's structured reading and analytical writing method
- Graduate coursework at the **Department of Political Science (DCP), USP**
- The **Cluster of Excellence "The Politics of Inequality"** at the University of Konstanz, Germany
- Experience as a **Visiting Student Researcher at Stanford University**, particularly Steve Haber's seminar on **Comparative Political Economy**

These formative experiences shaped the analytical dimensions of the critical card — from the emphasis on data generation processes and identification threats to the structured attention to theoretical frameworks and scope conditions.

Each entry records the LLM model and prompt version used, ensuring transparency and reproducibility.

---

## Technical Stack

| Component | Technology |
|:----------|:-----------|
| Static site generator | [Quarto](https://quarto.org/) (website project type) |
| Theme | Cosmo (Bootstrap) |
| Deployment | GitHub Actions → GitHub Pages (`gh-pages` branch) |
| Bibliography | BibTeX (`references.bib`, ~2.2 MB, managed via Zotero) |
| Category management | R scripts (`fix_categories.R`, `fix_spaces.R`) |
| Quarto extensions | Font Awesome, Academicons |
| Academic badges | Altmetric, Dimensions, PlumX (via HTML includes) |
| Search | Built-in Quarto search (navbar textbox) |

---

## Running Locally

To build the site locally:

```bash
# Clone the repository
git clone https://github.com/mancano-tales/Annotated-Bibliography.git
cd Annotated-Bibliography

# Render the site (requires Quarto CLI installed)
quarto render

# Or preview with live reload
quarto preview
```

> **Requirements:** [Quarto CLI](https://quarto.org/docs/get-started/) ≥ 1.4 and [R](https://cran.r-project.org/) (for category audit scripts).

---

## License & Citation

All content is © Tales Mançano. The annotated bibliographies are personal academic reading notes and critical summaries intended for educational purposes. Original works remain the intellectual property of their respective authors.

If you find this resource useful, consider linking to the [live site](https://mancano-tales.github.io/Annotated-Bibliography) or citing it as:

> Mançano, T. (2026). *Annotated Bibliography: Fichamentos acadêmicos em ciência política, economia política e sociologia histórica*. Available at: https://mancano-tales.github.io/Annotated-Bibliography

---

## Contact

📧 You can reach Tales Mançano via the email listed on his [GitHub profile](https://github.com/mancano-tales).

---

<sub>This README was written by [Antigravity AI](https://deepmind.google/) (Claude Opus 4.6) on May 9, 2026, based on a full review of the repository's content and structure.</sub>
