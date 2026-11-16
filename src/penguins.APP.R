library(shiny)
library(tidyverse)

ui <- fluidPage(
  titlePanel(
    tagList(
      textOutput("title", inline = TRUE),
      "Penguins Visualiser"
    ),
    # Without this, the browser tab would show the HTML of the title above.
    windowTitle = "Penguins Visualiser"
  )
  fluidRow(
    column(
      2,
      numericInput()
    )
  )
)