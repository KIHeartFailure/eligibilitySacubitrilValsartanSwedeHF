funcCoMorb <- function(cmname,
                       diakod = NULL,
                       opkod = NULL,
                       ekod = NULL,
                       diavar = DIA_all,
                       opvar = OP_all,
                       ekodvar = ekod_all,
                       yearsprior = NULL,
                       indata = comorb,
                       reg = "Patientregistret, sluten-, oppenvard- och dagkirurgi",
                       pos = paste0(
                         "All positions",
                         if (!is.null(diakod)) " (HDIA+BDIA1-BDIAXX)",
                         if (!is.null(opkod)) " (OP1-OPXX)",
                         if (!is.null(ekod)) " (Ekod1-EkodXX)"
                       ),
                       tid = ifelse(!is.null(yearsprior),
                         paste0(yearsprior, " year(s) prior to indexdate-indexdate"),
                         paste0("-indexdate")
                       )) {
  cmname2 <- paste0("com_p_", cmname)

  cm <- indata %>% mutate(!!cmname2 := "no")

  if (!is.null(yearsprior)) cm <- cm %>% filter(discharge_date > date - yearsprior * 365.25)

  if (!is.null(diakod)) cm <- cm %>% mutate(cmname_dia = str_detect(!!enquo(diavar), diakod))
  if (!is.null(opkod)) cm <- cm %>% mutate(cmname_op = str_detect(!!enquo(opvar), opkod))
  if (!is.null(ekod)) cm <- cm %>% mutate(cmname_ekod = str_detect(!!enquo(ekodvar), ekod))

  cm <- cm %>% mutate(!!cmname2 := ifelse(rowSums(select(., contains("cmname_"))) > 0, "yes", "no"))

  cm <- cm %>%
    filter(UQ(rlang::sym(cmname2)) == "yes") %>%
    group_by(lopnr) %>%
    slice(1) %>%
    ungroup()

  pdata <<- left_join( # global dataset, writes to global env
    pdata,
    cm %>% select(lopnr, !!cmname2),
    by = "lopnr"
  ) %>%
    mutate(
      !!cmname2 := replace_na(UQ(rlang::sym(cmname2)), "no"),
      !!cmname2 := factor(UQ(rlang::sym(cmname2)))
    )

  # create data to print in table in statistical report
  fixcmkod <- function(kod) {
    kod <- str_replace_all(kod, " ", "")
    kod <- str_replace_all(kod, "\\|", ", ")
    kod <- str_replace_all(kod, "\\(\\?!", " (excl. ")
    kod <- paste0(kod, collapse = ": ")
    return(kod)
  }

  cmkod <- paste0(apply(enframe(c(ICD = diakod, OP = opkod, Ekod = ekod)), 1, fixcmkod), collapse = ", ")

  cm.tmp <- data.frame(cmname, cmkod, reg, pos, tid)
  colnames(cm.tmp) <- c("Comorbidity", "Code", "Register", "Position", "Period")

  if (exists("cm.out")) {
    cm.out <<- rbind(cm.out, cm.tmp) # global variable, writes to global env
  } else {
    cm.out <<- cm.tmp # global variable, writes to global env
  }
}
