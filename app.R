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
library(ggplot2)
library(readr)
library(stringr)
source("utils.R")

# read open ai data
openai_dat <- read_csv("openai_dat.csv")
# resp1_freq <- tibble(count_word_frequencies(openai_dat$resp1))
resp1_freq <- count_word_frequencies(preprocess(openai_dat$resp1))

# Define UI for application that renders graphs for each question asked in the survey
ui <- fluidPage(
  titlePanel("Histograms for Each Question"),
  sidebarLayout(
    sidebarPanel(
      # Input: Text input for question 1
      textInput("user_input_Q1", "Julia went swimming at the ______", ""),
      # Action button to submit the input
      actionButton("submit_Q1", "Submit")
      
      # Input: Text input for question 2
      # textInput("user_input_Q2", "", ""),
      # # Action button to submit the input
      # actionButton("submit_Q2", "Submit")
    ),
    mainPanel(
      fluidRow(
        column(6, plotOutput("plot_Q1")),  # First plot
        column(6, plotOutput("plot_Q1_openai"))   # Second plot
      ),
      # plotOutput("plot_Q2")
      # plotOutput("histogramPlotQ1"), 
      # plotOutput("histogramPlotQ2"), 
      # plotOutput("histogramPlotQ3"), 
      # plotOutput("histogramPlotQ4"), 
      # plotOutput("histogramPlotQ5"), 
      # plotOutput("histogramPlotQ6") 
      uiOutput("myTable")
    )
  )
)

# Define server logic required
server <- function(input, output, session) {
  ########## building reactive dataset and graph
  # Initialize reactive datasets 
    datasetQ1 <- reactiveVal(data.frame(UserInput = character(0), stringsAsFactors = FALSE))
    datasetQ2 <- reactiveVal(data.frame(UserInput = character(0), stringsAsFactors = FALSE))
    datasetQ3 <- reactiveVal(data.frame(UserInput = character(0), stringsAsFactors = FALSE))
    
    # Observe button click and add the user input to the dataset
    observeEvent(input$submit_Q1, {
        # Use the helper function to update the dataset for input 1
        new_data <- append_input_to_dataset(input, "user_input_Q1", datasetQ1)
        # Update the reactive dataset
        datasetQ1(new_data)
    })
    
    # Data table output
    # output$myTable <- renderTable({
    #   dataset()
    # })
    
    # Render a plot based on the updated dataset
    output$plot_Q1 <- renderPlot({
      create_ggplot_bar(datasetQ1, "Julia went swimming at the ______")
    })
    
    # Render a plot based on openai's Q1 data
    output$plot_Q1_openai <- renderPlot({
      create_ggplot_bar_openai(resp1_freq)
    })
    
    
    # output$plot <- renderPlot({
    #   data <- dataset()
    #   
    #   # Check if there is data to plot
    #   if (nrow(data) > 0) {
    #     ggplot(data, aes(x = UserInput)) +
    #       geom_bar() +
    #       theme_minimal() +
    #       labs(title = "User Input Visualization",
    #            x = "Input Values",
    #            y = "Count")
    #   }
    # })
  
  ##########
  # Function to get data from Google Sheets and perform data manipulation
  # df <- reactive({
  #   # Authenticate using the downloaded JSON file
  #   gs4_auth(path = "nextwordspredict-1f60d4671052.json")
  #   sheet_url <- "https://docs.google.com/spreadsheets/d/1B9k5_BNwvTcy4sjWlUMVpVMdvA4RTLefTCbcJN66eFM/edit?resourcekey=&gid=967575587#gid=967575587"
  #   read_sheet(sheet_url) %>%
  #     # select every column except for timestamp and user's email address
  #     select(!c(Timestamp, `Email Address`))
  # })
  
  # # Reactive expression to generate barplot for Question 1
  # output$histogramPlotQ1 <- renderPlot({
  #   create_ggplot_bar(df(), "`Julia went swimming at the ______.`", "Julia went swimming at the ______.", color_fill = "#00274D")
  # })
  
  # # Reactive expression to generate barplot for Question 2
  # output$histogramPlotQ2 <- renderPlot({
  #   create_ggplot_bar(df(), "`Gabriella went to school to ______.`", "Gabriella went to school to ______.", color_fill = "#FFCB05")
  # })
  # 
  # # Reactive expression to generate barplot for Question 3
  # output$histogramPlotQ3 <- renderPlot({
  #   create_ggplot_bar(df(), "`Clarence couldn't believe how ______ the weather was today.`", "Clarence couldn't believe how ______ the weather was today.", color_fill = "#545454")
  # })
  # 
  # # Reactive expression to generate barplot for Question 4
  # output$histogramPlotQ4 <- renderPlot({
  #   create_ggplot_bar(df(), "`So far, this course makes me wonder about ______.`", "So far, this course makes me wonder about ______.", color_fill = "#F2E085")
  # })
  # 
  # # Reactive expression to generate barplot for Question 5
  # output$histogramPlotQ5 <- renderPlot({
  #   create_ggplot_bar(df(), "`After finishing her homework, Amy decided to ______.`", "After finishing her homework, Amy decided to ______.", color_fill = "#5978A4")
  # })
  # 
  # # Reactive expression to generate barplot for Question 6
  # output$histogramPlotQ6 <- renderPlot({
  #   create_ggplot_bar(df(), "`Anthony was excited about the upcoming ______ because he loved spending time with his friends.`", "Anthony was excited about the upcoming ______ because he loved spending time with his friends.", color_fill = "#A3B5A2")
  # })
  
  # Data table output
  # output$myTable <- renderTable({
  #   df()
  # })
}

# Run the application 
shinyApp(ui = ui, server = server)
