library(yaml)
library(shiny)
library(purrr)

shinyServer(function(input, output, session) {
  
  jobs <- yaml::read_yaml(system.file("source/jobs.yaml", 
                                      package = "resumetailor"))
  
  jobs <- jobs[1:2]
  
  jobs_positions <- names(jobs)
  jobs_ids <- paste0("job", seq_along(jobs))
  
  pmap(list(
    job_desc = jobs_positions,
    job = jobs,
    id = jobs_ids), 
    function(job_desc, job, id) {
      insertUI(
        selector = "h3",
        where = "afterEnd",
        ui = prefilledJobInput(job_desc, job, id)
      )
      
      
    }
  )
    
  
  observeEvent(input$add_ach, {
    
    ach_count <- input$add_ach
    insertUI(
      selector = "h3",
      where = "afterEnd",
      ui = achievementInput(paste0("ach", ach_count))
    )
    
    
  })
})
