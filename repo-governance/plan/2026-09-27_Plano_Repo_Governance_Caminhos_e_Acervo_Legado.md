---
tipo: Plano
titulo: "Alinha governança, caminhos e acervo legado"
status: EM EXECUÇÃO
criado: "2026-09-27"
concluido: null
issue: 8
agentes:
  orquestrador: "Codex / GPT-6 / Codex desktop"
  executor: "Codex / GPT-6 / Codex desktop"
  auditor: null
autor_humano: "Tales Mançano"
tarefas:
  - { desc: "Renomear a governança para repo-governance e atualizar referências e ferramentas", status: concluída, data: "2026-09-27" }
  - { desc: "Auditar caminhos absolutos e removê-los sem alterar metadados bibliográficos", status: concluída, data: "2026-09-27" }
  - { desc: "Migrar fontes publicáveis do acervo antigo, preservar datas/URLs e registrar itens em triagem", status: concluída, data: "2026-09-27" }
  - { desc: "Confirmar duplicatas, remover apenas redundâncias comprovadas e excluir o projeto RStudio", status: concluída, data: "2026-09-27" }
  - { desc: "Documentar here::here(), corrigir a seleção do renderizador seguro e validar auditorias e render", status: concluída, data: "2026-09-27" }
  - { desc: "Corrigir a instalação de here na CI e confirmar renderização e deploy integrais", status: em andamento, data: "2026-09-27" }
relacionados:
  - "mancano-repo-hub: governança comum v2026-09-26d"
news: []
---

# Alinha governança, caminhos e acervo legado

## Aprovação e escopo

O autor aprovou no chat em 2026-09-27 executar a revisão sistêmica a partir dos avanços do `mancano-repo-hub`. O escopo inclui renomear `0-governance/` para `repo-governance/`; migrar fichamentos recuperáveis de `Old_Website_Posts/` para `posts/`; deduplicar apenas quando bibliografia e conteúdo confirmarem redundância; remover caminhos absolutos de máquina do repositório; padronizar scripts R com `here::here()`; remover o arquivo `.Rproj`; e mover itens obsoletos, gerados, incompletos ou fora do propósito para uma área de triagem documentada.

Issue de acompanhamento criada como #8 pela sessão web autenticada do GitHub. A integração de API do Codex ainda devolve 403 para escrita e o `gh` local está sem credencial válida; a issue permanece aberta durante a execução.

Preservar as datas `date` e `last-updated` dos originais. Para conteúdo migrado, criar aliases para URLs antigas quando aplicável. Não apagar material ambíguo: manter cópia versionada em `repo-governance/triage/` com motivo e origem no manifesto. Material pessoal/de planejamento, templates e rascunhos não serão publicados como fichamentos.

Ficam excluídos `.vscode/`, exportações de conversa, saídas geradas `.tex`, saída local `docs/` e `tools/__pycache__/`; não remover nem incluir essas cópias locais.

## Evidência inicial

