
# Names of populations used in analysis -----------------------------------

popnames <- c(
  "rEF+mrEF+pEF",
  "rEF+mrEF",
  "mrEF+pEF",
  "rEF",
  "mrEF",
  "pEF"
)
popnamesout <- gsub("+", "_", popnames, fixed = TRUE)


# Names of variables used in analysis -------------------------------------


elvars_mp <- c(
  "age", "diuretics",
  "nyha",
  "ntProBNP", "ekg", "prevHFhosp9mo",
  "prevef40",
  "com_p_acutecor3m",
  "ACEi", "arb",
  "com_AngioOedema",
  "com_p_pah1y",
  "hb", "bmi_cat",
  "bp.sys",
  "betaBlocker", "MRA", "diuretics", "ACEi", "arb",
  "dcm",
  "com_p_percon",
  "com_p_conheartdisease",
  "com_p_stroke3m",
  "heartRate", "ekg",
  "device_cat",
  "com_p_transplant_mp",
  "com_p_mental1y",
  "com_p_mental_pragmatic1y",
  "com_p_pancreatic5y_mp",
  "com_p_liver1y",
  "MDRD_cat",
  "potassium",
  "com_p_alcoholdrug1y",
  "com_p_malignancy5y"
)

elvars_r <- c(
  "age", "betaBlocker", "ACEi", "arb",
  "nyha",
  "ntProBNP", "prevHFhosp12mo",
  "com_p_acutecor3m",
  "ACEi", "arb",
  "com_AngioOedema",
  "com_p_pah1y",
  "bp.sys",
  "com_p_stroke3m",
  "device_cat",
  "com_p_transplant_r",
  "com_p_pancreatic1y_r", "com_p_pancreatic3mo_r",
  "MDRD_cat",
  "potassium"
)

tabvars <- c(
  "gender", "age", "followUp.location", "followUp.HF",
  "indexYear_cat", "scb.marital.status",
  "scb.education_cat", "scb.income_cat",
  "durationHF", "prevHFhosp9mo", "prevHFhosp12mo", "lvef", "prevef40", "nyha",
  "ekg",
  "bp.sys", "bp.dia", "heartRate", "MDRD_cat", "hb",
  "hb_cat",
  "ntProBNP", "potassium",
  "raas", "MRA", "diuretics", "nitrates", "asaTRC", "anticoagulantia",
  "statins", "betaBlocker", "digoxin",
  "smoking",
  "bmi_cat",
  "hypertension",
  "diabetes",
  "com_IHD",
  "com_MI",
  "com_p_acutecor3m",
  "com_PVD",
  "com_stroke_tia",
  "com_p_stroke3m",
  "com_pci_cabg",
  "fibrillation",
  "com_Valvular",
  "heartValveSurgery",
  "com_COPD",
  "com_p_liver1y",
  "com_p_malignancy5y",
  "com_AngioOedema",
  "com_p_pah1y",
  "com_p_alcoholdrug1y",
  "com_p_percon",
  "com_p_conheartdisease",
  "com_p_transplant_mp",
  "com_p_transplant_r",
  "com_p_pancreatic5y_mp",
  "com_p_pancreatic1y_r",
  "com_p_pancreatic3mo_r",
  "com_p_mental1y",
  "com_p_mental_pragmatic1y",
  "device_cat",
  "dcm"
)
