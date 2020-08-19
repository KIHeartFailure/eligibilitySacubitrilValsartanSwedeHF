mykable <- function(data, row.names = FALSE) {
  knitr::kable(data,
    booktabs = TRUE,
    linesep = "",
    row.names = row.names,
    escape = FALSE,
    align = c(rep("l", ncol(data)))
  ) %>%
    kable_styling("striped", "hold_position", position = "left", full_width = F)
}
