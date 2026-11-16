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
      selectInput("colour", label = "What is yout favourite colour?", 
                  c("red", "blue", "green", "yellow", "purple", "orange", "magenta", "brown"))
    ),
    mainPanel(
      textOutput("greeting"),
      textOutput("favourite_colour"),
      uiOutput("coloured_text")
    )
  )
)

server <- function(input, output, session) {
  output$title <- renderText({req(input$name) 
    paste0(input$name, "'s")
    })
  
  greeting <- reactive({
    req(input$name)
    paste0("Hello ", input$name, " you are ", input$age, " years old")
    })
  
  output$greeting <- renderText(greeting())
  
  output$favourite_colour <- renderText(
    paste("You have selected", input$colour, "as your favourite Colour"))
  output$coloured_text <- renderUI({ 
    span(style = paste0("color:", input$colour, ";", greeting())) 
    })
}

shinyApp(ui, server)
