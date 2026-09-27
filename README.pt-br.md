# Bibliografia Anotada

**Uma coleção metodológica de fichamentos estruturados e fechamentos analíticos críticos.**

[![Publicar site](https://github.com/mancano-tales/annotated-bibliography/actions/workflows/publish.yml/badge.svg)](https://github.com/mancano-tales/annotated-bibliography/actions/workflows/publish.yml)

**Site:** <https://mancano-tales.github.io/annotated-bibliography/> · **Método:** [Como funciona o fechamento analítico](method.qmd) · [Feed RSS](https://mancano-tales.github.io/annotated-bibliography/bibliography.xml)

## Sobre

Este site aberto documenta um método reproduzível de leitura atenta de obras acadêmicas. Cada fichamento reconstrói a pergunta, o argumento, o desenho e as evidências da obra antes de avaliar o que elas sustentam e onde a inferência termina. O destaque está no modo de analisar; as obras cobrem assuntos e disciplinas diversos.

O fichamento complementa a fonte, não a substitui. Referências a páginas e parágrafos ajudam a conferir os argumentos na obra original.

## Como o fichamento se fecha

As seções finais mantêm distintas três tarefas:

1. **Conclusão da obra** — o que os autores concluem e quais evidências apresentam.
2. **Argumento Sintético** — uma reconstrução concisa da tese, do raciocínio, do suporte e dos limites.
3. **Ficha Analítica Crítica** — uma avaliação da relação entre pergunta, desenho, evidências, inferência e escopo.

A [página de método](method.qmd) explica a sequência, os critérios de qualidade e os casos em que o formato deve ser adaptado.

## Navegação

- [Pesquisar os fichamentos](bibliography.qmd)
- [Ler as notas conceituais](notes.qmd)
- [Conhecer o método](method.qmd)

## Mapa do repositório

```text
posts/                    fichamentos de obras específicas
posts/notes/              notas conceituais que cruzam obras
Old_Website_Posts/        arquivo histórico de fontes
prompts/                  prompts versionados de elaboração
code/                     renderização segura e scripts de manutenção
tools/                    utilitários de planos e NEWS
0-governance/plan/        planos aprovados e históricos
0-governance/audit/       relatórios versionados de auditoria do corpus e tags
0-governance/archive/     variantes preservadas fora da publicação
_extensions/              extensões do Quarto
files/includes/           includes HTML do site
index.qmd                 página inicial
bibliography.qmd          catálogo pesquisável
method.qmd                método de fechamento analítico
notes.qmd                 catálogo de notas conceituais
TAGS.md                  registro canônico e guia de tags
CATEGORIES.md             taxonomia canônica de categorias
references.bib            bibliografia mestre em BibTeX
```

`docs/` é a saída local de renderização e fica fora do Git. O GitHub Actions constrói o site e o publica no GitHub Pages.

## Tags e categorias

As categorias amplas seguem [`CATEGORIES.md`](CATEGORIES.md). Conceitos específicos usam identificadores em minúsculas e kebab-case documentados no registro canônico [`TAGS.md`](TAGS.md). Execute a auditoria antes de adicionar ou publicar tags:

```powershell
Rscript code/audit_tags.R
```

## Renderização local

Requisitos: [Quarto CLI](https://quarto.org/docs/get-started/) e R.

```powershell
git clone https://github.com/mancano-tales/annotated-bibliography.git
cd annotated-bibliography

# Renderização incremental segura
.\code\render-posts.ps1

# Renderizar o site completo
.\code\render-posts.ps1 -All

# Pré-visualizar com atualização ao vivo
quarto preview
```

Use o renderizador seguro em vez de `quarto render` puro: ele protege a saída local se a renderização falhar.

## Citação e licença

Todo o conteúdo é © Tales Mançano. As obras originais permanecem propriedade intelectual de seus autores. Para citar, use a referência bibliográfica na página correspondente e o endereço canônico do site:

> Mançano, Tales. *Annotated Bibliography*. <https://mancano-tales.github.io/annotated-bibliography/>

---

*Estrutura do site revisada em 2026-09-27. As datas originais registradas nos fichamentos são preservadas durante revisões editoriais.*
