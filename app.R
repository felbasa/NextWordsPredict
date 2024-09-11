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

# Define UI for application that draws a histogram
ui <- ui <- fluidPage(
  tableOutput("myTable")
)

# Define server logic required
server <- function(input, output, session) {
  
  # Function to get data from Google Sheets
  get_data <- reactive({
    sheet_url <- "https://docs.google.com/spreadsheets/d/1B9k5_BNwvTcy4sjWlUMVpVMdvA4RTLefTCbcJN66eFM/edit?resourcekey=&gid=967575587#gid=967575587"
    read_sheet(sheet_url) %>%
      # select every column except for timestamp and user's email address
      select(!c(Timestamp, `Email Address`))
  })
  
  # Example output
  output$myTable <- renderTable({
    get_data()
  })
}


# Run the application 
shinyApp(ui = ui, server = server)
