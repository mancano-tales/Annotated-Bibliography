# `_raw/` — matéria-prima, não conteúdo publicado

Texto bruto extraído de PDFs, ainda **sem** frontmatter YAML: insumo para
fichamentos, não fichamento pronto.

Quarto ignora diretórios cujo nome começa com `_`, então nada aqui é
renderizado nem entra na listagem da home — não é preciso adicionar
exclusões em `_quarto.yml`.

Quando um arquivo daqui virar fichamento de verdade (frontmatter completo,
citação APA, callout BibTeX, resumo parágrafo a parágrafo e Ficha Analítica
Crítica, conforme o `CLAUDE.md`), mova-o para `posts/`.

## Conteúdo atual

| Arquivo | Origem | Observação |
|---|---|---|
| `Garay.qmd` | Fairfield, T. & Garay, C. (2017), *Redistribution under the Right in Latin America*, Comparative Political Studies — via LSE Research Online | Texto integral com marcadores `<!-- ¶ N -->`. Estava em `posts/`, onde entrava quebrada na listagem da home e gerava `WARN: contains no metadata` a cada render. Movido em 2026-07-21. |
