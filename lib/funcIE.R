funcIE <- function(ie_mp, ie_r, ienr, inex = "ex", noie = FALSE, pragscenie = FALSE) {
  ieprefix <- paste0("ie_")

  if (noie) {
    ieprefix <- paste0(ieprefix, "no_")
  }
  if (pragscenie) {
    ieprefix <- paste0(ieprefix, inex, "_pragscen_")
  }
  iename <- paste0(ieprefix, inex, sub(". ", "", ienr))

  impdata <<- impdata %>%
    mutate(
      !!iename := case_when(
        efgroup %in% c("rEF") ~ !!enexpr(ie_r),
        efgroup %in% c("mrEF", "pEF") ~ !!enexpr(ie_mp)
      )
    ) # global
  pdata <<- pdata %>%
    mutate(
      !!iename := case_when(
        efgroup %in% c("rEF") ~ !!enexpr(ie_r),
        efgroup %in% c("mrEF", "pEF") ~ !!enexpr(ie_mp)
      )
    ) # global
}

funcSumIE <- function(indata, groupvar) {
  groupvar <- enexpr(groupvar)

  indata %>%
    filter(!is.na(UQ(rlang::sym(groupvar)))) %>%
    group_by(UQ(rlang::sym(groupvar))) %>%
    count() %>%
    ungroup() %>%
    mutate(
      freq = round((n / sum(n)) * 100, 1),
      out = paste0(n, " (", freq, "%)")
    ) %>%
    filter(UQ(rlang::sym(groupvar))) %>%
    select(out)
}

funcIETab <- function(ievar, iedesc, impdata_tmp, pdata_tmp) { # , EF502 = EF50) {
  flowtab_tmp <- unlist(c(
    iedesc,
    funcSumIE(impdata_tmp, groupvar = !!ievar),
    funcSumIE(pdata_tmp %>% filter(nomissing), groupvar = !!ievar),
    funcSumIE(pdata_tmp, groupvar = !!ievar)
  ))
  return(flowtab_tmp)
}

funcSumIEAll <- function(iesumname, ievars, impdata_tmp, pdata_tmp, filtvar = NULL) { # , EF502 = EF50) {
  if (!is.null(filtvar)) {
    impdata_tmp <- impdata_tmp %>%
      filter(!is.na(UQ(rlang::sym(filtvar))))
    pdata_tmp <- pdata_tmp %>%
      filter(!is.na(UQ(rlang::sym(filtvar))))
  }

  tempflowtab <- unlist(c(
    iesumname,
    funcSumIE(impdata_tmp %>%
      mutate(sumanyie = rowSums(select(., matches(ievars)) == FALSE) == 0),
    groupvar = "sumanyie"
    ),
    funcSumIE(pdata_tmp %>%
      mutate(sumanyie = rowSums(select(., matches(ievars)) == FALSE) == 0) %>%
      filter(nomissing),
    groupvar = "sumanyie"
    ),
    funcSumIE(pdata_tmp %>%
      mutate(sumanyie = rowSums(select(., matches(ievars)) == FALSE) == 0),
    groupvar = "sumanyie"
    )
  ))
  return(tempflowtab)
}

funcIEfake <- function(iedesc) { # , EF50 = TRUE) {
  flowtab_tmp <- c(iedesc, rep(NA, 3))
  return(flowtab_tmp)
}
