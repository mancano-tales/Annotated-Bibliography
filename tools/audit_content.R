#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = FALSE)
script_arg <- sub("^--file=", "", args[grepl("^--file=", args)])
script_dir <- dirname(normalizePath(script_arg[[1]], winslash = "/", mustWork = TRUE))
repo_root <- normalizePath(file.path(script_dir, ".."), winslash = "/", mustWork = TRUE)
output_dir <- file.path(repo_root, "0-governance", "audit")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

rel_path <- function(path) {
  substring(normalizePath(path, winslash = "/", mustWork = TRUE), nchar(repo_root) + 2L)
}

read_qmd <- function(path) {
  lines <- readLines(path, encoding = "UTF-8", warn = FALSE)
  if (length(lines) && startsWith(lines[[1]], "\ufeff")) lines[[1]] <- substring(lines[[1]], 2L)
  if (!length(lines) || trimws(lines[[1]]) != "---") {
    return(list(metadata = list(), body = paste(lines, collapse = "\n"), error = "front matter ausente"))
  }

  closers <- which(trimws(lines[-1]) == "---")
  if (!length(closers)) {
    return(list(metadata = list(), body = paste(lines, collapse = "\n"), error = "front matter sem fechamento"))
  }
  end <- closers[[1]] + 1L

  fm_lines <- lines[2:(end - 1L)]
  metadata <- list()
  scalar_fields <- c("title", "subtitle", "date", "last-updated", "doi", "draft")
  for (field in scalar_fields) {
    field_line <- grep(paste0("^", field, ":\\s*"), fm_lines, value = TRUE)
    if (length(field_line)) {
      value <- sub(paste0("^", field, ":\\s*"), "", field_line[[1]])
      value <- trimws(value)
      if (nchar(value) >= 2L && substr(value, 1L, 1L) %in% c("\"", "'") && substr(value, nchar(value), nchar(value)) == substr(value, 1L, 1L)) {
        value <- substr(value, 2L, nchar(value) - 1L)
      }
      metadata[[field]] <- value
    }
  }
  for (field in c("categories", "tags")) {
    field_idx <- grep(paste0("^", field, ":"), fm_lines)
    values <- character()
    if (length(field_idx)) {
      i <- field_idx[[1]]
      value <- trimws(sub(paste0("^", field, ":\\s*"), "", fm_lines[[i]]))
      if (startsWith(value, "[") && endsWith(value, "]")) {
        inner <- substr(value, 2L, nchar(value) - 1L)
        values <- if (nzchar(trimws(inner))) trimws(strsplit(inner, ",", fixed = TRUE)[[1]]) else character()
      } else if (!nzchar(value) || tolower(value) == "null") {
        j <- i + 1L
        while (j <= length(fm_lines) && grepl("^\\s+-\\s+", fm_lines[[j]])) {
          values <- c(values, sub("^\\s+-\\s+", "", fm_lines[[j]]))
          j <- j + 1L
        }
      } else values <- value
      values <- vapply(values, function(item) {
        item <- trimws(item)
        if (nchar(item) >= 2L && substr(item, 1L, 1L) %in% c("\"", "'") && substr(item, nchar(item), nchar(item)) == substr(item, 1L, 1L)) {
          item <- substr(item, 2L, nchar(item) - 1L)
        }
        item
      }, character(1))
      metadata[[field]] <- values
    }
  }
  body <- if (end < length(lines)) paste(lines[(end + 1L):length(lines)], collapse = "\n") else ""
  list(metadata = metadata, body = body, error = "")
}

scalar <- function(x) {
  if (is.null(x) || !length(x)) return("")
  if (inherits(x, "Date")) return(format(x, "%Y-%m-%d"))
  paste(as.character(unlist(x, recursive = TRUE, use.names = FALSE)), collapse = "; ")
}

frontmatter_list <- function(x) {
  if (is.null(x) || !length(x)) return(character())
  trimws(as.character(unlist(x, recursive = TRUE, use.names = FALSE)))
}

