library(shiny)
install.packages("tuneR")
library(tuneR)
remotes::install_github("Athospd/wavesurfer")
library(wavesurfer)
install.packages("signal")
library(signal)

ui <- fluidPage(

  titlePanel("Audio Analyzer"),
  
  sidebarLayout(
    sidebarPanel(
      
      # Input: Select a file ----
      fileInput("file1", "Choose your Audio",
                multiple = TRUE,
                accept = c(".wav")),
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      # Output: Data file ----
      wavesurferOutput("my_ws"),
      #tableOutput("contents")
      
    )
  )
)

server <- function(input, output) {
  
  
 
  output$my_ws <- renderWavesurfer({
    req(input$file1$datapath)
    {
        #wavesurfer(audio = "https://wavesurfer-js.org/example/media/demo.wav") %>%
        #display <- readWave(fileInput())
        wavesurfer(audio = file1) %>%
          ws_set_wave_color('#5511aa') %>%
          ws_spectrogram() %>%
          ws_cursor()
    }
  })#output Wavesurfer

    
  #})
  
}

# Create Shiny app ----
shinyApp(ui, server)
