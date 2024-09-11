library(googlesheets4)

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

