#' Input with achievement description
#' 
#' @export
#' @import shiny

achievementInput <- function(id, desc = "", topics = "", values = "") {
  
  ns <- NS(id)
  
  tagList(
    textAreaInput(ns("desc"), "Achievement", value = desc),
    textInput(ns("topics"), "Topic tags", value = topics),
    textInput(ns("values"), "Topic values", value = values)
  )
  
}