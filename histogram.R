library(shiny)

ui <- fluidPage(
    sliderInput(inputId = 'num', 
                label = 'Velg n i fordelinga', 
                min = 0, max = 1000,
                value = 25),
    textInput(inputId = 'title',
              label = 'skriv ein tittel',
              value = "Histogram"),
    actionButton(inputId = 'normButton',
                 label = 'Normalfordeling'),
    actionButton(inputId = 'uniButton',
                 label = "uniformfordeling"),
    plotOutput("hist")
) #slutt fluidpage

server <- function(input, output){
  rv <- reactiveValues(data = rnorm(100))
  
  observeEvent(input$normButton, {rv$data <- rnorm(input$num)})
  observeEvent(input$uniButton, {rv$data <- runif(input$num)})
  
  output$hist <- renderPlot({
    hist(rv$data,
         main = isolate(input$title))
  })#slutt server
}
shinyApp(ui = ui, server = server)
  