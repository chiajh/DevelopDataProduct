# The user graphic interface definition for Shiny web application.
library(shiny)
library(lubridate)
library(ggplot2)
require(markdown)

shinyUI <- fluidPage(
  navbarPage("Air Pollutant Index (API) 2013-2015 for Banting area",
             # multi-page user-interface that includes a navigation bar.
             tabPanel("Display the API",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput(inputId = "year", label = "Select Year:", selected =2014, choices = c(2013,2014,2015)),
                          sliderInput(inputId = "month", label = "Range of Month:", min = 1, max = 12, value = c(1, 12)),
                          checkboxInput(inputId="displaySelectionMean", "Display Selection and API Mean:", value = TRUE),
                          htmlOutput("html1") ),
                        mainPanel(
                          tabsetPanel(
                            tabPanel(p(icon("line-chart"), "Graph"),
                                     h4('Air Pollutant Index for Banting area', align = "center"),
                                     plotOutput("plot1")
                            ), # end of "Graph" tab panel
                            
                            tabPanel(p(icon("table"), "Dataset"),
                                     dataTableOutput(outputId="dTable"),
                                     downloadButton("downloadData", label ="Download")
                            ), # end of "Dataset" tab panel
                            
                            tabPanel(p(icon("list-alt"), "Summary"),
                                     textOutput("dSummary")
                            ) # end of "Summary" tab panel
                            
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