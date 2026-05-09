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
# - YAML frontmatter (entre os dois primeiros "---"): espaços únicos indevidos
#   também são removidos aqui (ex: " title: ..." → "title: ..."), mas recuos
#   intencionais de 2+ espaços (ex: bloco format: aninhado) são preservados.
# - Bloco de código (entre ``` ... ```): preservado integralmente.
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

  # Alterna flag ao entrar/sair de bloco de código (``` ou ```lang)
  # Não se aplica dentro do YAML (onde ``` não abre bloco de código)
  if (!in_yaml && grepl("^```", line)) { in_code <<- !in_code; return(line) }

  # Dentro de bloco de código: preserva linha sem alteração
  if (in_code) return(line)

  # Remove exatamente um espaço inicial (vale tanto no YAML quanto no corpo).
  # A condição `!startsWith(line, "  ")` garante que recuos intencionais
  # com 2+ espaços (ex: bloco format: aninhado, listas indentadas) não sejam tocados.
  if (startsWith(line, " ") && !startsWith(line, "  ")) {
    changed <<- c(changed, i)
    return(sub("^ ", "", line))
  }

  line
}, character(1))

# ── 5. Substituição de *** por --- ───────────────────────────────────────────

# LLMs às vezes geram "***" como separador horizontal; o correto em Quarto é "---"
stars_idx <- which(clean == "***")
clean[stars_idx] <- "---"
cat("Separadores *** substituídos por ---:", length(stars_idx), "\n")

# ── 6. Correção da indentação do bloco format: ───────────────────────────────

# Garante que o bloco format: no YAML tenha exatamente esta estrutura:
#   format:
#     html:          ← 2 espaços
#       toc: true    ← 4 espaços
#       ...
#
# A correspondência é feita por trimws() para aceitar qualquer indentação errada.

format_canon <- c(
  "  html:",
  "    toc: true",
  "    number-sections: true",
  "    theme: cosmo",
  "    highlight-style: github",
  "    execute: false"
)
format_keys <- trimws(format_canon)

yaml_close <- which(clean == "---")[2]   # segundo "---" = fim do YAML

format_fixed <- 0L

if (!is.na(yaml_close)) {
  format_line <- which(clean[seq_len(yaml_close)] == "format:")
  if (length(format_line) == 1) {
    after_format <- seq(format_line + 1L, yaml_close - 1L)
    for (j in after_format) {
      key <- trimws(clean[j])
      idx <- match(key, format_keys)
      if (!is.na(idx) && clean[j] != format_canon[idx]) {
        clean[j] <- format_canon[idx]
        format_fixed <- format_fixed + 1L
      }
    }
  }
}

cat("Linhas do bloco format: corrigidas:", format_fixed, "\n")

# ── 7. Relatório e salvamento ────────────────────────────────────────────────

cat("Linhas com espaço removido:", length(changed), "\n")
writeLines(clean, path, useBytes = FALSE)
cat("Arquivo salvo:", path, "\n")
