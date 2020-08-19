
ProjectTemplate::load.project(list(munging = FALSE, data_loading = FALSE))

# Import data from SAS ----------------------------------------------------

memory.limit(5000000)

sv <- read_sas("./raw-data/sv_sel_7403_2017.sas7bdat")
ov <- read_sas("./raw-data/ov_sel_7403_2017.sas7bdat")
dagkir <- read_sas("./raw-data/dagk_sel_7403_2017.sas7bdat")


# Create dataset used for comorb (in order to downsize data) ----------------

patreg <- bind_rows(
  sv %>% mutate(source = "SV"),
  ov %>% mutate(source = "OV"),
  dagkir %>% mutate(source = "DK")
) %>%
  mutate_at(vars(matches("DIA|OP|ekod")), list(~ replace_na(., ""))) %>%
  unite(DIA_all, contains("DIA", ignore.case = FALSE), sep = " ", remove = TRUE) %>%
  unite(OP_all, contains("OP", ignore.case = FALSE), sep = " ", remove = TRUE) %>%
  unite(ekod_all, contains("ekod", ignore.case = FALSE), sep = " ", remove = TRUE) %>%
  mutate(
    DIA_all = paste0(" ", DIA_all),
    OP_all = paste0(" ", OP_all),
    ekod_all = paste0(" ", ekod_all),
    ## saknas datum Sahlgrenska dagkirurgi 1999 och Arvika, Torsby 2009 oppenvard så imp med 1 jan år
    discharge_date = coalesce(UTDATUM, INDATUM, ymd(paste0(AR, "-01-01")))
  ) %>%
  select(lopnr, discharge_date, DIA_all, OP_all, ekod_all, source)


# Store as RData in /data folder ------------------------------------------

save(file = "./data/patreg.RData", list = c("patreg"))
