library(yaml)
library(shiny)
library(purrr)
library(resumetailor)
library(markdown)

shinyServer(function(input, output, session) {
  
  jobs <- yaml::read_yaml(system.file("source/jobs.yaml", 
                                      package = "resumetailor"))
  
  # Fill positions
  
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
    
  
  # Achievement input button #####
  
  observeEvent(input$add_ach, {
    
    ach_count <- input$add_ach
    insertUI(
      selector = "h3",
      where = "afterEnd",
      ui = achievementInput(paste0("ach", ach_count))
    )
  })
  
  client_tags <- map(jobs, position_tags) %>% 
    map(names) %>% unlist() %>% unname() %>% unique() %>% sort()
  
  insertUI("#tags",
           "afterBegin",
           ui = checkboxGroupInput(
             "tags_box", "Choose topics of the vacancy",
             client_tags)
           )
  
  
})
