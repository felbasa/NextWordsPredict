# Helper function to create histograms
create_histogram <- function(data, column, x_label, y_label, title) {
  # Check if there is data to plot
  if (nrow(data) > 0) {
    ggplot(data, aes_string(x = column)) +
      geom_bar(stat = "count") +  # Default stat is "count", but making it explicit
      theme_minimal() +
      labs(title = title,
           x = x_label,
           y = y_label) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +  # Rotate x-axis labels for readability
      scale_x_discrete(limits = rev(levels(factor(data[[column]]))))  # Reorder based on factor levels in reverse order
  }
}


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
    mutate(Freq = Freq / sum(Freq)) %>% # Calculate frequencies by dividing by the total count
    arrange(desc(Freq))              # Sort the dataframe by frequency in descending order
}

# Helper function to create a bar plot with the given dataset
create_ggplot_bar_openai <- function(data) {
  # Check if there is data to plot
  if (nrow(data) > 0) {
    ggplot(data, aes(x = reorder(., -Freq), y = Freq)) +  # Reorder based on Freq in descending order
      geom_bar(stat = "identity") + 
      theme_minimal() + 
      labs(title = "Histogram of OpenAI Frequencies",
           x = "OpenAI Words",
           y = "Frequency") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for readability
  }
}