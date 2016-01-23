# The user graphic interface definition for Shiny web application.
library(shiny)
library(lubridate)
library(ggplot2)
require(markdown)

shinyUI <- fluidPage(
  navbarPage("Air Pollutant Index 2013-2015 for Banting area",
             # multi-page user-interface that includes a navigation bar.
             tabPanel("Display the API",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput(inputId = "year", label = "Select Year:", selected =2014, choices = c(2013,2014,2015)),
                          selectInput(inputId = "month", label = "Select Month:", selected =1, choices = c(1,2,3,4,5,6,7,8,9,10,11,12)) ),
                        mainPanel(
                          tabsetPanel(
                            tabPanel(p(icon("line-chart"), "API Graph"),
                                     h4('Air Pollutant Index for Banting area', align = "center"),
                                     plotOutput("plot1")
                            ), # end of "API Graph" tab panel

                            tabPanel(p(icon("table"), "API Dataset"),
                                     dataTableOutput(outputId="dTable")
                            ) # end of "API Dataset" tab panel
                          ) # end of tabsetPanel
                        ) # mainPanel
                      ) #sidebarLayout
             ), # end of "Application" tabPanel

             tabPanel("Read Me",
                      mainPanel(
                        includeMarkdown("ReadMe.md")
                      ) # mainPanel
             ) # end of "Read Me" tabPanel

  ) # end of navbarPage
)
