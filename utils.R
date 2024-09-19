cat("Loading helper functions from utils.R...\n")

# Helper function to return new data to append based on input
append_input_to_dataset <- function(input, text_input_id, dataset) {
  # Get current dataset
  current_data <- dataset()
  
  # Append the new input
  new_data <- rbind(current_data, data.frame(UserInput = input[[text_input_id]], stringsAsFactors = FALSE))
  
  # Return updated dataset
  return(new_data)
}

# Helper function to generate a bar plot for each question
create_ggplot_bar <- function(data) {
  data <- data()
  
  # Check if there is data to plot
  if (nrow(data) > 0) {
    ggplot(data, aes(x = UserInput)) +
      geom_bar() +
      theme_minimal() +
      labs(title = "User Input Visualization",
           x = "Input Values",
           y = "Count")
  }
}




