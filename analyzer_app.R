library(shiny)
library(tuneR)
library(signal)
library(seewave)
library(phonTools)
library(ggplot2)




ui <- fluidPage(
  titlePanel("Audio Spectrogram"),          
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Choose an audio file in WAV format:")
    ),
    mainPanel(
      plotOutput("spectrogram"),
      #including a download function
      downloadButton('downloadImage', 'Download Spectrogram as image')
    )
  )
)

server <- function(input, output) {
  output$spectrogram <- renderPlot({
    if(!is.null(input$file)) {
      audio <- readWave(input$file$datapath)
      #spec(audio)
      #spectro(audio, f=36000, wl=1024, wn="hanning", ovlp=50, collevels=seq(-80,0,1), palette= spectro.colors, grid=FALSE)
      ggspectro(audio, ovlp = 50) + geom_tile(aes(fill = amplitude)) + stat_contour()
      #spectro(audio,f=22050,wl=512, wn="hanning",ovlp=85,zp=16,osc=TRUE, cont=TRUE,contlevels=seq(-30,0,20),colcont="red", lwd=1.5,lty=2, palette= spectro.colors, grid = FALSE)
        
    }
  })
  
  
  output$downloadImage <- downloadHandler(
    filename = function() {
      paste0("spectrogram_", Sys.Date(), ".png")
    },
    content = function(file) {
      if(!is.null(input$file)) {
        audio <- readWave(input$file$datapath)
        img <- ggspectro(audio, ovlp = 50) + geom_tile(aes(fill = amplitude)) + stat_contour()
        ggsave(file, img, dpi = 300, width = 8, height = 6, type = "cairo")
      }
    }
  )
  
  
}

shinyApp(ui = ui, server = server)