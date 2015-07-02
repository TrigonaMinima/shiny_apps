library(shiny)

# remove individual words

shinyUI(fluidPage(
  # Title of the app
  titlePanel("Wordcloud!"),

  sidebarLayout(
    sidebarPanel(

      strong("Settings:"),

      # Checkboxes for the wordcloud settings
      checkboxInput("checkbox3", label = "Document stemming", value = TRUE),
      checkboxInput("checkbox4", label = "Random Order", value = FALSE),
      checkboxInput("checkbox2", label = "Repeatable", value = TRUE),

      # Slider input for frequency change
      sliderInput("slider1", "Minimum Frequency:",
        min = 1, max = 50, value = 5),

      # Slider input for rotation change
      sliderInput("slider3", "Rotation:",
        min = 0.0, max = 1.0, value = 0.35),

      # Slider input for number of words change
      sliderInput("slider2", "Max words:",
        min = 10, max = 1000, value = 100),

      # Text box to input the text
      textInput("text", "Text input:"),

      # Text file uploader
      fileInput("file", "Text file", accept=c("text/plain", ".txt"))),

    mainPanel(
      # Image download button
      downloadButton("wordcloud_img", "Download Image"),
      # CSV download button
      downloadButton("freq_csv", "Download Freq CSV"),
      # Wordcloud image rendered
      imageOutput("wordcloud"))
  )
))
