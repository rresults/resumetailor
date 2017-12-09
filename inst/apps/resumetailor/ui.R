library(shiny)
library(resumetailor)

shinyUI(fluidPage(
  
  titlePanel("Resume Tailor"),
  
  tabsetPanel(
    tabPanel(
      "Keep your job history",
      
      h3("Position achievements"),
      actionButton("add_ach", "Add achievement"),
      achievementInput("ach1")),
    tabPanel("Vacancy to fit",
             div(id = "tags")),
    tabPanel("Get your tailored resume",
             div(id = "resume"))
  )))