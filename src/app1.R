library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel(
    tagList(
      textOutput("title", inline = TRUE),
      "Shiny App"
    ),
    # Without this, the browser tab would show the HTML of the title above.
    windowTitle = "Shiny App"
  ),
  sidebarLayout(
    sidebarPanel(
      textInput("name", label = "Enter your Name"),
      numericInput("age", label = "Enter your age", value = 18),
      selectInput("colour", label = "What is yout favourite colour?", c("Red", "Blue", "Green", "Yellow", "Purple", "Orange", "Pink", "Brown"))
    ),
    mainPanel(
      textOutput("greeting"),
      textOutput("age_r"),
      textOutput("favourite_colour")
    )
  )
)

server <- function(input, output, session) {
  output$title <- renderText(paste0(input$name, "'s"))
  output$greeting <- renderText(paste("Hello" , input$name))
  output$age_r <- renderText(paste("Your age is", input$age))
  output$favourite_colour <- renderText(paste("You have selected", input$colour, "as your favourite"))
}

shinyApp(ui, server)
