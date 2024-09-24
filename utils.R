cat("Loading helper functions from utils.R...\n")

# Function to preprocess text data by removing stopwords and extra spaces
preprocess <- function(x){
  require(quanteda) # Load the 'quanteda' package for stopwords
  data.frame(Value = gsub("  ", " ", # Replace double spaces with a single space
                          gsub("  ", " ", # Ensure extra spaces are removed
                               gsub(paste("\\b", stopwords("en"), "\\b", sep="", collapse="|"), "", x)))) # Remove stopwords from the text
}

# Function to count word frequencies in a text column
count_word_frequencies <- function(column) {
  column %>%
    str_split("[^A-Za-z]+") %>%      # Split by non-letter characters to isolate words
    unlist() %>%                     # Convert the list of words to a vector
    table() %>%                      # Count the occurrences of each word
    as.data.frame() %>%              # Convert the table of counts to a dataframe
    arrange(desc(Freq))              # Sort the dataframe by frequency in descending order
}

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
create_ggplot_bar <- function(data, title = "Question") {
  data <- data()
  
  # Check if there is data to plot
  if (nrow(data) > 0) {
    ggplot(data, aes(x = UserInput)) +
      geom_bar() +
      theme_minimal() +
      labs(title = title,
           x = "Input Values",
           y = "Count")
  }
}

# Helper function to create a bar plot with the given dataset
create_ggplot_bar_openai <- function(data) {
  # Check if there is data to plot
  if (nrow(data) > 0) {
    ggplot(data, aes(x = ., y = Freq)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      labs(title = "Histogram of Frequencies",
           x = "Category",
           y = "Frequency")
  }
}



