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
      output$jobs_md <- renderText(renderMarkdown(file = jobs_md_file()))
      # removeUI(selector = "div:has(> #resume_pdf")
      # insertUI("#place4cv", "afterBegin",
      #          ui = tagList(
      #            p(),
      #            downloadLink("resume_pdf", "Download resume in PDF")
      #            )
      # )
      # removeUI(selector = "div:has(> #cvurl)")
      # randomurl <- reactiveVal({
      #   n <- 1
      #   a <- do.call(
      #     paste0, 
      #     replicate(
      #       3, 
      #       sample(c(letters, LETTERS), n, TRUE), FALSE))
      #   paste0(a, sprintf("%04d", sample(9999, n, TRUE)), sample(c(letters, LETTERS), n, TRUE))
      # })
      # 
      # insertUI("#place4cv", "afterEnd",
      #          ui =  tagList(
      #            p(),
      #            a(href = paste0("https://tailor.jobs/", randomurl()))
      # ))
    }
  )
  
  # Download PDF ####
  
  output$resume_pdf <- downloadHandler(
    filename = paste0("resume_", lubridate::today(), ".pdf")
    , content = function(file) {
      file.copy(
        system.file("cv.pdf", package = "resumetailor"),
        file)
    }
  )
  
})
