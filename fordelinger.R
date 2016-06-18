library(shiny)

nav <- navbarPage(title = "Fordelinger",
                 tabPanel("Normal",
                          plotOutput("norm"),
                          actionButton("reNorm", "Nytt utvalg")
                          ),
                 tabPanel("Kji-kvadrat",
                          plotOutput("kji"),
                          actionButton("reKji", "Nytt utvalg")
                          )
                 )#navbar

server <- function(input, output){
  
  rv <- reactiveValues(
    norm = rnorm(500),
    kji = rchisq(500,10)
  )
  
  observeEvent(input$reNorm, {rv$norm <- rnorm(500)})
  observeEvent(input$reKji, {rv$kji <- rchisq(500, n = 10)})
  
  output$norm <- renderPlot({
    hist(rv$norm,
         breaks = 30,
         main = "500 tilfeldige valg fra standard normalfordeling")
  })#outputNorm
  output$kji <- renderPlot({
    hist(rv$kji,
         breaks = 100,
         main = "n = 500")
  })
  
}#server

shinyApp(ui = nav, server = server)