- O diretório de governança é `0-governance/` e contém plano, auditoria e variantes preservadas; o índice de planos tem um plano anterior concluído (#7).
- `Old_Website_Posts/` contém 19 fontes QMD, páginas HTML geradas, scripts R antigos, templates e material de planejamento pessoal. A auditoria anterior apontou `Hall1993.qmd` e `Template.qmd` como possível duplicata, ainda exigindo comparação de conteúdo antes de consolidar.
- `references.bib` contém campos BibTeX `file` com referências locais a anexos; esses campos não são dados de citação e impedem a regra de zero caminhos absolutos.
- O projeto contém `Annotated-Bibliography.Rproj` e `.Rhistory`; a dependência R `here` ainda não está instalada neste ambiente.
- O ecossistema determina `repo-governance/` como nome canônico, caminhos sem dependência de máquina e exportação de conversa somente sob pedido do autor.

## Plano de execução

1. Inventariar arquivos rastreados e ignorados, referências operacionais à pasta de governança anterior, caminhos locais absolutos e conteúdo dos QMDs legados. Registrar o mapa de migração e os critérios de retenção.
2. Criar `repo-governance/triage/README.md` e inventário dos itens que aguardam revisão/remoção futura; manter os originais versionados e nunca apagar itens ambíguos.
3. Mover o diretório de governança para `repo-governance/`, atualizando configuração, documentação, scripts e links. Manter o nome histórico somente em registros históricos que descrevem decisões passadas.
4. Migrar para `posts/` apenas notas bibliográficas coerentes com o propósito atual; preservar datas e publicar aliases para URLs antigas. Consolidar duplicatas comprovadas sem perder trechos substantivos. Mover templates, drafts, páginas geradas, dados auxiliares e planejamento pessoal para triagem, com proveniência.
5. Remover apenas os campos `file` com caminhos locais do `references.bib`, preservando citekeys, autores, títulos, datas, DOI, URL e demais metadados. Corrigir scripts e documentação que dependam de caminhos absolutos; adicionar verificação reproduzível que rejeite caminhos locais de máquina.
6. Excluir `Annotated-Bibliography.Rproj` conforme solicitado e mover `.Rhistory` para triagem após remover/revisar referências locais; não manter histórico de comandos com dados da máquina no repositório publicado.
7. Adotar `here::i_am()`/`here::here()` nos scripts R, registrar instalação da dependência e usá-la nas referências a arquivos do repositório. Atualizar o workflow de CI e corrigir o parâmetro reservado `Args` do renderizador, que fazia renderizações direcionadas executarem o site inteiro.
8. Atualizar `AGENTS.md`, READMEs bilíngues, `.gitignore`, scripts de auditoria, `_quarto.yml`, `NEWS.md` e `TODO.md` para a estrutura resultante. Preservar `CLAUDE.md` exatamente como `@AGENTS.md` e não editar o bloco de governança comum copiado do Hub.
9. Executar busca final de caminhos absolutos, auditorias de tags/conteúdo e render direcionado pelo renderizador seguro; registrar resultado, datas preservadas, aliases e limitações. A CI executará o render integral após o push. Concluir plano e issue após essa validação.

## Execução e evidências locais

- O diretório foi movido para `repo-governance/`. A estrutura antiga do acervo resultou em 8 fichamentos em `posts/`, 10 QMDs em triagem e suporte adicional preservado em triagem; a saída HTML e o `.Rhistory` permanecem locais e ignorados.
- Os oito fichamentos migrados preservam `date` e `date-modified` exatamente como no Git anterior; `last-updated` também foi comparado onde existia. Cada fiche tem o alias antigo no front matter. Como esses oito arquivos são drafts excluídos do render, redirects só serão produzidos quando forem aprovados para publicação.
- Foram removidos 1.837 campos BibTeX `file` com caminhos para anexos locais. DOI, URL, citekeys e outros campos bibliográficos foram preservados. O `.Rproj` solicitado foi removido.
- `Rscript code/audit_tags.R`: 137 QMDs, 63 tags em uso, zero tags não canônicas e zero IDs registrados sem uso.
- `Rscript tools/audit_content.R`: 155 QMDs, 11 candidatos por metadados/título, nenhum corpo idêntico; um comentário de triagem sem front matter foi preservado intencionalmente.
- `Rscript tools/check_paths.R` passou na revisão local; a verificação final depois do staging está registrada antes do commit.
- O renderizador seguro direcionado concluiu 3/3 itens (ficha selecionada, índice e catálogo) e preservou os 150 HTMLs locais. Uma renderização integral local chegou a 126/126 entradas, mas foi encerrada antes do retorno final por levar quase uma hora; a validação integral será feita pela CI após o push.
- A run `Publish Quarto Site #63` ([36355014822](https://github.com/mancano-tales/annotated-bibliography/actions/runs/36355014822)) falhou na instalação de `here`: `install.packages()` tentou gravar em `/usr/local/lib/R/site-library`, sem permissão. As etapas de verificação de caminhos e renderização foram ignoradas. O workflow foi ajustado para usar a biblioteca gravável `$HOME/R/library` por meio de `R_LIBS_USER`; aguardar uma nova run para validar o restante.

## Critérios de conclusão

- A governança vive em `repo-governance/` e nenhuma referência operacional aponta para `0-governance/`.
- Nenhum caminho absoluto de máquina permanece em arquivo rastreado; os campos locais de anexos BibTeX foram removidos sem perda dos dados bibliográficos.
- QMDs migrados mantêm `date` e `last-updated`; URLs antigas permanecem em `aliases`, e o redirect é verificado quando o fiche é incluído no site.
- Duplicatas removidas têm comparação registrada; itens ambíguos estão preservados e listados em `repo-governance/triage/`.
- `here` está documentado e scripts R constroem caminhos locais via `here::here()`; a verificação de caminhos absolutos pode ser repetida.
- O `.Rproj` foi removido e os itens excluídos do escopo permaneceram fora do staging.
- Auditorias e o render seguro direcionado terminam com sucesso; o workflow de CI conclui o render integral; `NEWS.md` e o índice do plano estão no commit de governança.
