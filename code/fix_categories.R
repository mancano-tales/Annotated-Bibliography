library(tidyverse)

posts_dir <- "C:/Users/Mancano/Documents/MancanoSync/Annotated-Bibliography/posts"

# ── Canonical mapping ─────────────────────────────────────────────────────────
# Keys   : raw/legacy category names (Portuguese or non-standard English)
# Values : canonical English names from CATEGORIES.md
# IMPORTANT: mappings are applied as exact whole-item matches only.
# Substring replacement is intentionally avoided to prevent canonical values
# from being re-substituted in subsequent passes.

mapping <- c(
  # Discipline — Political Economy
  "Economia Política"                    = "Political Economy",
  "Economia Política Comparada"          = "Political Economy",
  "Comparative Political Economy"        = "Political Economy",
  "Economia Política Histórica"          = "Historical Political Economy",

  # Discipline — Comparative Politics
  "Política Comparada"                   = "Comparative Politics",
  "Ciência Política"                     = "Comparative Politics",
  "Ciência Política Comparada"           = "Comparative Politics",
  "Comparative"                          = "Comparative Politics",
  "Politicologia"                        = "Comparative Politics",

  # Discipline — Development Economics
  "Desenvolvimento"                      = "Development Economics",
  "Economic Development"                 = "Development Economics",
  "Instituições e Desenvolvimento"       = "Development Economics",

  # Discipline — Economics of Education
  "Economia da Educação"                 = "Economics of Education",

  # Discipline — Institutional Economics
  "Nova Economia Institucional"          = "Institutional Economics",

  # Discipline — Political Sociology
  "Sociologia Política"                  = "Political Sociology",

  # Discipline — Sociology of Education
  "Sociologia da Educação"               = "Sociology of Education",

  # Inequality
  "Desigualdade"                         = "Inequality",
  "Desigualdade Econômica"               = "Inequality",
  "Desigualdade de Renda"                = "Inequality",
  "Desigualdade de Riqueza"              = "Inequality",
  "Desigualdade e Instituições"          = "Inequality",
  "Desigualdade Regional"                = "Regional Inequality",
  "Mobilidade Social"                    = "Social Mobility",
  "Estratificação Social"                = "Social Stratification",
  "Redistribuição"                       = "Redistribution",
  "Estratégias Distributivas"            = "Redistribution",
  "Padrões de Vida"                      = "Living Standards",

  # Education — Policy
  "Politics of Education"                = "Education Policy/Politics",
  "Education Policy"                     = "Education Policy/Politics",
  "Política Educacional"                 = "Education Policy/Politics",
  "Política educacional"                 = "Education Policy/Politics",
  "Política da Educação"                 = "Education Policy/Politics",
  "Política Comparada da Educação"       = "Education Policy/Politics",
  "Political Economy of Education"       = "Education Policy/Politics",
  "Economia Política da Educação"        = "Education Policy/Politics",
  "Brazilian Education"                  = "Education Policy/Politics",

  # Education — Higher
  "Educação Superior"                    = "Higher Education",
  "Educação superior"                    = "Higher Education",
  "Brazilian Higher Education"           = "Higher Education",
  "Tertiary Education"                   = "Higher Education",

  # Education — Inequality
  "Educação e Desigualdade"              = "Educational Inequality",

  # Education — History
  "História da Educação"                 = "History of Education",

  # Education — Private
  "Privatization"                        = "Private Education",
  "Privatização"                         = "Private Education",
  "Mass Private Sector"                  = "Private Education",
  "Public vs. Private"                   = "Private Education",
  "Setor público e privado"              = "Private Education",

  # Education — Other
  "Student Loans"                        = "Student Finance",
  "Sindicalismo Docente"                 = "Teacher Unionism",

  # Welfare State / Social Policy
  "Welfare State"                        = "Welfare State/Social Policy",
  "Social Policy"                        = "Welfare State/Social Policy",
  "Estado de Bem-Estar Social"           = "Welfare State/Social Policy",
  "U.S. Welfare State"                   = "Welfare State/Social Policy",
  "Democracia e Bem-Estar"               = "Welfare State/Social Policy",
  "Política Social"                      = "Welfare State/Social Policy",
  "Políticas Sociais"                    = "Welfare State/Social Policy",
  "Política Social Comparada"            = "Welfare State/Social Policy",
  "Social Investment"                    = "Social Investment",
  "Investimento Social"                  = "Social Investment",
  "Pandemia COVID-19"                    = "COVID-19 Pandemic",

  # Institutions
  "Instituições Políticas"               = "Institutions",
  "Mudança Institucional"                = "Institutional Change",
  "Reforma Institucional"                = "Institutional Change",
  "Institucionalismo Histórico"          = "Historical Institutionalism",
  "Historical Institutional Analysis"   = "Historical Institutionalism",
  "História institucional"               = "Historical Institutionalism",
  "Dependência de Trajetória"            = "Path Dependence",
  "Variedades de Capitalismo"            = "Varieties of Capitalism",
  "Liberalização"                        = "Liberalization",
  "Interesses Criados"                   = "Vested Interests",

  # Politics & Governance
  "Democracia"                           = "Democracy",
  "Análise de Governos Partidários"      = "Party Politics",
  "Teoria de Clivagens"                  = "Party Politics",
  "Presidencialismo de Coalizão"         = "Coalitional Presidentialism",
  "Análise Coalicional"                  = "Coalition Analysis",
  "Análise Legislativa"                  = "Legislative Analysis",
  "Relações Executivo-Legislativo"       = "Legislative Analysis",
  "Autoritarismo"                        = "Authoritarianism",
  "Influência Política"                  = "Political Influence",
  "Relação Estado-Sociedade"             = "State-Society Relations",
  "Política Brasileira"                  = "Brazil",
  "Descentralização"                     = "Decentralization",
  "Federalismo"                          = "Federalism",

  # Economic History & Growth
  "Economia Histórica"                   = "Economic History",
  "História Econômica"                   = "Economic History",
  "História Econômica da América Latina" = "Economic History",
  "Brasil Imperial"                      = "Imperial Brazil",
  "Long-Run Growth"                      = "Economic Growth",
  "Desenvolvimento de Longo Prazo"       = "Economic Growth",
  "Crescimento Econômico"                = "Economic Growth",
  "Modelos de Crescimento"               = "Economic Growth",
  "Economias Periféricas"                = "Peripheral Economies",
  "Restrição do Balanço de Pagamentos"   = "Peripheral Economies",
  "Capitalismo de Plataforma"            = "Platform Capitalism",
  "Modelos de Negócio"                   = "Platform Capitalism",
  "Inteligência Artificial"              = "Artificial Intelligence",
  "Tecnonacionalismo"                    = "Artificial Intelligence",  # no canonical; closest match
  "Extrativismo energético"              = "Energy Extraction",
  "Acaparamiento de tierras"             = "Land Conflicts",
  "Conflitos territoriais"               = "Land Conflicts",
  "Agricultura Familiar"                 = "Rural Development",
  "Desenvolvimento Rural"                = "Rural Development",
  "Mercados Financeiros"                 = "Financial Markets",

  # Geography
  "Brasil"                               = "Brazil",
  "América Latina"                       = "Latin America",
  "América Latina Comparada"             = "Latin America",
  "Latin American Studies"               = "Latin America",
  "Latin American Politics"              = "Latin America",
  "Europa Central e Oriental"            = "Central and Eastern Europe",
  "Pós-comunismo"                        = "Post-communism",

  # Methodology
  "Metodologia Quantitativa"             = "Quantitative Methods",
  "Métodos Quantitativos"                = "Quantitative Methods",
  "Metodologia Qualitativa"              = "Qualitative Methods",
  "Metodologia de Estudos de Caso"       = "Case Study",
  "Inferência Causal"                    = "Causal Inference",
  "Bayesianismo"                         = "Bayesianism",
  "Geografia"                            = "Geospatial Analysis",

  # Public Policy
  "Políticas Públicas"                   = "Public Policy",
  "Política Pública"                     = "Public Policy",
  "Política de Infraestrutura"           = "Infrastructure Policy",

  # Other
  "Referencial"                          = "Reference"
)

