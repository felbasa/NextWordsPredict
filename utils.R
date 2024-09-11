cat("Loading helper functions from utils.R...\n")

# Helper function to generate a bar plot for any question
create_ggplot_bar <- function(df, question_column, question_title, color_fill = "blue") {
  ggplot(df, aes_string(x = question_column)) +
    geom_bar(fill = color_fill, color = "black") +
    labs(title = paste("Bar Plot for", question_title), x = "Word", y = "Count") +
    theme_minimal()
}

renderDataTable <- function(filtered_data, title = "Data", font_size = "18px") {
  datatable(
    filtered_data,
    extensions = c('Buttons'),
    options = list(
      pageLength = 5,
      lengthMenu = c(5, nrow(filtered_data) / 2, nrow(filtered_data)),
      scrollX = TRUE,
      paging = TRUE,
      searching = TRUE,
      fixedColumns = list(leftColumns = 1),
      autoWidth = FALSE,
      destroy = TRUE,
      ordering = TRUE,
      dom = 'Bfrtip',
      buttons = list(
        list(
          extend = 'collection',
          buttons = c('copy', 'csv', 'excel'),
          text = 'Descargar Datos'
        )
      )
    )
  )
}
