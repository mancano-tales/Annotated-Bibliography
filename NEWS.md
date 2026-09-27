# NEWS — Decisões de Design e Evolução Metodológica (Annotated-Bibliography)

## 2026-09-27 — Plano de revisão metodológica e editorial do site

O autor aprovou a revisão automatizada do corpus e do site: inventariar e comparar fontes, preservar datas originais, remover apenas duplicatas comprovadas, reorganizar títulos e navegação, documentar a metodologia de fechamento analítico, controlar tags sistematicamente, renomear o repositório e atualizar os metadados públicos. O plano registra as exclusões e os critérios de validação; acompanhamento na issue #7 e no plano do hub, issue #33.

**Metadados de Execução**:
- **Data**: 2026-09-27
- **Agente**: Codex / GPT-6 / Codex desktop (CobaltCanyon)
- **Mensagem do Commit**: "docs(plan): auditoria metodologica do corpus refs #7"
- **Arquivos afetados**: `0-governance/plan/README.md`, `0-governance/plan/2026-09-27_Plano_Revisao_Metodologica_Site_e_Corpus.md`, `TODO.md`, `NEWS.md`

## 2026-09-27 — Remove arquivos fora do escopo confirmado

Os três arquivos excluídos do escopo confirmado foram retirados do índice do Git sem apagar as cópias locais: preferência de VS Code, saída Beamer em `.tex` e exportação de conversa. A exportação também permanece fora do render do site, conforme a lista explícita em `_quarto.yml`.

**Metadados de Execução**:
- **Data**: 2026-09-27
- **Agente**: Codex / GPT-6 / Codex desktop
- **Mensagem do Commit**: "chore: remove out-of-scope files refs mancano-tales/mancano-repo-hub#27"
- **Arquivos afetados**: `NEWS.md`, `.vscode/settings.json`, `0-meta/llm-reviews/2026-08-09_1609_update-quarto-tts-reader-v230_conversa-antigravity.md`, `posts/DeKadt-GrzymalaBusse2025-Slides.tex`

## 2026-09-27 — Governança comum do ecossistema (v2026-09-26d)

Aplicado o bloco de governança comum mantido no hub (`mancano-tales/mancano-repo-hub`, `tools/governanca-comum/`): planos com issue (`tools/plano_issue.py`), base do `NEWS.md` derivada do git (`tools/news_db.py`), aprovação só no chat e no plano, mensagens de agentes como pedido, cabeçalho de agente, branch/PR opcionais, `NEWS.md` junto com a mudança, **datas sem hora** e **exportar conversa só quando o autor pedir**. O bloco fica entre marcadores no `AGENTS.md`; o que é específico deste repositório foi preservado. Os READMEs também passam a listar a pasta `tools/` adicionada ao repositório.

**Metadados de Execução**:
- **Data**: 2026-09-27
- **Agente**: Codex / GPT-6 / Codex desktop, via `tools/sync_governanca.py` do hub
- **Mensagem do Commit**: "docs(governance): governanca comum v2026-09-26d"
- **Arquivos afetados**: AGENTS.md, NEWS.md, README.md, README.pt-br.md, tools/plano_issue.py, tools/news_db.py, .claude/settings.json

> Entrada mais recente no topo.
>
> **Convenção de data (decisão do autor, 2026-09-26): novas entradas usam somente `YYYY-MM-DD`, sem hora; os horários exatos são os do git. Entradas históricas com hora permanecem como estão.**

## 2026-09-27 — Restringe o render do site a conteúdo publicável

O CI tentava compilar as apresentações Beamer em `posts/` sem ter uma distribuição LaTeX e falhava. O render do site agora usa uma lista explícita (`index.qmd` e fontes `.qmd` de `posts/`), exclui os dois decks e não renderiza documentos internos em Markdown, como exports de conversa. O renderizador incremental também ignora os decks por padrão; a opção manual `-Posts` continua disponível para compilar um deck em um ambiente com LaTeX.

**Metadados de Execução**:
- **Data**: 2026-09-27
- **Agente**: Codex / GPT-6 / Codex desktop
- **Mensagem do Commit**: "fix(build): restringe render do site a conteúdo publicável"
- **Arquivos afetados**: `_quarto.yml`, `code/render-posts.ps1`, `AGENTS.md`, `README.md`, `README.pt-br.md`, `NEWS.md`

## 2026-09-27 — READMEs e instruções de agentes alinhados ao estado atual

