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

  # wordcloud_rep <- repeatable(wordcloud)

  asdas <- reactive({
    if (input$checkbox2) wordcloud_rep <- repeatable(wordcloud)
    else wordcloud_rep <- wordcloud
  })

  make_cloud <- reactive ({
    wordcloud_rep <- asdas()

    png("wordcloud.png", width=10, height=8, units="in", res=350)
    w <- wordcloud_rep(finalinput(),
      scale=c(5, 0.5),
      min.freq=input$slider1,
      max.words=input$slider2,
      random.order=input$checkbox4,
      rot.per=input$slider3,
      use.r.layout=FALSE,
      colors=brewer.pal(8, "Dark2"))
    dev.off()

    filename <- "wordcloud.png"
    })

  output$wordcloud_img <- downloadHandler(
    filename = "wordcloud.png",
    content = function(cloud) {
      file.copy(make_cloud(), cloud)
    })

  output$wordcloud <- renderImage({
    print(make_cloud())
    list(src=make_cloud(), alt="Image being generated!", height=600)
  }, deleteFile = FALSE)
})


# character_case <- function(words, case) {
#   switch(case,
#     "Lower Case" = tm_map(words, content_transformer(tolower)),
#     "Upper Case" = tm_map(words, content_transformer(toupper)))
# }