normalise_key <- function(x) {
  x <- iconv(tolower(x), from = "", to = "ASCII//TRANSLIT")
  x <- gsub("^fichamento:\\s*", "", x)
  gsub("[^a-z0-9]+", "", x)
}

hash_body <- function(body) {
  normalized <- gsub("[[:space:]]+", " ", trimws(body))
  tmp <- tempfile("qmd-body-")
  on.exit(unlink(tmp), add = TRUE)
  writeLines(normalized, tmp, useBytes = TRUE)
  unname(tools::md5sum(tmp))
}

extract_doi <- function(text, metadata) {
  candidate <- scalar(metadata$doi)
  if (!nzchar(candidate)) {
    m <- regexpr("10\\.[0-9]{4,9}/[-._;()/:A-Z0-9]+", text, ignore.case = TRUE, perl = TRUE)
    if (m[[1]] > 0) candidate <- regmatches(text, m)
  }
  gsub("[.,;:]+$", "", tolower(candidate))
}

extract_citekey <- function(text) {
  m <- regexec("@[[:alpha:]][[:alnum:]_-]*\\{([^,}]+)", text, perl = TRUE)
  hit <- regmatches(text, m)[[1]]
  if (length(hit) >= 2L) trimws(hit[[2]]) else ""
}

source_files <- c(
  list.files(file.path(repo_root, "posts"), pattern = "\\.qmd$", recursive = TRUE, full.names = TRUE),
  list.files(file.path(repo_root, "0-governance", "archive", "variants"), pattern = "\\.qmd$", recursive = TRUE, full.names = TRUE),
  list.files(file.path(repo_root, "Old_Website_Posts"), pattern = "\\.qmd$", recursive = TRUE, full.names = TRUE)
)
source_files <- sort(unique(source_files))

rows <- lapply(source_files, function(path) {
  parsed <- read_qmd(path)
  fm <- parsed$metadata
  body <- parsed$body
  rel <- rel_path(path)
  type <- if (grepl("^Old_Website_Posts/", rel)) "legacy" else if (grepl("^0-governance/archive/variants/", rel)) "archived-variant" else if (grepl("^posts/notes/", rel)) "concept-note" else if (grepl("Slides.*\\.qmd$", rel, ignore.case = TRUE)) "slides" else "bibliography"
  title <- scalar(fm$title)
  list(
    path = rel,
    type = type,
    title = title,
    subtitle = scalar(fm$subtitle),
    date = scalar(fm$date),
    last_updated = scalar(fm$`last-updated`),
    draft = tolower(scalar(fm$draft)) == "true",
    categories = paste(frontmatter_list(fm$categories), collapse = "; "),
    tags = paste(frontmatter_list(fm$tags), collapse = "; "),
    tag_count = length(frontmatter_list(fm$tags)),
    doi = extract_doi(paste(title, body), fm),
    citekey = extract_citekey(body),
    title_key = normalise_key(title),
    body_hash = hash_body(body),
    frontmatter_error = parsed$error
  )
})

inventory <- as.data.frame(do.call(rbind, lapply(rows, as.data.frame, stringsAsFactors = FALSE)), stringsAsFactors = FALSE)
inventory$duplicate_candidate_count <- 0L
inventory$duplicate_basis <- ""

