data("airquality")

library(shiny)
library(tidyverse)
library(DT)
library(cowplot)

choices_month <- unique(airquality$Month)
choices_y <- colnames(airquality)

ui <- fluidPage(
  selectInput("month", label = "Select month", choices = choices_month, multiple = F),
  selectInput("y", label = "Select column to plot vs day:", choices = choices_y, multiple = F),
  dataTableOutput("dt1"),
  plotOutput("plot1")
)

server <- function(input, output) {
  filtered_month <- reactive({
    filtered_month <- airquality %>% filter(Month %in% (input$month))

    return(filtered_month)
  })


  output$dt1 <- renderDT({
    datatable(filtered_month())
  })

  output$plot1 <- renderPlot({
    ggplot(filtered_month(), aes(x = Day, y = !!sym(input$y))) +
      geom_point() +
      geom_line() +
      theme_minimal_grid()
  })
}

shinyApp(ui, server)
