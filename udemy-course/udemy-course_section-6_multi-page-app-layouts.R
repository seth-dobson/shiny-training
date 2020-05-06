data("airquality")

library(shiny)
library(tidyverse)
library(DT)
library(cowplot)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("month", label = "Select month", choices = unique(airquality$Month), multiple = F),
      selectInput("y", label = "Select column to plot:", choices = c("Wind", "Temp"), multiple = F)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Data", dataTableOutput("dt1")),
        tabPanel("Plot", plotOutput("plot1"))
      )
    )
  )
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