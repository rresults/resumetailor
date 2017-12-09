library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Resume Tailor"),
  
  tabsetPanel(
    tabPanel(
      "Keep your job history",
      
      h3("Position achievements"),
      actionButton("add_ach", "Add achievement"),
      achievementInput("ach1")),
    tabPanel("Vacancy to fit"),
    tabPanel("Get your tailored resume")
  )))