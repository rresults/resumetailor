library(shiny)
library(resumetailor)
library(markdown)


shinyUI(fluidPage(
  
  titlePanel("Resume Tailor"),
  
  tabsetPanel(
    tabPanel(
      "Keep your job history",
      
      h3("Position achievements"),
      actionButton("add_ach", "Add achievement"),
      achievementInput("ach1")),
    tabPanel("Vacancy to fit",
             div(id = "tags"),
             actionButton("generate_cv_btn", "Generate resume!")
             ),
    tabPanel("Get your tailored resume",
             p(),
             downloadLink("resume.pdf", "Download PDF"),
             p(),
             div(id = "resume"),
             # includeMarkdown(system.file("source/head.md",
             #                             package = "resumetailor")),
             htmlOutput("jobs_md") #,
             # includeMarkdown(system.file("source/tail.md",
             #                             package = "resumetailor"))
             )
  )))