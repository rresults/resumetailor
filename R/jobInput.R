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
    textAreaInput(ns("desc"), "Achievement", value = desc),
    textInput(ns("topics"), "Topic tags", value = topics),
    textInput(ns("values"), "Topic values", value = values)
  )
    
}