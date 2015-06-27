# http://shiny.rstudio.com/gallery/word-cloud.html

library(shiny)
library(wordcloud)
library(tm)

shinyServer(function(input, output, session) {

  datainput <- reactive({
    if (nchar(input$text) > 0){
      words <- Corpus(VectorSource(input$text))
    }
    else if (is.null(input$file)) {
      return(NULL)
    }
    else {
      a <- input$file$datapath
      a <- substr(a, 1, nchar(a) - 1)
      words <- Corpus(DirSource(a))
    }

    words <- tm_map(words, stripWhitespace)
    words <- tm_map(words, content_transformer(tolower))
    words <- tm_map(words, removeWords, stopwords("SMART"))
    words <- tm_map(words, removeNumbers)
    words <- tm_map(words, removePunctuation)
    })

  finalinput <- reactive({
    if (input$checkbox3) datainput <- tm_map(datainput(), stemDocument)
    })

wordcloud_rep <- repeatable(wordcloud)

  make_cloud <- reactive({
    wordcloud_rep(finalinput(),
      scale=c(5, 0.5),
      min.freq=input$slider1,
      max.words=input$slider2,
      random.order=input$checkbox4,
      rot.per=input$slider3,
      use.r.layout=FALSE,
      colors=brewer.pal(8, "Dark2"))
    })

  # output$wordcloud_img <- downloadHandler(
  #   filename = "wordcloud.png",
  #   content = function(cloud) {
  #     png(cloud)
  #     make_cloud()
  #     dev.off()
  #   })

  output$wordcloud <- renderPlot({
    make_cloud()
   })
})


# character_case <- function(words, case) {
#   switch(case,
#     "Lower Case" = tm_map(words, content_transformer(tolower)),
#     "Upper Case" = tm_map(words, content_transformer(toupper)))
# }
