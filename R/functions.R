library(purrr)
library(lubridate)
library(stringr)
library(dplyr)

result_tags <- function(result) {
  result[[1]]
}

filter_tags <- function(result, tags){
  ids2keep <- names(result_tags(result)) %in% tags
  result[[1]] <- keep(result[[1]], ids2keep)
  result
}

result_has_tag <- function(result, tag) {
  any(tag %in% names(result_tags(result)))
}

filter_results <- function(results, tag) {
  keep(results, result_has_tag, tag = tag)
}

results_tags <- function(results) {
  flatten(map(results, result_tags))
}

position_tags <- function(position) {
  position %>% 
    pluck("results") %>% 
    results_tags
}

position_has_tag <- function(position, tag) {
  any(tag %in% names(position_tags(position)))
}

filter_positions <- function(positions, tags) {
  keep(positions, position_has_tag, tag = tags)
}

position_total_value <- function(position) {
  sum(flatten_dbl(position_tags(position)))
}

result_total_value <- function(result) {
  sum(flatten_dbl(result_tags(result)))
}

add_elem <- function(elem,
                     nbefore = 1L, 
                     nafter = 1L, 
                     symbefore = "",
                     symafter = "",
                     file = cv_file) {
  elem <- stringr::str_c(paste0(rep.int("\n", nbefore), collapse = ""), 
                         symbefore,
                         elem, 
                         symafter,
                         paste0(rep.int("\n", nafter), collapse = ""),
                         collapse = "")
  readr::write_file(elem, file, append = TRUE)
}

generate_pdf <- function() {
  system2(
    command = "/usr/bin/pandoc", 
    args = c("+RTS -K512m -RTS source/*.md --to latex --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash --output cv.pdf --template source/style/rstudio.tex --highlight-style tango --latex-engine pdflatex --variable graphics=yes --variable 'geometry:margin=1in'")
  )
}