# ── Helpers ───────────────────────────────────────────────────────────────────

# Parse a categories: [...] or multi-line list block into a character vector.
parse_categories <- function(yaml_block) {
  cat_line <- which(startsWith(trimws(yaml_block), "categories:"))
  if (length(cat_line) == 0) return(NULL)

  inline <- str_match(yaml_block[cat_line], "^categories:\\s*\\[(.+)\\]")[, 2]
  if (!is.na(inline)) {
    items <- str_split(inline, ",")[[1]] |> str_trim()
    return(list(type = "inline", line = cat_line, items = items))
  }

  # Multi-line list: collect subsequent "  - item" lines
  rest_idx <- (cat_line + 1):length(yaml_block)
  rest     <- yaml_block[rest_idx]
  is_item  <- str_detect(rest, "^\\s+-\\s+")
  # Stop at first non-item non-blank line
  run_end  <- which(!is_item & str_trim(rest) != "")
  if (length(run_end) > 0) is_item[run_end[1]:length(is_item)] <- FALSE
  items <- str_trim(str_remove(rest[is_item], "^\\s+-\\s+"))
  list(type = "multiline", line = cat_line, item_lines = rest_idx[is_item], items = items)
}

# Apply the mapping to a vector of category strings (exact whole-item match only).
remap_items <- function(items, mapping) {
  mapped <- mapping[items]           # NA where no match; result is a named vector
  unname(ifelse(!is.na(mapped), mapped, items))
}

