# Canonical Category List

This file is the **single source of truth** for allowed categories in this bibliography.
All categories must come from the lists below. No exceptions.

> **To add a new category:** a concept must first live as a `tag` for at least **5 posts**.
> Only after that threshold may it be proposed as a new category by updating this file.

---

## Layer A — Post type (exactly 1 per post, always listed first)

| Category | Description |
|---|---|
| `Annotated Bibliography` | Structured summary and critique of a single work |
| `Descriptive Note` | Reading/study notes, outlines, or chapter summaries |
| `Essay` | Original analytical or argumentative piece |
| `Index` | Reference entry, reading list, or organizational post |

---

## Layer B — Substantive theme (1–4 per post, from this list only)

### B1 — Disciplinary field

| Category | Description |
|---|---|
| `Comparative Politics/Political Economy` | Systematic cross-country or cross-regime comparison of political economies, institutions, or political systems |
| `Political Economy` | Relationship between economy and politics within a single context or non-comparative framework |
| `Development Economics` | Growth theory, historical development, and development economics |
| `Economics of Education` | Returns, markets, financing, and efficiency of education |
| `Economic History` | Long-run historical analysis of economic phenomena |
| `Historical Sociology` | Historical methods and macro-sociological explanation |
| `Institutional Economics` | Transaction costs, property rights, New Institutional Economics |
| `Sociology of Education` | Sociological approaches to education systems and outcomes |
| `Fiscal Sociology` | Taxation, public finance, and their social and political foundations |
| `Methodology` | Epistemology, research design, causal inference, and research methods |

### B2 — Substantive topics

| Category | Description |
|---|---|
| `Inequality` | Income, wealth, access, and opportunity inequality |
| `Educational Inequality` | Inequality of access, outcomes, and opportunity within education systems |
| `Social Mobility` | Intergenerational movement across economic or social strata |
| `Institutions` | Formation, change, and persistence of formal and informal institutions |
| `Historical Institutionalism` | Path dependence, critical junctures, and institutional layering |
| `Democracy` | Democratic theory, consolidation, backsliding, and quality of democracy |
| `State Formation` | Origins and building of state capacity and bureaucracy |
| `Welfare State/Social Policy` | Social protection, social insurance, and redistributive social policy |
| `Social Investment` | Human capital-oriented social policies; education and care investment |
| `Party Politics` | Parties, electoral competition, partisanship, and representation |
| `Coalitional Presidentialism` | Executive–legislative relations and coalition governance in presidential systems |
| `Education Policy/Politics` | Education policy, actors, political disputes, and reform |
| `Higher Education` | Universities, tertiary systems, access, and governance |
| `Private Education` | Private providers, public-private relations, and marketization in education |
| `Public Policy` | Policy design, implementation, evaluation, and the policy process |
| `Redistribution` | Fiscal redistribution, transfers, and distributive politics |
| `Elite Capture` | Elite control over institutions, policy, or public resources |
| `Agrarian Reform` | Land reform, property rights, and rural political economy |
| `Rural Development` | Agricultural policy, family farming, and rural economies |
| `Authoritarianism` | Non-democratic regimes, authoritarian resilience, and repression |
| `Federalism` | Federal arrangements, intergovernmental relations, and decentralization |
| `Vested Interests` | Organized interests, rent-seeking, and resistance to reform |
| `Post-communism` | Political and economic transitions from communist regimes |
| `European Integration` | EU institutions, enlargement, and supranational governance |
| `Imperial Brazil` | Brazilian Empire (1822–1889): politics, economy, and society |
| `Platform Capitalism` | Digital platforms, gig economy, and technology-driven business models |
| `Artificial Intelligence` | AI governance, labor impacts, and political economy of AI |

---

## Layer C — Geographic scope (0–1 per post)

Use this layer only when the work is explicitly and primarily focused on a specific region or country.
Do **not** assign a geographic category to purely theoretical or global-comparative works.

| Category | Description |
|---|---|
| `Brazil` | Work primarily focused on Brazil |
| `Latin America` | Work primarily focused on Latin America (multiple countries or region-wide) |
| `United States` | Work primarily focused on the United States |
| `Western Europe` | Work primarily focused on Western European countries |
| `Central and Eastern Europe` | Work primarily focused on post-communist Europe |
| `Scandinavia` | Work primarily focused on Nordic countries |
| `Southern Europe` | Work primarily focused on Mediterranean Europe (Spain, Italy, Portugal, Greece) |
| `Sub-Saharan Africa` | Work primarily focused on sub-Saharan Africa |
| `South Asia` | Work primarily focused on South Asian countries (India, Pakistan, Bangladesh, etc.) |
| `East Asia` | Work primarily focused on East Asian countries (China, Japan, South Korea, etc.) |
| `Global South` | Multi-regional work focused on developing and emerging economies |
| `Comparative` | Multi-country work without a defined regional focus |

---

## Governance rules

### Structure
- Categories are **Title Case** (e.g., `Welfare State/Social Policy`); tags are **kebab-case** (e.g., `causal-inference`).
- Every post must have **exactly one** Layer A category, listed **first**.
- Every post must have **at least one** Layer B category.
- A post should have no more than **5 categories total** across all layers.
- All concept-level terms go in `tags`, not `categories`. When in doubt, use a tag.

### What goes in tags (not categories)
Specific concepts, methods, and fine-grained topics that do not appear in 5+ posts — for example:
`causal-inference`, `regression-models`, `affirmative-action`, `coalition-analysis`,
`path-dependence`, `process-tracing`, `varieties-of-capitalism`, `teacher-unionism`,
`student-finance`, `land-conflicts`, `social-stratification`, `ideational-change`.

### Promoting a tag to a category
1. A tag must appear in at least **5 posts** before it can be proposed as a category.
2. Evaluate whether the concept is already covered by an existing category.
3. If justified, add the new category to the appropriate layer in this file and update `fix_categories.R`.
4. Update all affected posts.

### Retiring a category
1. A category with fewer than **3 posts** after an audit may be demoted back to a tag.
2. Affected posts must have their categories updated accordingly.

### Audit cadence
- Run `fix_categories.R` and review `category_audit.csv` whenever a batch of new posts is added.
- Review this file at least once per semester to assess whether any tags have crossed the promotion threshold.
