#!/usr/bin/env Rscript

here::i_am("tools/check_paths.R")
repo_root <- here::here()

tracked <- system2("git", "ls-files", stdout = TRUE)
if (!is.null(attr(tracked, "status")) && attr(tracked, "status") != 0L) {
  stop("Não foi possível listar os arquivos rastreados pelo Git.")
}

text_extensions <- c(
  "md", "qmd", "r", "rmd", "bib", "yml", "yaml", "json", "toml", "txt",
  "ps1", "py", "sh", "css", "scss", "js", "mjs", "lua", "xml", "svg",
  "html", "htm", "csv", "gitignore", "gitattributes", "properties", "lock"
)
files <- tracked[file.exists(file.path(repo_root, tracked))]
files <- files[tolower(tools::file_ext(files)) %in% text_extensions | basename(files) %in% c(".gitignore", ".gitattributes")]

# The shared governance block contains a redacted format example, not a machine path.
redacted_example <- "[[:alpha:]]:[/\\\\]Users[/\\\\][.][.][.]"
drive_path <- "(^|[^[:alnum:]])[[:alpha:]]:[/\\\\]"
backslash <- intToUtf8(92L)
unc_path <- paste0(
  strrep(backslash, 4L), "[[:alnum:]_.-]+",
  strrep(backslash, 2L), "[[:alnum:]_.-]+"
)
posix_path <- "(^|[[:space:]\"'`=<(])/(Users|home|mnt|tmp|Volumes)/"

find_paths <- function(path) {
  lines <- tryCatch(readLines(file.path(repo_root, path), encoding = "UTF-8", warn = FALSE),
                    error = function(e) character())
  if (!length(lines)) return(data.frame(file = character(), line = integer(), text = character()))

  hits <- which(vapply(lines, function(line) {
    candidate <- gsub(redacted_example, "", line, ignore.case = TRUE, perl = TRUE)
    grepl(drive_path, candidate, ignore.case = TRUE, perl = TRUE) ||
      grepl(unc_path, candidate, ignore.case = TRUE, perl = TRUE) ||
      grepl(posix_path, candidate, ignore.case = TRUE, perl = TRUE)
  }, logical(1)))

  if (!length(hits)) return(data.frame(file = character(), line = integer(), text = character()))
  data.frame(file = path, line = hits, text = substr(trimws(lines[hits]), 1L, 240L), stringsAsFactors = FALSE)
}

violations <- do.call(rbind, lapply(files, find_paths))
if (is.null(violations) || !nrow(violations)) {
  cat("OK: nenhum caminho local absoluto nos arquivos de texto rastreados.\n")
} else {
  print(utils::head(violations, 25L), row.names = FALSE)
  stop(sprintf("Encontrados %d caminho(s) local(is) absoluto(s).", nrow(violations)))
}
