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
        choices = c("bill_length_mm", "bill_depth_mm","flipper_length_mm","body_mass_g")
    ),
    mainPanel(
      plotOutput("plot"),
      )
    )
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    plot <- ggplot(selected(), aes(x = flipper_length_mm, y = body_mass_g)) +
      geom_point() +
      coord_cartesian(xlim = c(170, 235), ylim = c(2700, 6300)) +
      labs(
        title = paste("Body mass against flipper length:", input$species, "penguins"),
        x = "Flipper length (mm)",
        y = "Body mass (g)"
      )
    plot
  })
  
}

shinyApp(ui, server)