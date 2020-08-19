

# Create criteria variables POST imputation -------------------------------

fixdata <- function(indata) {

  ## create sum of antihypertensive drugs (exl criteria 9b)
  utdata <- indata %>%
    select(betaBlocker, MRA, diuretics, ACEi, arb) %>%
    transmute(crit_Adrugs = rowSums(. == "yes")) %>%
    bind_cols(indata, .)

  ## create any missing for eligibility variables
  utdata <- utdata %>%
    mutate(
      ntProBNP = 10^logntProBNP - 1,
      crit_SBP_Adrugs = case_when(
        is.na(crit_Adrugs) | is.na(bp.sys) ~ NA_character_,
        bp.sys > 150 & bp.sys < 180 & crit_Adrugs < 3 ~ "yes",
        TRUE ~ "no"
      ),
      crit_SBP_AdrugsCB = case_when(
        is.na(crit_Adrugs) | is.na(bp.sys) ~ NA_character_,
        bp.sys > 150 & bp.sys < 180 & crit_Adrugs < 2 ~ "yes",
        TRUE ~ "no"
      ),
      crit_ntprobnp_mp = case_when(
        is.na(ntProBNP) | is.na(ekg) ~ NA_character_,
        ntProBNP > 200 & ekg != "Atrial fibrillation" & prevHFhosp9mo == "yes" |
          ntProBNP > 300 & ekg != "Atrial fibrillation" & prevHFhosp9mo == "no" |
          ntProBNP > 600 & ekg == "Atrial fibrillation" & prevHFhosp9mo == "yes" |
          ntProBNP > 900 & ekg == "Atrial fibrillation" & prevHFhosp9mo == "no" ~ "yes",
        TRUE ~ "no"
      ),
      crit_ntprobnp_r = case_when(
        is.na(ntProBNP) ~ NA_character_,
        ntProBNP >= 600 |
          ntProBNP >= 400 & prevHFhosp12mo == "yes" ~ "yes",
        TRUE ~ "no"
      ),
      raas = case_when(
        is.na(ACEi) | is.na(arb) ~ NA_character_,
        ACEi == "yes" | arb == "yes" ~ "yes",
        TRUE ~ "no"
      ),
      acedose = case_when(
        NAMNACE == "Captopril" ~ ACEi.dose / 100,
        NAMNACE == "Cilazapril" ~ ACEi.dose / 2.5,
        NAMNACE == "Enalapril" ~ ACEi.dose / 10,
        NAMNACE == "Fosinopril" ~ ACEi.dose / 20,
        NAMNACE == "Kinapril" ~ ACEi.dose / 20,
        NAMNACE == "Lisinopril" ~ ACEi.dose / 10,
        NAMNACE == "Ramipril" ~ ACEi.dose / 5,
        NAMNACE == "Trandolapril" ~ ACEi.dose / 2
      ),
      arbdose = case_when(
        NAMNA2 == "Candesartan" ~ arb.dose / 16,
        NAMNA2 == "Eprosartan" ~ arb.dose / 400,
        NAMNA2 == "Irbesartan" ~ arb.dose / 150,
        NAMNA2 == "Losartan" ~ arb.dose / 50,
        NAMNA2 == "Telmisartan" ~ arb.dose / 40,
        NAMNA2 == "Valsartan" ~ arb.dose / 160
      ),
      raasdose = case_when(
        raas == "no" ~ 0,
        ACEi == "yes" & arb == "no" ~ coalesce(acedose, 1),
        ACEi == "no" & arb == "yes" ~ coalesce(arbdose, 1),
        ACEi == "yes" & arb == "yes" ~ coalesce(pmax(arbdose, acedose), 1)
      ),
      raasdose_cat = case_when(
        raasdose >= 1 ~ 1,
        raasdose < 1 ~ 0
      ),
      indexYear_cat = case_when(
        indexYear <= 2005 ~ "2000-2005",
        indexYear <= 2011 ~ "2006-2011",
        indexYear <= 2016 ~ "2012-2016"
      ),
      ## Anemia
      hb_cat = case_when(
        is.na(hb) ~ NA_character_,
        gender == "female" & hb < 120 | gender == "male" & hb < 130 ~ "2.<120(f)/130(m)",
        TRUE ~ "1.>=120(f)/130(m)"
      ),
      ## Outcomes
      out_cvdeath_hfhospnum = case_when(
        cvDeath == "yes" | out_hf_hosp == "yes" ~ 1,
        TRUE ~ 0
      ),
      out_hf_hospnum = case_when(
        out_hf_hosp == "yes" ~ 1,
        TRUE ~ 0
      ),
      cvdeathnum = case_when(
        cvDeath == "yes" ~ 1,
        TRUE ~ 0
      ),
      deathnum = case_when(
        death == "yes" ~ 1,
        TRUE ~ 0
      ),
      noncvdeathnum = case_when(
        cvDeath == "no" & death == "yes" ~ 1,
        TRUE ~ 0
      ),
      fakevar = 1,
      pop1 = TRUE,
      pop2 = efgroup %in% c("rEF", "mrEF"),
      pop3 = efgroup %in% c("pEF", "mrEF"),
      pop4 = efgroup %in% c("rEF"),
      pop5 = efgroup %in% c("mrEF"),
      pop6 = efgroup %in% c("pEF")
    )
  utdata <- utdata %>%
    mutate(
      nomissing_r = rowSums(is.na(select(., !!!elvars_r))) == 0,
      nomissing_mp = rowSums(is.na(select(., !!!elvars_mp))) == 0,
      nomissing_r = case_when(
        (ACEi == "yes" & (is.na(NAMNACE) | is.na(ACEi.dose))) |
          (arb == "yes" & (is.na(NAMNA2) | is.na(arb.dose))) ~ FALSE,
        TRUE ~ nomissing_r
      ),
      nomissing = case_when(
        efgroup == "rEF" ~ nomissing_r,
        efgroup %in% c("mrEF", "pEF") ~ nomissing_mp
      )
    ) %>%
    mutate_if(is_character, factor)

  return(utdata)
}

pdata <- fixdata(pdata)
impdata <- fixdata(impdata)