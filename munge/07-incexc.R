funcIE(age >= 50 | is.na(age),
  age >= 18 | is.na(age),
  2,
  inex = "in", pragscenie = TRUE
)


funcIE(diuretics == "yes" | is.na(diuretics),
  betaBlocker == "yes" & raasdose_cat == 1,
  4,
  inex = "in"
)

funcIE(nyha %in% c("NYHA-II", "NYHA-III", "NYHA-IV") | is.na(nyha),
  nyha %in% c("NYHA-II", "NYHA-III", "NYHA-IV") | is.na(nyha),
  5,
  pragscenie = TRUE, inex = "in"
)


funcIE(crit_ntprobnp_mp == "yes" | is.na(crit_ntprobnp_mp),
  crit_ntprobnp_r == "yes" | is.na(crit_ntprobnp_r),
  7,
  pragscenie = TRUE, inex = "in"
)

funcIE(
  !prevef40 == "yes" | is.na(prevef40),
  fakevar == 1,
  1
)

funcIE(
  !com_p_acutecor3m == "yes",
  !com_p_acutecor3m == "yes",
  2
)

funcIE(
  !(arb == "yes" & ACEi == "yes") | is.na(arb) | is.na(ACEi),
  !(arb == "yes" & ACEi == "yes") | is.na(arb) | is.na(ACEi),
  5
)

funcIE(
  !com_AngioOedema == "yes",
  !com_AngioOedema == "yes",
  7,
  pragscenie = TRUE
)

funcIE(
  !com_p_pah1y == "yes",
  fakevar == 1,
  "8. a",
  pragscenie = TRUE
)

funcIE(
  !com_p_pah1y == "yes",
  !com_p_pah1y == "yes",
  "8. a"
)

funcIE(
  !hb / 10 < 10 | is.na(hb),
  fakevar == 1,
  "8. b"
)

funcIE(
  !bmi_cat == "3.>40" | is.na(bmi_cat),
  fakevar == 1,
  "8. c"
)

funcIE(
  !bp.sys >= 180 | is.na(bp.sys),
  fakevar == 1,
  "9. a",
)

funcIE(
  !crit_SBP_Adrugs == "yes" | is.na(crit_SBP_Adrugs),
  fakevar == 1,
  "9. b",
  noie = TRUE
)

funcIE(
  !crit_SBP_AdrugsCB == "yes" | is.na(crit_SBP_AdrugsCB),
  fakevar == 1,
  "9. b"
)

funcIE(
  !bp.sys < 110 | is.na(bp.sys),
  !bp.sys < 100 | is.na(bp.sys),
  "9. c",
  pragscenie = TRUE
)

funcIE(
  !dcm == "yes" | is.na(dcm),
  fakevar == 1,
  11
)

funcIE(
  !com_p_percon == "yes",
  fakevar == 1,
  13,
  pragscenie = TRUE
)

funcIE(
  !com_p_conheartdisease == "yes",
  fakevar == 1,
  14
)

funcIE(
  !com_p_stroke3m == "yes",
  !com_p_stroke3m == "yes",
  16
)

funcIE(
  !(heartRate > 110 & ekg == "Atrial fibrillation") | is.na(heartRate) | is.na(ekg),
  fakevar == 1,
  18
)

funcIE(
  !device_cat %in% c("CRT", "CRT_D") | is.na(device_cat),
  !device_cat %in% c("CRT", "CRT_D") | is.na(device_cat),
  19
)

funcIE(
  !com_p_transplant_mp == "yes",
  !com_p_transplant_r == "yes",
  20
)

funcIE(
  !com_p_mental1y == "yes",
  fakevar == 1,
  21
)

funcIE(
  !com_p_mental_pragmatic1y == "yes",
  fakevar == 1,
  21,
  pragscenie = TRUE
)

funcIE(
  !com_p_pancreatic5y_mp == "yes",
  !(com_p_pancreatic1y_r == "yes" | com_p_pancreatic3mo_r == "yes"),
  22
)

funcIE(
  !com_p_liver1y == "yes",
  fakevar == 1,
  23
)

funcIE(
  !MDRD_cat == "1.<30" | is.na(MDRD_cat),
  !MDRD_cat == "1.<30" | is.na(MDRD_cat),
  "24. a",
  pragscenie = TRUE
)

funcIE(
  !potassium > 5.2 | is.na(potassium),
  !potassium > 5.2 | is.na(potassium),
  "26. a"
)


funcIE(
  !(com_p_alcoholdrug1y == "yes"),
  fakevar == 1,
  29
)

funcIE(
  !com_p_malignancy5y == "yes",
  fakevar == 1,
  31
)
