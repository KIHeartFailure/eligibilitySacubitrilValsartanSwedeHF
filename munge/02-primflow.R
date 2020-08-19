

# Primary criteria --------------------------------------------------------

flow <- c("Number of posts in SwedeHF", nrow(rs.data11))

pdata <- rs.data11 %>%
  # filter(lvef %in% c(">= 50%", "40-49%"))
  filter(!is.na(lvef))

flow <- rbind(flow, c("No missing EF", nrow(pdata)))

pdata <- pdata %>%
  filter(location %in% c("out-patient"))

flow <- rbind(flow, c("Out-patient posts", nrow(pdata)))

pdata <- pdata %>%
  group_by(lopnr) %>%
  arrange(date) %>%
  slice(n()) %>%
  ungroup()

flow <- rbind(flow, c("Last registration / patient", nrow(pdata)))

colnames(flow) <- c("Criteria", "N")