Atualizados os READMEs em inglês e português com a estrutura atual do repositório, a contagem baseada na categoria Quarto, os caminhos de `code/` e `prompts/`, a versão mais recente do prompt e o comando de renderização seguro. Registrada a divergência entre o destino `gh-pages` do workflow e a fonte legada do Pages, que ainda requer uma mudança pelo proprietário. Corrigidas em `AGENTS.md` as regras de exportação de conversa e a orientação sobre `CLAUDE.md`. Corrigida uma lista Beamer malformada em `DeKadt-GrzymalaBusse2025-Slides-Curto.qmd`. A renderização dos decks foi tentada pelo script seguro, mas não avançou neste ambiente; os PDFs permanecem não verificados.

**Metadados de Execução**:
- **Data**: 2026-09-27
- **Agente**: Codex / GPT-6 / Codex desktop
- **Mensagem do Commit**: "docs: alinha READMEs e AGENTS; corrige slide Beamer"
- **Arquivos afetados**: `README.md`, `README.pt-br.md`, `AGENTS.md`, `NEWS.md`, `posts/DeKadt-GrzymalaBusse2025-Slides-Curto.qmd`

## 2026-08-09 17:20 — Atualização da extensão `quarto-tts-reader` para a versão 2.3.0 e re-renderização direcionada de `DeKadt-GrzymalaBusse2025`

Atualização da extensão Quarto de leitura em voz alta `quarto-tts-reader` de `v1.0.0` para `v2.3.0` (trazida do repositório `mancano-tales/quarto-tts-reader`). A nova versão expande o código do leitor JS (23 KB -> 52 KB) e CSS (3.5 KB -> 14 KB), introduzindo suporte a navegação por teclado, parsing robusto via `TreeWalker` que preserva elementos KaTeX/MathJax, footnotes Tippy.js e citação bibliográfica, além de suporte a opt-out nativo no filtro Lua.

Realizada a auditoria adversarial por 4 subagentes especializados (Quarto Lua, Build Pipeline, Governança Agent Covenant e Frontend Assets), confirmando o versionamento `2.3.0` em `_extension.yml` para criação isolada da biblioteca `docs/site_libs/quarto-contrib/tts-reader-2.3.0/` e prevenção de envenenamento de cache do navegador. Executada a re-renderização direcionada do fichamento `DeKadt-GrzymalaBusse2025.qmd`.

**Metadados de Execução**:
- **Data/Hora**: 2026-08-09 17:20 (Horário de Brasília)
- **Agente**: Antigravity / Gemini 3.6 Flash (High) / Antigravity IDE
- **Mensagem do Commit**: "feat(tts): atualiza extensão quarto-tts-reader para v2.3.0 e renderiza DeKadt-GrzymalaBusse2025"
- **Arquivos afetados**: `_extensions/mancano-tales/tts-reader/`, `NEWS.md`

## 2026-07-31 14:35 — `docs/` sai do git: o repositório mantinha à mão uma segunda cópia do site que o CI já constrói

Auditoria do ecossistema `MancanoSync` encontrou **170 entradas de `git status`** neste repositório — a maior concentração de toda a árvore (27 repos, 358 entradas). Nenhuma era trabalho autoral: 133 arquivos não rastreados e 37 modificados, todos HTML de render.

**A causa raiz é uma migração feita pela metade.** O workflow `publish.yml` existe desde 2026-05-04 (`5171c2d`) e roda com sucesso a cada push, renderizando o site do zero e publicando 239 arquivos no branch `gh-pages`. Mas a fonte do GitHub Pages **nunca foi trocada**: a API responde `"build_type": "legacy", "source": {"branch": "main", "path": "/docs"}`. O site no ar é servido de `main:/docs`, e o `gh-pages` que o CI constrói há três meses **não é lido por ninguém**.

O resultado é uma redundância literal: **duas cópias completas do site**, uma mantida à mão e commitada (237 arquivos em `docs/`), outra gerada pelo CI e ignorada — consumindo de 7 a 9,5 minutos de Actions por push.

Duas causas secundárias completavam as 170 entradas:

1. **Render de documento avulso escapa do `output-dir`.** Os 105 `.html` soltos em `posts/` vêm do botão "Render" sobre um `.qmd` isolado: fora do modo projeto o Quarto ignora `output-dir: docs` e escreve ao lado do fonte. O `.gitignore` já descrevia exatamente esse fenômeno — mas só para o `index.qmd` da raiz, e a regra nunca fora generalizada.
2. **O render não é determinístico.** `sitemap.xml` reordena as entradas entre execuções (396 linhas de diff que são as mesmas URLs trocando de lugar) e `search.json` muda 8.122 linhas pelo mesmo motivo. **Esta é a causa que escondeu as outras duas**: um diretório cujo diff tem milhares de linhas de ruído não é revisável, e o que não se revisa é onde a redundância sobrevive despercebida.

