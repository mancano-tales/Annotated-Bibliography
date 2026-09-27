---
tipo: Plano
titulo: "Auditoria metodológica, editorial e técnica da bibliografia anotada"
status: CONCLUÍDO
criado: "2026-09-27"
concluido: "2026-09-27"
issue: 7
agentes:
  orquestrador: "Codex / GPT-6 / Codex desktop"
  executor: "Codex / GPT-6 / Codex desktop"
  auditor: null
autor_humano: "Tales Mançano"
tarefas:
  - { desc: "Inventariar QMDs, metadados, datas, nomes, links e variantes; confirmar duplicatas", status: concluída, data: "2026-09-27" }
  - { desc: "Recuperar publicação Pages e reorganizar homepage, navegação e páginas metodológicas", status: concluída, data: "2026-09-27" }
  - { desc: "Definir formato de fechamento e migrar conteúdo sem alterar datas originais", status: concluída, data: "2026-09-27" }
  - { desc: "Criar registro canônico, regra e auditoria sistemática de tags", status: concluída, data: "2026-09-27" }
  - { desc: "Renomear repositório; definir descrição, homepage, topics e novo URL canônico", status: concluída, data: "2026-09-27" }
  - { desc: "Atualizar READMEs, AGENTS.md, scripts, links e validar site e clone", status: concluída, data: "2026-09-27" }
relacionados:
  - "mancano-repo-hub: repo-governance/plan/2026-09-27_Plano_Revisao_Metodologica_Annotated_Bibliography.md (issue #33)"
news: []
---

# Auditoria metodológica, editorial e técnica da bibliografia anotada

## Aprovação e escopo

O autor aprovou no chat em 2026-09-27 a execução automatizada. A proposta prioriza explicar **como** produzir fichamentos e fechar uma análise, não promover as disciplinas cobertas. O escopo inclui inventário e comparação dos QMDs, remoção de duplicatas confirmadas, títulos e nomes de arquivo coerentes, taxonomia de tags, nova navegação, metadados GitHub, renomeação do repositório e do diretório local.

**Preservar datas de origem:** títulos, nomes, conteúdo e organização podem mudar; datas `date` e `last-updated` só mudam quando houver evidência da data real correspondente, nunca para a data da revisão. Não apagar conteúdo histórico em lote. Duplicata só é removida quando conteúdo e metadados comprovarem redundância; manter a versão mais completa e registrar a decisão.

Ficam excluídos: `.vscode/`, exportações de conversa, saída Beamer `.tex`, HTML/cache de render local e `tools/__pycache__/`. Manter as cópias locais fora do staging.

## Evidência inicial

- 137 QMDs em `posts/`; 66 tags distintas, 58 de uso único, 100 QMDs sem a chave `tags`.
- A página inicial lista `posts/` com tamanho de página 100 e filtros gerais.
- As seções finais variam, com ocorrências de “Argumento Sintético” e “Ficha Analítica” sob cabeçalhos diferentes. Revisar o conteúdo antes de normalizar.
- `Old_Website_Posts/` contém acervo histórico separado; não está na lista atual de renderização e não será alvo de remoção em massa.
- O Pages estava em `main:/docs` com status `errored`, enquanto Actions publica em `gh-pages`.
- Descrição, homepage e topics do repositório estavam vazios; dois scripts R usavam caminho absoluto da máquina.

## Plano de execução

1. Gerar inventário reproduzível com caminho, título, subtítulo, tipo, datas originais, categorias, tags, DOI/citekey, links e hashes; localizar duplicatas exatas e candidatos de versão, comparar corpo e completude, e registrar retenção/remoção.
2. Trocar a fonte do Pages para GitHub Actions, confirmar deploy e fazer revisão visual de referência.
3. Definir modelo editorial de fechamento: reconstrução do argumento e suas evidências; síntese final; avaliação crítica; limites e condições de escopo. A página metodológica explica as etapas, critérios de qualidade, autoria/revisão e casos em que o formato deve variar. Distinguir a conclusão original da obra da síntese e avaliação do fichamento.
4. Normalizar títulos e nomes de arquivo em lotes, preservando datas e DOI/citekeys. Antes de mudar um caminho público, conservar permalink ou gerar e verificar redirect; não remover variantes que representem diferenças metodológicas relevantes.
5. Criar `TAGS.md` como registro canônico: slug minúsculo em kebab-case, conceito, descrição, sinônimos e regra de uso. Auditar tags ausentes, não registradas, duplicadas, de uma ocorrência e confundidas com categorias. Consolidar aliases semanticamente equivalentes; tags de ocorrência única permanecem se melhorarem a recuperação. Não atribuir tags automaticamente por simples correspondência lexical.
6. Reestruturar homepage para apresentar método e caminhos de leitura. Ter páginas próprias para coleção, notas e arquivo; limitar filtros e listagens a conteúdos publicados, com paginação curta e navegação clara. Atualizar CSS sem dificultar leitura, busca, impressão ou acessibilidade.
7. Renomear no GitHub para `annotated-bibliography`, mudar Pages ao endereço canônico `https://mancano-tales.github.io/annotated-bibliography/`, cadastrar descrição, homepage e topics metodológicos; atualizar badges, clone commands, navbar, footer, citações e referências internas. Atualizar `origin` local.
8. Remover caminhos absolutos dos scripts, renomear a pasta local com nome minúsculo e alinhar `.gitignore`, mapa `README.md` e `tools/governanca-comum/repos.txt` do hub. Preservar todos os arquivos locais excluídos do escopo.
9. Render completo via `code/render-posts.ps1 -All`; validar conteúdo da listagem, links/redirects, datas, busca, paginação, RSS/sitemap, metadados de tags e execução de Actions/Pages. Registrar evidências e commits no `NEWS.md`.

## Critérios de conclusão

- O site usa o novo endereço e é servido pelo workflow de Actions.
- Homepage e página de método dão destaque ao processo de fichamento e à construção/revisão dos fechamentos.
- Inventário documenta candidatos e evidências; só duplicatas comprovadas são removidas; datas originais permanecem.
- Tags têm registro, definições, regra de manutenção e relatório de auditoria; aliases são resolvidos deliberadamente.
- Repositório e pasta local estão em minúsculas; descrição, homepage, topics, READMEs, instruções e referências internas concordam.
- Nenhum arquivo excluído do escopo é apagado, staged ou commitado.

## Resultado e evidências

- O repositório e a pasta local agora se chamam `annotated-bibliography`; `origin`, badges, clone commands, links e configuração do Quarto usam o slug minúsculo.
- O GitHub exibe a descrição metodológica aprovada, homepage `https://mancano-tales.github.io/annotated-bibliography/` e dez topics relacionados a fichamento, leitura crítica, análise de argumentos e Quarto.
- `code/render-posts.ps1 -All` compilou 126/126 entradas. O workflow Pages [36332351139](https://github.com/mancano-tales/annotated-bibliography/actions/runs/36332351139) terminou com sucesso.
- Auditorias finais: 156 QMDs inventariados; uma duplicata idêntica confirmada e removida; oito alternativas substanciais preservadas; cinco rascunhos incompletos mantidos fora da publicação; 63 tags canônicas usadas e auditoria sem IDs inválidos ou registrados sem uso.
- Sitemap de 126 URLs, feed RSS de 20 itens, aliases para os caminhos antigos e ausência dos cinco rascunhos na publicação foram verificados. As datas de origem foram preservadas.
- `.vscode/`, `0-meta/`, `.tex` gerado e `tools/__pycache__/` permaneceram locais e fora do commit.
