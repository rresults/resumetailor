library(yaml)
library(shiny)

shinyServer(function(input, output, session) {
  
  # jobs <- yaml::yaml.load_file("source/jobs.yaml")
  
  
  
  
  observeEvent(input$add_ach, {
    
    ach_count <- input$add_ach
    insertUI(
      selector = "h3",
      where = "afterEnd",
      ui = achievementInput(paste0("ach", ach_count))
    )
    
    
  })
})
