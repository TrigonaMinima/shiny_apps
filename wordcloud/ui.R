library(shiny)

# remove individual words

shinyUI(fluidPage(
  titlePanel("Shiny Wordcloud!"),

  sidebarLayout(
    sidebarPanel(

      strong("Settings:"),
      checkboxInput("checkbox3", label = "Document stemming", value = TRUE),
      checkboxInput("checkbox4", label = "Random Order", value = FALSE),

      sliderInput("slider1", "Minimum Frequency:",
        min = 1, max = 50, value = 5),

      sliderInput("slider3", "Rotation:",
        min = 0.0, max = 1.0, value = 0.35),

      sliderInput("slider2", "Max words:",
        min = 10, max = 1000, value = 100),

      textInput("text", "Text input:"),

      fileInput("file", "Text file", accept=c("text/plain", ".txt"))),

    mainPanel(
      downloadButton("wordcloud_img", "Download Image"),

      plotOutput("wordcloud", height=600, width=800))
  )
))