# Rewrite the categories block inside yaml_block using the corrected items.
write_categories <- function(yaml_block, parsed, new_items) {
  new_items <- unique(new_items)   # deduplicate after remapping

  if (parsed$type == "inline") {
    yaml_block[parsed$line] <- paste0(
      "categories: [", paste(new_items, collapse = ", "), "]"
    )
  } else {
    # Replace each existing item line; drop extras if dedup shortened the list
    n_orig <- length(parsed$item_lines)
    n_new  <- length(new_items)
    padded <- formatC("", width = nchar(yaml_block[parsed$item_lines[1]]) -
                        nchar(str_trim(yaml_block[parsed$item_lines[1]])))
    for (i in seq_len(min(n_orig, n_new))) {
      yaml_block[parsed$item_lines[i]] <- paste0("  - ", new_items[i])
    }
    if (n_new < n_orig) {
      # Remove surplus lines (set to NA, filter later)
      yaml_block[parsed$item_lines[(n_new + 1):n_orig]] <- NA_character_
    }
    yaml_block <- yaml_block[!is.na(yaml_block)]
  }
  yaml_block
}

# Main function: fix one .qmd file.
fix_file_categories <- function(filepath, mapping, dry_run = FALSE) {
  lines    <- readLines(filepath, warn = FALSE, encoding = "UTF-8")
  yaml_end <- which(lines == "---")
  if (length(yaml_end) < 2) return(FALSE)

  yaml_range <- seq_len(yaml_end[2])
  yaml_block <- lines[yaml_range]

  parsed <- parse_categories(yaml_block)
  if (is.null(parsed)) return(FALSE)

  new_items <- remap_items(parsed$items, mapping)

  if (identical(new_items, parsed$items)) return(FALSE)   # nothing changed

  yaml_block <- write_categories(yaml_block, parsed, new_items)
  lines <- c(yaml_block, lines[(yaml_end[2] + 1):length(lines)])

  if (!dry_run) writeLines(lines, filepath, useBytes = FALSE)
  return(TRUE)
}

# ── Run ───────────────────────────────────────────────────────────────────────
files   <- list.files(posts_dir, pattern = "\\.qmd$", full.names = TRUE)
results <- map_lgl(files, fix_file_categories, mapping = mapping, dry_run = FALSE)

cat(sprintf("Updated %d / %d files.\n", sum(results), length(files)))