if (nrow(inventory) > 1L) {
  pairs <- combn(seq_len(nrow(inventory)), 2L)
  candidates <- list()
  for (k in seq_len(ncol(pairs))) {
    i <- pairs[1L, k]
    j <- pairs[2L, k]
    reasons <- character()
    if (nzchar(inventory$body_hash[[i]]) && identical(inventory$body_hash[[i]], inventory$body_hash[[j]])) reasons <- c(reasons, "corpo idêntico após normalizar espaços")
    if (nzchar(inventory$doi[[i]]) && identical(inventory$doi[[i]], inventory$doi[[j]])) reasons <- c(reasons, "mesmo DOI")
    if (nzchar(inventory$citekey[[i]]) && identical(tolower(inventory$citekey[[i]]), tolower(inventory$citekey[[j]]))) reasons <- c(reasons, "mesmo citekey")
    if (nzchar(inventory$title_key[[i]]) && identical(inventory$title_key[[i]], inventory$title_key[[j]])) reasons <- c(reasons, "título normalizado idêntico")
    if (length(reasons)) {
      candidates[[length(candidates) + 1L]] <- data.frame(
        file_a = inventory$path[[i]], title_a = inventory$title[[i]], date_a = inventory$date[[i]],
        file_b = inventory$path[[j]], title_b = inventory$title[[j]], date_b = inventory$date[[j]],
        match_basis = paste(reasons, collapse = "; "),
        exact_body = "corpo idêntico após normalizar espaços" %in% reasons,
        stringsAsFactors = FALSE
      )
      inventory$duplicate_candidate_count[c(i, j)] <- inventory$duplicate_candidate_count[c(i, j)] + 1L
      for (idx in c(i, j)) {
        old <- inventory$duplicate_basis[[idx]]
        inventory$duplicate_basis[[idx]] <- paste(unique(c(if (nzchar(old)) strsplit(old, "; ", fixed = TRUE)[[1]] else character(), reasons)), collapse = "; ")
      }
    }
  }
  candidates <- if (length(candidates)) do.call(rbind, candidates) else data.frame(
    file_a = character(), title_a = character(), date_a = character(),
    file_b = character(), title_b = character(), date_b = character(),
    match_basis = character(), exact_body = logical(), stringsAsFactors = FALSE
  )
} else {
  candidates <- data.frame(
    file_a = character(), title_a = character(), date_a = character(),
    file_b = character(), title_b = character(), date_b = character(),
    match_basis = character(), exact_body = logical(), stringsAsFactors = FALSE
  )
}

tags <- do.call(rbind, lapply(seq_len(nrow(inventory)), function(i) {
  vals <- strsplit(inventory$tags[[i]], "; ", fixed = TRUE)[[1]]
  vals <- vals[nzchar(vals)]
  if (!length(vals)) return(NULL)
  data.frame(tag = vals, path = inventory$path[[i]], stringsAsFactors = FALSE)
}))
if (is.null(tags)) tags <- data.frame(tag = character(), path = character(), stringsAsFactors = FALSE)
tag_report <- if (nrow(tags)) {
  by_tag <- split(tags$path, tags$tag)
  data.frame(
    tag = names(by_tag),
    normalized_slug = gsub("^[-]+|[-]+$", "", gsub("[^a-z0-9]+", "-", iconv(tolower(names(by_tag)), from = "", to = "ASCII//TRANSLIT"))),
    uses = vapply(by_tag, function(x) length(unique(x)), integer(1)),
    paths = vapply(by_tag, function(x) paste(sort(unique(x)), collapse = "; "), character(1)),
    stringsAsFactors = FALSE
  )
} else data.frame(tag = character(), normalized_slug = character(), uses = integer(), paths = character(), stringsAsFactors = FALSE)

write.csv(inventory, file.path(output_dir, "content-inventory.csv"), row.names = FALSE, fileEncoding = "UTF-8", na = "")
write.csv(candidates, file.path(output_dir, "duplicate-candidates.csv"), row.names = FALSE, fileEncoding = "UTF-8", na = "")
write.csv(tag_report[order(tag_report$uses, tag_report$tag, decreasing = TRUE), ], file.path(output_dir, "tag-inventory.csv"), row.names = FALSE, fileEncoding = "UTF-8", na = "")

cat("QMDs inventariados:", nrow(inventory), "\n")
cat("Candidatos a duplicata:", nrow(candidates), "(corpo idêntico:", sum(candidates$exact_body), ")\n")
cat("Tags distintas:", nrow(tag_report), "\n")
cat("Arquivos sem tags:", sum(inventory$tag_count == 0L), "\n")
cat("Erros de front matter:", sum(nzchar(inventory$frontmatter_error)), "\n")
cat("Relatórios: 0-governance/audit/content-inventory.csv, duplicate-candidates.csv, tag-inventory.csv\n")
