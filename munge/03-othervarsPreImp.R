

# Create vars (other than SoS) PRIOR to imputation (used in imp model) ------

## Income
inc <- pdata %>%
  group_by(indexYear) %>%
  summarise(incsum = list(enframe(quantile(scb.dispinc, probs = c(0.33, 0.66), na.rm = TRUE)))) %>%
  unnest(cols = c(incsum)) %>%
  spread(name, value)

pdata <- left_join(pdata, inc, by = "indexYear") %>%
  select(-bmi) %>%
  mutate(scb.income_cat = case_when(
    scb.dispinc < `33%` ~ "1.Low",
    scb.dispinc < `66%` ~ "2.Medium",
    scb.dispinc >= `66%` ~ "3.High"
  )) %>%
  select(-`33%`, -`66%`) %>%
  mutate(
    # needed for ntprobnp criteria
    prevHFhosp9mo = case_when(
      # location == "in-patient" ~ "yes",
      daysLasthfHosp <= 30.5 * 9 ~ "yes",
      TRUE ~ "no"
    ),
    prevHFhosp12mo = case_when(
      # location == "in-patient" ~ "yes",
      daysLasthfHosp <= 365.25 ~ "yes",
      TRUE ~ "no"
    ),
    ## Device
    device_cat = case_when(
      is.na(device) ~ NA_character_,
      device %in% c("CRT", "CRT_D", "ICD") ~ device,
      TRUE ~ "no/pacemaker"
    ),
    efgroup = case_when(
      lvef %in% c("<30%", "30-39%") ~ "rEF",
      lvef %in% c("40-49%") ~ "mrEF",
      lvef %in% c(">= 50%") ~ "pEF"
    ),

    # eGFR according to MDRD
    sex = recode(gender, "male" = 1, "female" = 0),
    ethnicity = 0, # ethnicity is unknown. therefore all are considered not "African-American"
    MDRD = nephro::MDRD4(creatinine / 88.4, sex, age, ethnicity),
    MDRD_cat = case_when(
      is.na(MDRD) ~ NA_character_,
      MDRD < 30 ~ "1.<30",
      MDRD < 60 ~ "2.30-<60",
      MDRD >= 60 ~ "3.>=60"
    ),
    logntProBNP = log10(ntProBNP + 1),
    com_stroke_tia = case_when(
      com_stroke == "yes" | com_TIA == "yes" ~ "yes",
      TRUE ~ "no"
    ),
    com_pci_cabg = case_when(
      com_cabg == "yes" | com_pci == "yes" ~ "yes",
      TRUE ~ "no"
    ),
    scb.education_cat = ifelse(scb.education %in%
      c("Compulsory school less than 9 years", "Compulsory school, 9 years"),
    "Compulsory school", scb.education
    ),
    indexYear = as.numeric(indexYear),
    bmi = weight / (height / 100)^2,
    bmi_cat = case_when(
      is.na(bmi) ~ NA_character_,
      bmi <= 30 ~ "1.<=30",
      bmi <= 40 ~ "2.>30-40",
      bmi > 40 ~ "3.>40"
    )
  ) %>%
  select(-ntProBNP)

## Previous EF < 40%
ef40 <- rs.data11 %>%
  filter(lvef %in% c("<30%", "30-39%")) %>%
  group_by(lopnr) %>%
  arrange(date) %>%
  slice(1) %>%
  ungroup() %>%
  select(lopnr, date)

pdata <- left_join(pdata,
  ef40 %>% rename(efdate = date),
  by = "lopnr"
) %>%
  mutate(prevef40 = case_when(
    efdate <= date ~ "yes",
    TRUE ~ "no"
  )) %>%
  select(-efdate) %>%
  mutate(
    efgroup = factor(efgroup, levels = c("pEF", "mrEF", "rEF"), ordered = TRUE),
    lvef = factor(lvef, levels = c("<30%", "30-39%", "40-49%", ">= 50%"))
  ) %>%
  mutate_if(is_character, factor) %>%
  mutate_at(vars(smoking, nyha, scb.education_cat, scb.income_cat, bmi_cat, MDRD_cat), as.ordered)
