#' Creates prefilled job input
#' @import shiny
#' @export

prefilledJobInput <- function(job_desc = NULL, job = NULL, id = NULL) {
  
  jobInput(
    id = id
    , position_name = job_desc
    , org = job$org
    , startdate = job$period[1]
    , enddate = job$period[2]
  )
  
  
}
