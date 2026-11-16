library(shiny)
library(tidyverse)

# Read the data once, when the app starts (not inside the server).
penguins <- read_csv("data/penguins.csv")

ui <- fluidPage(
  titlePanel("Penguin explorer"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "x_axis",
        "Choose an x axis:",
        choices = c("bill_length_mm", "bill_depth_mm","flipper_length_mm","body_mass_g","year")),
      selectInput(
        "y_axis",
        "Choose a y axis:",
        choices = c("bill_length_mm", "bill_depth_mm","flipper_length_mm","body_mass_g","year")),
      selectInput(
        "colour",
        "Choose a category:",
        choices = c("species","island","sex")),
      textInput("plot_title", label  = "Title of your graph:"),
      textInput("plot_x", label = "What is the x axis:"),
      textInput("plot_y", label = "What is the y axis:")
    ),
    mainPanel(
      plotOutput("plot"),
    )
  )
)

server <- function(input, output, session) {
  chosen_penguins <- reactive({
    penguins
  })
  
  output$plot <- renderPlot(
    plot <- ggplot(chosen_penguins(), aes(x = input$x_axis, y = input$y_axis, colour = input$colour)) +
      geom_point() +
      labs(
        title = paste(input$plot_title),
        x = input$plot_x,
        y = input$plot_y
      )
  )
  
}

shinyApp(ui, server)