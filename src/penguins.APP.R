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
        choices = c("Please select" = "", "Bill length" = "bill_length_mm", "bill depth" = "bill_depth_mm","flipper_length_mm","body_mass_g","year")),
      selectInput(
        "y_axis",
        "Choose a y axis:",
        choices = c("Please select" = "","Bill length" =  "bill_length_mm", "bill depth" =  "bill_depth_mm","flipper_length_mm","body_mass_g","year")),
      selectInput(
        "colour",
        "Choose a category:",
        choices = c("species","island","sex")),
      textInput("plot_title", label  = "Title of your graph:"),
      textInput("plot_x", label = "What is the x axis:"),
      textInput("plot_y", label = "What is the y axis:"),
      #selectInput("species", label = "Choose a species", choices = "Adelie", "Gentoo", "Chinstrap")
    ),
    mainPanel(
      plotOutput("plot"),
    )
  )
)

server <- function(input, output, session) {
  #chosen_penguins <- reactive({
   # penguins #|>
      #filter(
       # species == input$species
     # )
  #})
  
  output$plot <- renderPlot({
    plot <- ggplot(penguins, aes(x = penguins[[input$x_axis]], y = penguins[[input$y_axis]], colour = penguins[[input$colour]])) +
      geom_point() +
      coord_cartesian() +
      labs(
        title = paste(input$plot_title),
        x = input$plot_x,
        y = input$plot_y
      )
    plot
  })
  
}

shinyApp(ui, server)