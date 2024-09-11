#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
library(shiny)
library(googlesheets4)
library(dplyr)
library(DT)
source("utils.R")

# Define UI for application that renders graphs for each question asked in the survey
ui <- fluidPage(
  titlePanel("Histograms for Each Question"),
  sidebarLayout(
    sidebarPanel(
      # Optional: Add inputs if needed
    ),
    mainPanel(
      plotOutput("histogramPlotQ1"), 
      plotOutput("histogramPlotQ2"), 
      plotOutput("histogramPlotQ3"), 
      plotOutput("histogramPlotQ4"), 
      plotOutput("histogramPlotQ5"), 
      plotOutput("histogramPlotQ6"), 
      uiOutput("myTable")
    )
  )
)

# Define server logic required
server <- function(input, output, session) {
  
  # Function to get data from Google Sheets and perform data manipulation
  df <- reactive({
    sheet_url <- "https://docs.google.com/spreadsheets/d/1B9k5_BNwvTcy4sjWlUMVpVMdvA4RTLefTCbcJN66eFM/edit?resourcekey=&gid=967575587#gid=967575587"
    read_sheet(sheet_url) %>%
      # select every column except for timestamp and user's email address
      select(!c(Timestamp, `Email Address`))
  })
  
  # Data table output
  output$myTable <- renderTable({
    df()
  })
  
  # Reactive expression to generate barplot for Question 1
  output$histogramPlotQ1 <- renderPlot({
    create_ggplot_bar(df(), "`Julia went swimming at the ______.`", "Julia went swimming at the ______.", color_fill = "#00274D")
  })
  
  # Reactive expression to generate barplot for Question 2
  output$histogramPlotQ2 <- renderPlot({
    create_ggplot_bar(df(), "`Gabriella went to school to ______.`", "Gabriella went to school to ______.", color_fill = "#FFCB05")
  })
  
  # Reactive expression to generate barplot for Question 3
  output$histogramPlotQ3 <- renderPlot({
    create_ggplot_bar(df(), "`Clarence couldn't believe how ______ the weather was today.`", "Clarence couldn't believe how ______ the weather was today.", color_fill = "#545454")
  })
  
  # Reactive expression to generate barplot for Question 4
  output$histogramPlotQ4 <- renderPlot({
    create_ggplot_bar(df(), "`So far, this course makes me wonder about ______.`", "So far, this course makes me wonder about ______.", color_fill = "#F2E085")
  })
  
  # Reactive expression to generate barplot for Question 5
  output$histogramPlotQ5 <- renderPlot({
    create_ggplot_bar(df(), "`After finishing her homework, Amy decided to ______.`", "After finishing her homework, Amy decided to ______.", color_fill = "#5978A4")
  })
  
  # Reactive expression to generate barplot for Question 6
  output$histogramPlotQ6 <- renderPlot({
    create_ggplot_bar(df(), "`Anthony was excited about the upcoming ______ because he loved spending time with his friends.`", "Anthony was excited about the upcoming ______ because he loved spending time with his friends.", color_fill = "#A3B5A2")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
