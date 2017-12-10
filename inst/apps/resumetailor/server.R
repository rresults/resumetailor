library(yaml)
library(shiny)
library(purrr)
library(resumetailor)
library(markdown)
library(lubridate)
library(readr)

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
  
  # Position tags ####
  
  client_tags <- map(jobs, position_tags) %>% 
    map(names) %>% unlist() %>% unname() %>% unique() %>% sort()
  
  insertUI("#tags",
           "afterBegin",
           ui = checkboxGroupInput(
             "tags_box", "Choose topics of the vacancy",
             client_tags)
           )
  
  output$position_tags <- renderText(input$tags_box)
  
  observeEvent(
    input$generate_cv_btn, {
      jobs_md_file <- reactiveVal(generate_jobs_md(jobs, input$tags_box))
      output$jobs_md_file <- renderText(jobs_md_file())
      output$jobs_md <- renderText(renderMarkdown(file = jobs_md_file()))
    }
  )
  
  # Download PDF ####
  
  output$resume.pdf <- downloadHandler(
    filename = paste0("resume_", lubridate::today(), ".pdf")
    , content = function(file) {
      file.copy(
        system.file("cv.pdf", package = "resumetailor"),
        file)
    }
  )
  
})
