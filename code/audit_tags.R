#!/usr/bin/env Rscript

here::i_am("code/audit_tags.R")
repo_root <- here::here()
registry_path <- here::here("TAGS.md")
post_dir <- here::here("posts")
output_dir <- here::here("repo-governance", "audit")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

registry_lines <- readLines(registry_path, encoding = "UTF-8", warn = FALSE)
table_lines <- grep("^\\| `[^`]+` \\|", registry_lines, value = TRUE)
ids <- sub("^\\| `([^`]+)` \\|.*$", "\\1", table_lines)
alias_text <- sub("^\\| `[^`]+` \\|[^|]*\\|([^|]*)\\|$", "\\1", table_lines)
aliases <- trimws(alias_text)
names(aliases) <- ids
alias_ids <- unlist(lapply(aliases, function(x) {
  if (!nzchar(x)) return(character())
  trimws(strsplit(x, ",", fixed = TRUE)[[1]])
}), use.names = FALSE)
registered <- unique(ids)

parse_tags <- function(lines, path) {
  if (!length(lines) || trimws(lines[[1]]) != "---") return(list(tags = character(), error = "front matter ausente"))
  close <- which(trimws(lines[-1]) == "---")
  if (!length(close)) return(list(tags = character(), error = "front matter sem fechamento"))
  end <- close[[1]] + 1L
  front <- lines[2:(end - 1L)]
  idx <- grep("^tags:", front)
  if (!length(idx)) return(list(tags = character(), error = ""))
  i <- idx[[1]]
  value <- trimws(sub("^tags:\\s*", "", front[[i]]))
  if (startsWith(value, "[") && endsWith(value, "]")) {
    inner <- substr(value, 2L, nchar(value) - 1L)
    tags <- if (nzchar(trimws(inner))) trimws(strsplit(inner, ",", fixed = TRUE)[[1]]) else character()
  } else if (!nzchar(value) || tolower(value) == "null") {
    j <- i + 1L
    tags <- character()
    while (j <= length(front) && grepl("^\\s+-\\s+", front[[j]])) {
      tags <- c(tags, sub("^\\s+-\\s+", "", front[[j]]))
      j <- j + 1L
    }
  } else {
    tags <- value
  }
  tags <- gsub("^[\"']|[\"']$", "", trimws(tags))
  list(tags = tags, error = "")
}

files <- sort(list.files(post_dir, pattern = "\\.qmd$", recursive = TRUE, full.names = TRUE))
rows <- list()
frontmatter_errors <- character()
for (path in files) {
  rel <- substring(normalizePath(path, winslash = "/", mustWork = TRUE), nchar(repo_root) + 2L)
  parsed <- parse_tags(readLines(path, encoding = "UTF-8", warn = FALSE), rel)
  if (nzchar(parsed$error)) frontmatter_errors <- c(frontmatter_errors, paste(rel, parsed$error, sep = ": "))
  tags <- parsed$tags
  if (!length(tags)) next
  duplicates <- duplicated(tolower(tags)) | duplicated(tolower(tags), fromLast = TRUE)
  malformed <- !grepl("^[a-z0-9]+(-[a-z0-9]+)*$", tags)
  alias_use <- tags %in% alias_ids
  unregistered <- !(tags %in% registered)
  issue <- ifelse(malformed, "malformed", "")
  issue[alias_use] <- ifelse(nzchar(issue[alias_use]), paste(issue[alias_use], "retired alias", sep = "; "), "retired alias")
  issue[unregistered & !alias_use] <- ifelse(nzchar(issue[unregistered & !alias_use]), paste(issue[unregistered & !alias_use], "unregistered", sep = "; "), "unregistered")
  issue[duplicates] <- ifelse(nzchar(issue[duplicates]), paste(issue[duplicates], "duplicate in file", sep = "; "), "duplicate in file")
  rows[[length(rows) + 1L]] <- data.frame(tag = tags, path = rel, issue = issue, stringsAsFactors = FALSE)
}

usage <- if (length(rows)) do.call(rbind, rows) else data.frame(tag = character(), path = character(), issue = character())
write.csv(usage, file.path(output_dir, "tag-usage.csv"), row.names = FALSE, fileEncoding = "UTF-8", na = "")
counts <- if (nrow(usage)) table(usage$tag) else integer()
unused <- setdiff(registered, names(counts))
errors <- usage[nzchar(usage$issue), , drop = FALSE]

cat("QMDs verificados:", length(files), "\n")
cat("Tags em uso:", length(counts), "\n")
cat("Arquivos sem tags:", sum(vapply(files, function(p) !length(parse_tags(readLines(p, encoding = "UTF-8", warn = FALSE), p)$tags), logical(1))), "(opcional; sem erro)\n")
cat("Tags não canônicas:", nrow(errors), "\n")
cat("IDs registrados sem uso:", length(unused), if (length(unused)) paste0(" (", paste(unused, collapse = ", "), ")") else "", "\n")
if (length(frontmatter_errors)) cat("Front matter para revisar:\n", paste(frontmatter_errors, collapse = "\n"), "\n")
cat("Relatório: repo-governance/audit/tag-usage.csv\n")
if (nrow(errors)) {
  print(errors, row.names = FALSE)
  quit(status = 1L)
}
