library(shiny)

ui <- pageWithSidebar(
    headerPanel("Mental Health"),
    sidebarPanel(
        sliderInput("obs", "States",
                    min = 0, max = 1000,  value = 500)
    ),
    mainPanel(
        # Use imageOutput to place the image on the page
        imageOutput("myImage")
    )
)

server <- function(input, output, session) {
    output$myImage <- renderImage({
        # A temp file to save the output.
        # This file will be removed later by renderImage
        outfile <- tempfile(fileext = '.png')
        
        # Generate the PNG
        png(outfile, width = 400, height = 300)
        hist(rnorm(input$obs), main = "Generated in renderImage()")
        dev.off()
        
        # Return a list containing the filename
        list(src = "plot.png",
             contentType = 'image/png',
             width = 1000,
             height = 1000,
             alt = "This is alternate text")
    }, deleteFile = FALSE)
}

shinyApp(ui, server)

