#' Input with position description
#' 
#' @export
#' @import shiny

jobInput <- function(
  id,
  position_name = "",
  org = "", 
  startdate = NULL,
  enddate = NULL) {
  
  ns <- NS(id)
  
  tagList(
    textInput(ns("position"), "Position name", value = position_name),
    textInput(ns("org"), "Organization", value = org),
    dateRangeInput(ns("period"), 
                   "Period of work", 
                   start = startdate,
                   end = enddate)
      )
  
}