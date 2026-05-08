
# fix_spaces.R
# Remove espaços únicos indevidos no início de linhas em arquivos .qmd
# gerados por LLMs que inserem um espaço antes de headings, parágrafos, etc.
#
# Uso: preencha `nome_do_qmd` com o nome do arquivo (só o nome, sem o caminho)
# e execute o script. O arquivo é sobrescrito in-place.

# ── 1. Arquivo-alvo ──────────────────────────────────────────────────────────

nome_do_qmd <- ""   # ex: "Fernandes2005"

path <- paste0(
  "C:/Users/Mancano/Documents/MancanoSync/Annotated-Bibliography/posts/",
  nome_do_qmd,
  ".qmd"
)

# ── 2. Leitura ───────────────────────────────────────────────────────────────

lines <- readLines(path, encoding = "UTF-8")

# ── 3. Flags de contexto ─────────────────────────────────────────────────────

# Controlam se a linha atual está dentro de uma seção protegida:
# - YAML frontmatter (entre os dois primeiros "---")
# - Bloco de código (entre ``` ... ```)
# Nessas seções, espaços no início podem ser intencionais e NÃO são removidos.
in_yaml <- FALSE
in_code <- FALSE

# Guarda os índices das linhas que foram modificadas (para o relatório final)
changed <- integer(0)

# ── 4. Limpeza ───────────────────────────────────────────────────────────────

clean <- vapply(seq_along(lines), function(i) {
  line <- lines[i]

  # Detecta abertura do YAML frontmatter (primeiro "---" do arquivo)
  if (i == 1 && line == "---") { in_yaml <<- TRUE; return(line) }

  # Detecta fechamento do YAML frontmatter
  if (in_yaml && line == "---") { in_yaml <<- FALSE; return(line) }

  # Dentro do YAML: preserva linha sem alteração
  if (in_yaml) return(line)

  # Alterna flag ao entrar/sair de bloco de código (``` ou ```lang)
  if (grepl("^```", line)) { in_code <<- !in_code; return(line) }

  # Dentro de bloco de código: preserva linha sem alteração
  if (in_code) return(line)

  # Fora de seções protegidas: remove exatamente um espaço inicial.
  # A condição `!startsWith(line, "  ")` garante que recuos intencionais
  # com 2+ espaços (ex: YAML aninhado, listas indentadas) não sejam tocados.
  if (startsWith(line, " ") && !startsWith(line, "  ")) {
    changed <<- c(changed, i)
    return(sub("^ ", "", line))
  }

  line
}, character(1))

# ── 5. Relatório e salvamento ────────────────────────────────────────────────

cat("Linhas alteradas:", length(changed), "\n")
writeLines(clean, path, useBytes = FALSE)
cat("Arquivo salvo:", path, "\n")
