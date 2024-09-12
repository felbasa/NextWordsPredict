cat("Loading helper functions from utils.R...\n")

# Helper function to generate a bar plot for any question
create_ggplot_bar <- function(df, question_column, question_title, color_fill = "blue") {
  ggplot(df, aes_string(x = question_column)) +
    geom_bar(fill = color_fill, color = "black") +
    labs(title = paste("Bar Plot for", question_title), x = "Word", y = "Count") +
    theme_minimal()
}