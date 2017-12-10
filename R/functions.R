#' Retrieve tags of a result
#' @export

result_tags <- function(result) {
  result[[1]]
}

#' Keep relevant tags in a result
#' @export
#' @import purrr

filter_tags <- function(result, tags){
  ids2keep <- names(result_tags(result)) %in% tags
  result[[1]] <- keep(result[[1]], ids2keep)
  result
}

#' Does result has specific tag
#' @export

result_has_tag <- function(result, tag) {
  any(tag %in% names(result_tags(result)))
}

#' Keep results with relevant tags
#' @export
#' @import purrr

filter_results <- function(results, tag) {
  keep(results, result_has_tag, tag = tag)
}

#' Extract tags from results
#' @export
#' @import purrr

results_tags <- function(results) {
  flatten(map(results, result_tags))
}

#' Extract all tags from a postion
#' @export
#' @import purrr

position_tags <- function(position) {
  position %>% 
    pluck("results") %>% 
    results_tags
}

#' Does position has specific tag
#' @export

position_has_tag <- function(position, tag) {
  any(tag %in% names(position_tags(position)))
}

#' Filter positions by tags
#' @export
#' @import purrr

filter_positions <- function(positions, tags) {
  keep(positions, position_has_tag, tag = tags)
}

#' Calcucate total value of the position
#' @export
#' @import purrr 

position_total_value <- function(position) {
  sum(flatten_dbl(position_tags(position)))
}

#' Calcucate total value of the result
#' @export
#' @import purrr 
result_total_value <- function(result) {
  sum(flatten_dbl(result_tags(result)))
}

#' Add alement to markdown file
#' @export
#' @import readr

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

#' Generate PDF resume
#' 
generate_pdf <- function() {
  system2(
    command = "/usr/bin/pandoc", 
    args = c("+RTS -K512m -RTS source/*.md --to latex --from markdown+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash --output cv.pdf --template source/style/rstudio.tex --highlight-style tango --latex-engine pdflatex --variable graphics=yes --variable 'geometry:margin=1in'")
  )
}

