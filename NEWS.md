# NEWS — Decisões de Design e Evolução Metodológica (Annotated-Bibliography)

> Entrada mais recente no topo.
>
> **Convenção de timestamp (decisão do autor, 2026-07-12 HH:mm): data sozinha não é suficiente — todo timestamp neste projeto (cabeçalho de entrada, campo `**Data/Hora**` do bloco de Metadados de Execução) deve incluir hora e minuto, formato `YYYY-MM-DD HH:MM`, Horário de Brasília (UTC-3).**

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
