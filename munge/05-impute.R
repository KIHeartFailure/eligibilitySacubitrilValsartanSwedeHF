

# Impute missing values ---------------------------------------------------

set.seed(45345)

impvars <- pdata %>%
  select(
    efgroup, gender, age, followUp.location, followUp.HF, durationHF, bmi_cat, smoking,
    scb.marital.status, scb.education_cat, scb.income_cat,
    indexYear, ekg, nyha,
    bp.sys, heartRate, MDRD_cat, hb, logntProBNP, potassium,
    ACEi, arb, MRA, diuretics, nitrates, asaTRC, anticoagulantia,
    statins, betaBlocker, digoxin,
    hypertension, diabetes,
    com_COPD,
    com_stroke_tia,
    com_p_alcoholdrug1y,
    com_MI,
    com_IHD,
    com_PVD,
    com_p_malignancy5y,
    com_Valvular,
    com_p_mental1y,
    device_cat, dcm
  )


imp <- mice(impvars, m = 1)
impdata <- mice::complete(imp, 1)


## vars not in imputation model but needed for eligibilty criteria evaluation
impdata <- cbind(impdata, pdata %>% select(
  cvDeath, death, out_hf_hosp,
  com_AngioOedema, com_p_mental_pragmatic1y, com_p_transplant_r, com_p_transplant_mp,
  com_p_pancreatic5y_mp, com_p_pancreatic1y_r, com_p_pancreatic3mo_r,
  com_p_acutecor3m, com_p_percon, com_p_pah1y,
  com_p_liver1y, com_p_stroke3m, com_p_conheartdisease,
  prevHFhosp9mo, prevHFhosp12mo, prevef40, lopnr,
  NAMNACE, NAMNA2, arb.dose, ACEi.dose
))
