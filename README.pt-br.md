# 📚 Bibliografia Anotada

**🌐 Language / Idioma:** &nbsp; [🇬🇧 English](README.md) · [🇧🇷 Português](#-bibliografia-anotada)

---

**Fichamentos acadêmicos em ciência política, economia política e sociologia histórica**

[![Quarto Publish](https://github.com/mancano-tales/Annotated-Bibliography/actions/workflows/publish.yml/badge.svg)](https://github.com/mancano-tales/Annotated-Bibliography/actions/workflows/publish.yml)

🔗 **Site ao vivo:** [mancano-tales.github.io/Annotated-Bibliography](https://mancano-tales.github.io/Annotated-Bibliography)

---

## Sobre

Este repositório é uma coleção aberta e pesquisável de **fichamentos acadêmicos estruturados** produzidos por [Tales Mançano](https://mancano-tales.github.io) como parte de sua pesquisa de mestrado em ciência política. O site é construído com [Quarto](https://quarto.org/); o GitHub Actions renderiza e publica o site, conforme a configuração da fonte do Pages descrita abaixo.

Cada entrada é um resumo analítico detalhado, parágrafo a parágrafo, de uma obra acadêmica — livro, artigo, capítulo ou working paper — acompanhado de uma **Ficha Analítica Crítica** que avalia a pergunta de pesquisa, os métodos, o processo de geração de dados, o referencial teórico, os achados e as limitações do texto.

A bibliografia contém atualmente **131 entradas categorizadas como Annotated Bibliography** — e crescendo — cobrindo temas como:

- **Economia política comparada** e **welfare states**
- **Política educacional** — especialmente ensino superior, financiamento estudantil e desigualdade educacional
- **Institucionalismo histórico** e mudança institucional
- **Economia do desenvolvimento** e história econômica
- **Investimento social** e política social
- **Democracia**, partidos políticos e redistribuição
- **Política brasileira** — com foco em FIES, PROUNI, política educacional e desigualdade

---

## Para Quem É Este Repositório?

- **Pós-graduandos** buscando resumos estruturados de obras-chave em economia política, política educacional ou política comparada
- **Pesquisadores** interessados em engajamento crítico com as forças e limitações metodológicas de estudos específicos
- **Qualquer pessoa** interessada na economia política da educação, welfare states ou desenvolvimento latino-americano

---

## Estrutura de Cada Fichamento

Cada fichamento segue um formato padronizado, gerado com auxílio de IA (LLMs) e guiado por um prompt cuidadosamente iterado (ver [`prompts/`](prompts/)). Cada entrada contém:

1. **Metadados YAML** — título, autor, data, categorias e tags
2. **Citação completa** (APA 7ª edição) e **entrada BibTeX** (colapsável)
3. **Ficha Analítica Crítica** — uma tabela estruturada que avalia:
   - Questão de pesquisa e tipo de puzzle
   - Argumento central e conclusão
   - Métodos e processo de geração de dados (DGP)
   - Achados e contribuições
   - Análise crítica dos achados (ameaças à identificação, confundidores, scope conditions)
   - Limitações reconhecidas e não reconhecidas
   - Perspectiva teórica e referências principais
4. **Mapa Argumentativo** (para livros) — uma tabela mostrando como cada capítulo contribui para a tese central
5. **Resumo parágrafo a parágrafo** — organizado por seções (`##`) e subseções (`###`) com referências aos parágrafos (`[§1–§3]`)
6. **Argumento Sintético** — um bloco final sintetizando a tese central, o que o texto demonstra vs. o que permanece como hipótese, e sua contribuição para o debate mais amplo

---

## Arquivos e Pastas Principais

```
Annotated-Bibliography/
├── posts/                    # 137 QMDs: 131 fichamentos, notas e apresentações
│   └── notes/                # Notas conceituais
├── Old_Website_Posts/        # Posts arquivados de versões anteriores do site
├── prompts/                  # Prompts versionados (planilhas, podcasts, qmd-blog-posts)
├── code/                     # Renderizador seguro e scripts R de manutenção
├── tools/                    # Utilitários de planos e NEWS para governança do repositório
├── files/includes/           # Includes HTML (Academicons, Altmetric, Dimensions)
├── _extensions/              # Extensões Quarto (Font Awesome etc.)
├── .github/workflows/publish.yml # Workflow de build e publicação do GitHub Actions
├── _quarto.yml               # Configuração do projeto Quarto
├── index.qmd                 # Página inicial com listagem pesquisável
├── CATEGORIES.md             # Taxonomia canônica de categorias (fonte única de verdade)
├── references.bib            # Bibliografia mestre BibTeX (~2.2 MB)
├── category_audit.csv        # Saída do script de auditoria de categorias
├── custom.css / styles.css   # Estilos específicos do site
├── README.md / README.pt-br.md # Visões gerais em inglês e português
├── AGENTS.md                 # Instruções para agentes (fonte de verdade)
├── NEWS.md / TODO.md         # Histórico de mudanças e lista de tarefas
└── docs/                     # Saída local de renderização; ignorada pelo git
```

A contagem considera os arquivos cuja categoria no front matter Quarto é `Annotated Bibliography`. A pasta `docs/` é gerada localmente e não é versionada.

As apresentações Beamer em `posts/` são fontes, não páginas do site; o build do site as exclui para não exigir uma instalação de LaTeX.

---

## Sistema de Categorias

Os posts são organizados usando uma **taxonomia de três camadas**, documentada em [`CATEGORIES.md`](CATEGORIES.md):

| Camada | Finalidade | Exemplos |
|:-------|:-----------|:---------|
| **A — Tipo do post** (exatamente 1) | Formato do documento | `Annotated Bibliography`, `Descriptive Note`, `Essay` |
| **B — Tema substantivo** (1–4) | Campo disciplinar + tópicos | `Political Economy`, `Higher Education`, `Inequality` |
| **C — Escopo geográfico** (0–1) | Foco regional, se houver | `Brazil`, `Latin America`, `Western Europe` |

Conceitos granulares (ex.: `causal-inference`, `path-dependence`, `affirmative-action`) vão em **tags** (kebab-case), não em categorias. Uma tag só pode ser promovida a categoria após aparecer em 5+ posts.

---

## Fluxo de Trabalho com Auxílio de IA

Os fichamentos são produzidos usando um **fluxo de trabalho estruturado com auxílio de IA**:

1. O pesquisador lê o texto completo (PDF)
2. O PDF é submetido a um LLM (tipicamente Claude, DeepSeek ou Perplexity) junto com um **template de prompt** detalhado (`prompts/`)
3. O LLM gera um arquivo `.qmd` estruturado seguindo o formato padronizado
4. O pesquisador revisa, corrige e enriquece o output

O prompt foi iterativamente refinado ao longo de **17+ versões** (o repositório inclui versões até v17.4). Sua estrutura reflete a experiência acumulada do autor em múltiplos ambientes acadêmicos:

- O **PLEA** (*Programa de Leitura e Escrita Acadêmica*) na Universidade de São Paulo (USP), seguindo o método de leitura estruturada e escrita analítica de Marcus Sacrini
- Disciplinas de pós-graduação no **Departamento de Ciência Política (DCP) da USP**
- O **Cluster de Excelência "The Politics of Inequality"** na Universidade de Konstanz, Alemanha
- Experiência como **Visiting Student Researcher na Stanford University**, em particular o seminário de **Comparative Political Economy** de Steve Haber

Essas experiências formativas moldaram as dimensões analíticas da ficha crítica — desde a ênfase nos processos de geração de dados e ameaças à identificação até a atenção estruturada a referenciais teóricos e scope conditions.

Cada entrada registra o modelo de IA e a versão do prompt utilizados, garantindo transparência e reprodutibilidade.

---

## Stack Técnico

| Componente | Tecnologia |
|:-----------|:-----------|
| Gerador de sites estáticos | [Quarto](https://quarto.org/) (tipo website) |
| Tema | Cosmo (Bootstrap) |
| Deploy | O GitHub Actions publica em `gh-pages`; a fonte do Pages precisa apontar para lá |
| Bibliografia | BibTeX (`references.bib`, ~2.2 MB, gerenciado via Zotero) |
| Gestão de categorias | Scripts R (`code/fix_categories.R`, `code/fix_spaces.R`) |
| Extensões Quarto | Font Awesome, Academicons |
| Badges acadêmicos | Altmetric, Dimensions, PlumX (via HTML includes) |
| Busca | Busca nativa do Quarto (caixa de texto na navbar) |

**Configuração do Pages:** o workflow publica em `gh-pages`, mas a última checagem das configurações (2026-09-27) encontrou o GitHub Pages ainda apontado para a fonte legada `main:/docs`. O proprietário do repositório precisa mudar a fonte do Pages para **GitHub Actions** (ou `gh-pages`) para que a saída do workflow seja publicada.

---

## Executando Localmente

Para construir o site localmente:

```powershell
# Clone o repositório
git clone https://github.com/mancano-tales/Annotated-Bibliography.git
cd Annotated-Bibliography

# Renderize todos os posts com segurança (requer PowerShell e Quarto CLI)
.\code\render-posts.ps1 -All

# Ou pré-visualize com live reload
quarto preview
```

> **Requisitos:** [Quarto CLI](https://quarto.org/docs/get-started/) ≥ 1.4 e [R](https://cran.r-project.org/) (para os scripts de auditoria de categorias).

---

## Licença e Citação

Todo o conteúdo é © Tales Mançano. Os fichamentos são notas pessoais de leitura acadêmica e resumos críticos com finalidade educacional. As obras originais permanecem propriedade intelectual de seus respectivos autores.

Se este recurso for útil para você, considere linkar para o [site ao vivo](https://mancano-tales.github.io/Annotated-Bibliography) ou citá-lo como:

> Mançano, T. (2026). *Annotated Bibliography: Fichamentos acadêmicos em ciência política, economia política e sociologia histórica*. Disponível em: https://mancano-tales.github.io/Annotated-Bibliography

---

## Contato

📧 Você pode contatar Tales Mançano pelo e-mail disponível em seu [perfil no GitHub](https://github.com/mancano-tales).

---

<sub>Atualizado em 2026-09-27.</sub>
