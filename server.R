# Shiny server
library(shiny)
library(lubridate)
library(ggplot2)

shinyServer <- function (input, output) {
  dataAPI <-read.csv("API_Banting.csv")
  
  dataSelect <- reactive({
    data <- dataAPI[(year(dataAPI$Date)==input$year & (month(dataAPI$Date)>=input$month[1] & month(dataAPI$Date)<=input$month[2])), ]
  })
  
  output$html1 <- renderUI({
    dataSel <- dataSelect()
    str1 <- paste("Selected Year: ", input$year)
    str2 <- paste("Selected Month: from", input$month[1], " to ", input$month[2])
    str3 <- paste("API Mean: ", round(mean(dataSel[, "API"]), digits = 2))
    if (input$displaySelectionMean==TRUE) {
      HTML(paste(str1, str2, str3, sep = '<br/>'))
    } else {
      HTML("No display for 'Selection and API Mean'")
    }
  })
  
  output$plot1 <- renderPlot({
    dataSel <- dataSelect()
    ggplot(data=dataSel, aes(x=dataSel$Hour, y =dataSel$API))+geom_smooth(color="red")+labs(x="Hour", y="API Reading")
  })
  
  output$dTable <- renderDataTable({
    dataSelect()
  })
  
  output$dSummary <- renderText({
    dataSel <- dataSelect()
    dataSel <- dataSel[, c("Hour", "API")]
    summary(dataSel)
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("data_", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      write.csv(dataSelect(), file, row.names=FALSE)
    }
  )
  
} # end of function(input, output)