library(googlesheets4)
library(readr)

# Authenticate with Google
gs4_auth()

# Read the data from your Google Sheet
sheet_url <- "https://docs.google.com/spreadsheets/d/1B9k5_BNwvTcy4sjWlUMVpVMdvA4RTLefTCbcJN66eFM/edit?resourcekey=&gid=967575587#gid=967575587"
df <- read_sheet(sheet_url)
df %>%
  # select every column except for timestamp and user's email address
  select(!c(Timestamp, `Email Address`))

ggplot(df, aes(x = `Julia went swimming at the ______.`)) +
  geom_bar(fill = "blue", color = "black") +
  labs(title = "Bar Plot for Question1", x = "Question1", y = "Count") +
  theme_minimal()

ggplot(df(), aes(x = `Gabriella went to school to ______.`)) +
  geom_bar(fill = "blue", color = "black") +
  labs(title = "Bar Plot for Question1", x = "Question1", y = "Count") +
  theme_minimal()

########### OPEN AI STUFF
# reading in openai data
openai_dat <- read_csv("openai_dat.csv")

library(dplyr)
library(stringr)
library(quanteda)

# Function to count word frequencies in a specific column
count_word_frequencies <- function(column) {
  column %>%
    str_split("\\s+") %>%            # Split by spaces
    unlist() %>%                     # Unlist to get a vector of words
    table() %>%                      # Count occurrences
    as.data.frame() %>%              # Convert to dataframe
    arrange(desc(Freq))              # Arrange by frequency
}

count_letter_frequencies <- function(column) {
  column %>%
    str_split("[^A-Za-z]+") %>%      # Split by non-letter characters
    unlist() %>%                     # Unlist to get a vector of words
    table() %>%                      # Count occurrences of each letter
    as.data.frame() %>%              # Convert to dataframe
    arrange(desc(Freq))              # Arrange by frequency
}

# Apply the function to each of the relevant columns
resp1_freq <- count_word_frequencies(openai_dat$resp1)
resp2_freq <- count_word_frequencies(openai_dat$resp2)
resp3_freq <- count_word_frequencies(openai_dat$resp3)
resp4_freq <- count_word_frequencies(openai_dat$resp4)
resp5_freq <- count_word_frequencies(openai_dat$resp5)
resp6_freq <- count_word_frequencies(openai_dat$resp6)

# Display results
list(
  resp1 = resp1_freq,
  resp2 = resp2_freq,
  resp3 = resp3_freq,
  resp4 = resp4_freq,
  resp5 = resp5_freq,
  resp6 = resp6_freq
)
######## preprocess function
preprocess <- function(x){
  require(quanteda)
  data.frame(Value = gsub("  ", " ", gsub("  ", " ", gsub(paste("\\b", stopwords("en"), "\\b", sep="", collapse="|"), "", x))))
}

count_word_frequencies(preprocess(openai_dat$resp1))
lapply(openai_dat, preprocess)


#########

