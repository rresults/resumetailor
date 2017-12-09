library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Resume Tailor"),
  
  tabsetPanel(
    tabPanel("Keep your job history"),
    tabPanel("Topics of vacancy"),
    tabPanel("Get your tailored resume")
  )))