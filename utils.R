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

# df <- preprocess(openai_dat$resp4)

# words = vector of words (from csv or openAI list)
# newword = Novel word added by user
# ip = vector of ip addresses from csv to drop duplicates
# main = Title of Plot
# histplot <-function(words, newword=NULL, ip=NULL, main="Plot", charmax=30, maxbars=20){
#   if(!is.null(ip))
#     words <- words[!duplicated(ip)]
#   wdspre <- rev(sort(table(preprocess(words))))
#   wds <- wdspre/sum(wdspre)
#   colset <- rep("gray", length(usewds))
#   bordset <- rep("black", length(usewds))
#   if(!is.null(newword)){
#     if(!(newword %in% names(wds))){  
#       wds <- c(wds, 'new'=0)
#       names(wds)[length(wds)] <- newword
#     }
#     usewds <- wds[names(wds) %in% c(names(wds)[1:min(c(maxbars, length(wds)))], newword)]
#     colset[names(usewds)==newword] <- "orange"
#     bordset[names(usewds)==newword] <- "red"
#   }
#   if(is.null(newword)){
#     usewds <- wds[1:min(c(maxbars, length(wds)))]
#   }
#   if(length(usewds)<length(wds)){
#     othsum <- sum(wds[!(names(wds) %in% names(usewds))])
#     usewds <- c(usewds, 'OTHER'=othsum)
#   }
#   if(max(nchar(names(usewds)))>charmax){
#     names(usewds)[nchar(names(usewds))>charmax] <- paste(substring(names(usewds)[nchar(names(usewds))>charmax], 1, 15), "...", sep="")
#   }
#   barplot(usewds, las=2, col=colset, ylab="Proportion of Responses", main=main, names.arg="", border=bordset)
#   text((1:length(usewds))*1.2-.15, -.005, srt=45, label=names(usewds), pos=2, xpd=TRUE, col=bordset) # 1.25 is scaling parameter, check it - may require mx+b
# }
histplot <- function(words, newword = NULL, ip = NULL, main = "Plot", charmax = 30, maxbars = 20) {
  # Define the function 'histplot' with parameters for input words, an optional new word, and various plot settings.
  
  if (!is.null(ip))
    # Check if 'ip' is not NULL. If it's provided, filter out duplicate entries in 'words'.
    words <- words[!duplicated(ip)]
  
  wdspre <- rev(sort(table(preprocess(words))))
  # Preprocess the input words (this function is assumed to be defined elsewhere), count their occurrences,
  # sort them in descending order, and reverse the order to get a descending frequency count.
  
  wds <- wdspre / sum(wdspre)
  # Calculate the proportions of each word by dividing the frequency counts by the total number of words.
  
  

  if (!is.null(newword)) {
    # Check if 'newword' is provided.
    newword <- as.character(preprocess(newword))
    if (!(newword %in% names(wds))) {
      # If the 'newword' is not in the names of the words, add it to the word proportions with a count of 0.
      wds <- c(wds, 'new' = 0)
      names(wds)[length(wds)] <- newword  # Set the name of the last element to 'newword'.
    }
    
    usewds <- wds[names(wds) %in% c(names(wds)[1:min(c(maxbars, length(wds)))], newword)]
    # Select the top 'maxbars' words from 'wds', including 'newword' if it's present.
    colset <- rep("gray", length(usewds))
    # Initialize a color vector 'colset' filled with "gray" for the bars in the plot.
    bordset <- rep("black", length(usewds))
    # Initialize a border color vector 'bordset' filled with "black" for the borders of the bars.
    colset[names(usewds) == newword] <- "orange"
    # Set the color of 'newword' to "orange" in 'colset'.
    bordset[names(usewds) == newword] <- "red"
    # Set the border color of 'newword' to "red" in 'bordset'.
  }
  
  if (is.null(newword)) {
    # If 'newword' is not provided, just select the top 'maxbars' words.
    usewds <- wds[1:min(c(maxbars, length(wds)))]
    colset <- rep("gray", length(usewds))
    # Initialize a color vector 'colset' filled with "gray" for the bars in the plot.
    bordset <- rep("black", length(usewds))
    # Initialize a border color vector 'bordset' filled with "black" for the borders of the bars.
  }
  
  if (length(usewds) < length(wds)) {
    # If the number of selected words ('usewds') is less than the total number of words ('wds'),
    othsum <- sum(wds[!(names(wds) %in% names(usewds))])
    # Calculate the sum of frequencies of words not included in 'usewds' (for "OTHER" category).
    
    usewds <- c(usewds, 'OTHER' = othsum)
  }
  if(length(usewds)>length(colset))
    colset <- c(colset, rep("gray", length(usewds)-length(colset)))
    # Make the "other" category gray
  if(length(usewds)>length(bordset))
    bordset <- c(bordset, rep("black", length(usewds)-length(bordset)))
    # With a black edge
  
  if (max(nchar(names(usewds))) > charmax) {
    # Check if any word name exceeds the character limit ('charmax').
    names(usewds)[nchar(names(usewds)) > charmax] <- paste(substring(names(usewds)[nchar(names(usewds)) > charmax], 1, 15), "...", sep = "")
    # Truncate long names to the first 15 characters and append "..." for readability.
  }
  
  barplot(usewds, las = 2, col = colset, ylab = "Proportion of Responses", main = main, names.arg = "", border = bordset)
  # Create a bar plot using 'usewds', setting the y-axis label, main title, colors, and borders.
  
  text((1:length(usewds)) * 1.2 - .2, -.015, srt = 45, label = names(usewds), pos = 2, xpd = TRUE, col = bordset)
  # Add text labels to the bars, adjusting their position and rotation for clarity.
  # The scaling factor (1.2) may need checking for appropriate placement.
}

# histplot(openai_dat$resp4, newword="tea", ip="12123123", main="Plot", charmax=30, maxbars=4)




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

#rev(sort(table(x)))

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
