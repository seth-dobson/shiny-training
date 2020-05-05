library(shiny)

ui <- fluidPage(
  textInput("name", label = "Enter your name:", placeholder = "John Smith"),
  textInput("age", label = "Enter your age:", placeholder = 35),
  dateInput("birthday", label = "Select your birthday:"),
  selectInput("gender", label = "Select your gender:", choices = c("Female", "Male")),
  sliderInput("favorite_number", label = "Choose favorite number between 0 and 100", value = 50 , min = 0, max = 100)
)


server <- function(input, output) {

}

shinyApp(ui, server)