Sinal de risco correlato: o estado local acusava 21.461 deleções contra 4.639 inserções em `docs/` — um render **parcial**, que teria mutilado a cópia rastreada se commitado.

**O que muda**: `docs/` deixa de ser rastreado e entra no `.gitignore`, junto com os renders avulsos. O `output-dir` **continua sendo `docs/`** — renomear para `_site` exigiria reescrever dez pontos de `code/render-posts.ps1` sem ganho funcional; o problema nunca foi o nome do diretório, foi o versionamento dele.

**Ajuste obrigatório no `render-posts.ps1`**: a checagem de integridade do passo 4 usava `git status --porcelain -- docs`, que só funcionava porque `docs/` era rastreado. Com o diretório fora do git ela passaria a reportar "nenhum arquivo perdido" **sempre** — uma salvaguarda quebrada em silêncio, pior que salvaguarda nenhuma. Substituída por contagem de arquivos no disco antes e depois do render, que não depende do git.

**Bloqueio: a ordem das operações importa e o primeiro passo é do autor.** Como o Pages ainda serve de `main:/docs`, despublicar `docs/` **derruba o site no ar**. A sequência é: (1) o autor troca a fonte do Pages para GitHub Actions em Settings → Pages — ação em serviço externo, que só ele pode fazer; (2) confirma-se que o site segue no ar; (3) só então este trabalho é mergeado. O PR foi aberto **como rascunho** para que o bloqueio seja físico e não apenas verbal.

**Metadados de Execução**:
- **Data/Hora**: 2026-07-31 14:35 (Horário de Brasília)
- **Agente**: Claude Opus 5 / claude-opus-5 / Claude Code (VS Code)
- **Mensagem do Commit**: "chore(build): despublica docs/ do git e generaliza o gitignore de render"
- **Arquivos afetados**: `.gitignore`, `CLAUDE.md`, `NEWS.md`, `code/render-posts.ps1`, `docs/` (237 arquivos despublicados, preservados no disco)

## 2026-07-26 11:04 (2) — Re-renderização em lote dos 135 fichamentos e injeção do player TTS em `docs/`

Executada a re-renderização em lote de todos os 135 posts em `posts/` com a extensão `quarto-tts-reader` ativada. Injetadas as dependências de script (`tts-reader.js` e `tts-reader.css`) em todos os arquivos HTML em `docs/posts/` e disponibilizado o player interativo de áudio no site estático. Removida também a opção `self-contained: true` de `posts/Lupu-Pontusson2023Chp-1.qmd` para destravar a compilação paralela.

**Metadados de Execução**:
- **Data/Hora**: 2026-07-26 11:04 (Horário Local)
- **Agente**: Antigravity / Gemini 3.6 Flash (High) / Antigravity IDE
- **Mensagem do Commit**: "build(docs): re-renderiza 135 fichamentos com injeção do player quarto-tts-reader"
- **Arquivos afetados**: `docs/`, `posts/Lupu-Pontusson2023Chp-1.qmd`, `NEWS.md`, `TODO.md`

## 2026-07-26 07:31 (1) — Incorporação das regras de governança de IA e ativação da extensão `quarto-tts-reader`

Instalação da extensão Quarto de leitura em voz alta `mancano-tales/quarto-tts-reader` (v1.0.0) e ativação global em `_quarto.yml` (`filters: [mancano-tales/tts-reader]` e `tts-reader-enabled: true`). Todos os posts de fichamento acadêmico em `posts/` passam a contar com o player de TTS com marcação sincronizada palavra a palavra, controle de velocidade e suporte a vozes neurais do Edge.

Adicionalmente, o repositório foi alinhado ao padrão de governança de IA do ecossistema `MancanoSync`:
- Criação do hard link `AGENTS.md` -> `CLAUDE.md`.
- Adição das regras estritas do **Agent Covenant** no topo do `CLAUDE.md`.
- Criação deste arquivo de histórico intelectual (`NEWS.md`) e da fila de tarefas (`TODO.md`).

**Metadados de Execução**:
- **Data/Hora**: 2026-07-26 07:31 (Horário Local)
- **Agente**: Antigravity / Gemini 3.6 Flash (High) / Antigravity IDE
- **Mensagem do Commit**: "feat: ativa extensao quarto-tts-reader e incorpora padroes de governanca de IA"
- **Arquivos afetados**: `_quarto.yml`, `CLAUDE.md`, `AGENTS.md`, `NEWS.md`, `TODO.md`, `_extensions/mancano-tales/tts-reader/`
