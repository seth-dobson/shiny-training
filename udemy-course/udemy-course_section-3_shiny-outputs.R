data("mtcars")

library(shiny)
library(DT)
library(tidyverse)
library(cowplot)
library(viridis)

ui <- fluidPage(
  dataTableOutput("dt1"),
  plotOutput("plot1")
)

server <- function(input, output){
  output$dt1 <- renderDT(datatable(mtcars))
  
  output$plot1 <- renderPlot(
    ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) +
      geom_point(size = 4) +
      theme_minimal_grid() +
      scale_color_viridis(discrete = T, "cyl")
  )
}

shinyApp(ui, server)