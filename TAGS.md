# Tag registry and maintenance rules

This file is the canonical registry for fine-grained concepts and methods used in public reading notes. Categories remain broad and follow [`CATEGORIES.md`](CATEGORIES.md); tags improve precise search across works.

## Rules

1. Use the registered **lowercase kebab-case ID** in QMD front matter.
2. A tag is optional. Add it only when it improves retrieval; do not infer it from a keyword alone.
3. Before adding an ID, search this registry for an existing concept or alias. Add a short definition and any retired spelling here first.
4. Merge two IDs only when they name the same concept. Preserve distinctions between related methods, theories, and programs.
5. Do not use years, model names, temporary prompt versions, or generic labels as tags.
6. Run `Rscript code/audit_tags.R` before publishing a batch. The audit checks every `.qmd` under `posts/`, creates `0-governance/audit/tag-usage.csv`, and exits with an error for an unregistered, malformed, duplicated, or retired alias ID.
7. Review one-off tags during the annual taxonomy review. Keep them when they provide a useful retrieval path; otherwise consolidate them into a registered broader concept.

## Canonical tags

| ID | Definition and use | Retired aliases |
|---|---|---|
| `academic-writing` | Methods and practices for academic reading, synthesis, and writing. | |
| `affirmative-action` | Policies that address historical exclusion or unequal access through group-conscious measures. | |
| `allocation-rules` | Rules that assign places, resources, or opportunities across applicants or groups. | |
| `case-selection` | Principles and techniques for choosing cases in qualitative or comparative research. | |
| `causal-inference` | Designs and assumptions used to identify causal effects or mechanisms. | |
| `class-origin` | Family or social-class background and its consequences for life chances. | |
| `cluster-analysis` | Methods that group observations using similarity or distance criteria. | |
| `coalitional-presidentialism` | Coalition formation and executive–legislative governance in presidential systems. | |
| `comparative-institutional-advantage` | The claim that institutional arrangements advantage different forms of production or innovation. | |
| `comparative-politics` | Cross-case comparison of political institutions, processes, or outcomes. | |
| `convergence-thesis` | The proposition that institutional or economic models become more alike over time. | |
| `cook-distance` | Cook's distance as a diagnostic for influential observations in regression. | |
| `coordinated-market-economy` | A capitalism model in which firms coordinate through strategic interaction and non-market institutions. | CME |
| `democratic-theory` | Normative or explanatory concepts of democracy and democratic institutions. | |
| `descriptive-analysis` | Systematic measurement and characterization of a phenomenon without overstating causal inference. | |
| `deviant-case` | A case whose observed outcome differs from what a theory or model predicts. | |
| `directed-acyclic-graphs` | Directed acyclic graphs used to represent causal assumptions and dependencies. | |
| `economic-history` | Historical analysis of economic structures, processes, and outcomes. | |
| `effectively-maintained-inequality` | The theory that advantaged groups preserve relative educational advantage as access expands. | EMI |
| `enade` | Brazil's National Student Performance Exam and its use in higher-education analysis. | ENADE |
| `enrollment-rates` | Measures of school or higher-education participation and access. | |
| `epidemiology` | The study of health events, distributions, and determinants in populations. | |
| `epistemology` | Assumptions about knowledge, evidence, explanation, and inference. | |
| `fies` | Brazil's Fundo de Financiamento Estudantil and related student-finance policy. | FIES |
| `fiscal-decentralization` | The assignment of revenue, spending, or fiscal authority across levels of government. | |
| `graduate-pedagogy` | Teaching and learning practices in graduate education. | |
| `hall-soskice` | The varieties-of-capitalism framework associated with Peter Hall and David Soskice. | |
| `hierarchical-market-economy` | A capitalism model characterized by hierarchical firms and segmented coordination, especially in Latin America. | HME |
| `horizontal-stratification` | Differences in status or outcomes among fields, institutions, or tracks at the same educational level. | |
| `human-capital` | Skills and knowledge treated as productive capacities shaped by education or training. | |
| `imperial-brazil` | Political, economic, and social processes in Brazil's imperial period. | |
| `incremental-innovation` | Cumulative improvement of existing products, processes, or technologies. | |
| `industrial-organization` | Market structure, firm behavior, competition, and their regulation. | |
| `institutional-change` | Processes through which formal or informal institutions change over time. | |
| `institutional-complementarities` | Reinforcing effects between institutions in different domains. | |
| `institutional-gatekeeping` | Institutional rules or actors that regulate access and participation. | |
| `knowledge-production` | The organization, practices, and institutional conditions of producing knowledge. | |
| `lei-de-cotas` | Brazil's federal higher-education quota law and its policy effects. | Lei-de-Cotas |
| `liberal-market-economy` | A capitalism model in which firms coordinate primarily through competitive markets. | LME |
| `maximally-maintained-inequality` | The theory that advantaged groups maintain access advantages until participation reaches saturation. | MMI |
| `methodological-pluralism` | The use or evaluation of multiple methodological approaches to answer a research problem. | |
| `mixed-methods` | Research that integrates qualitative and quantitative evidence or analysis. | |
| `most-different` | A case-selection strategy comparing cases that differ on background conditions. | |
| `most-similar` | A case-selection strategy comparing similar cases that differ on an outcome or key factor. | |
| `multilevel-methods` | Methods for analyzing data or processes organized at multiple levels. | |
| `non-convergence` | Persistent institutional or outcome differences despite pressures toward similarity. | |
| `philosophy-of-social-sciences` | Philosophical debates about explanation, concepts, evidence, and methods in social inquiry. | |
| `process-tracing` | Within-case analysis that evaluates evidence for causal mechanisms and sequences. | |
| `propensity-score-matching` | Matching observations on estimated treatment probabilities to improve comparability. | |
| `prouni` | Brazil's University for All program and related access or financing policy. | PROUNI |
| `public-policy` | Policy design, implementation, evaluation, and political process. | |
| `qualitative-methods` | Qualitative research designs, evidence, and analytical techniques. | |
| `quantitative-methods` | Statistical or computational methods for analyzing quantitative data. | |
| `radical-innovation` | Innovation that creates new products, technologies, or markets. | |
| `regression-models` | Regression-based statistical models and their assumptions or interpretation. | |
| `small-n` | Comparative or case-based research with a small number of observations or cases. | |
| `social-policy` | Public programs and institutions that address social risks, services, and redistribution. | |
| `sociology-of-education` | Sociological analysis of educational institutions, stratification, and outcomes. | |
| `sociology-of-organizations` | Sociological analysis of organizations, organizational fields, and institutional change. | |
| `tertiary-education` | Higher education systems, institutions, access, and outcomes. | |
| `typical-case` | A case selected as representative of a theoretical or empirical pattern. | |
| `valence-model` | An account of competition in which parties are evaluated on shared-valued goals or competence. | |
| `varieties-of-capitalism` | Comparative analysis of distinct institutional models of capitalism. | |
