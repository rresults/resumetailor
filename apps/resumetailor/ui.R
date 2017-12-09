library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Resume Tailor"),
  
  tabsetPanel(
    tabPanel(
      "Keep your job history",
      radioButtons(
        inputId = "mode_switch"
        , label = "Working mode"
        , choices = c("Demo mode" = "demo",
                      "Real user" = "production")
        , inline = FALSE),
      h3("Position achievements"),
      actionButton("add_ach", "Add achievement"),
      achievementInput("ach1")),
    tabPanel("Vacancy to fit"),
    tabPanel("Get your tailored resume")
  )))