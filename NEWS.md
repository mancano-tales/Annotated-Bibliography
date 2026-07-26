# NEWS — Decisões de Design e Evolução Metodológica (Annotated-Bibliography)

> Entrada mais recente no topo.
>
> **Convenção de timestamp (decisão do autor, 2026-07-12 HH:mm): data sozinha não é suficiente — todo timestamp neste projeto (cabeçalho de entrada, campo `**Data/Hora**` do bloco de Metadados de Execução) deve incluir hora e minuto, formato `YYYY-MM-DD HH:MM`, Horário de Brasília (UTC-3).**

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
