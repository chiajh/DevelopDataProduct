library(shiny)
library(lubridate)
library(ggplot2)

# Shiny server
shinyServer <- function (input, output) {
  dataAPI <-read.csv("API_Banting.csv")
  output$plot1 <- renderPlot({
    dataSelect <- dataAPI[(year(dataAPI$Date)==input$year & month(dataAPI$Date)==input$month), ]
    ggplot(data=dataSelect, aes(x=dataSelect$Hour, y =dataSelect$API))+geom_smooth(color="red")+labs(x="Hour", y="API")
  })
  output$dTable <- renderDataTable({
    dataSelect <- dataAPI[(year(dataAPI$Date)==input$year & month(dataAPI$Date)==input$month), ]
  })
} # end of function(input, output)
