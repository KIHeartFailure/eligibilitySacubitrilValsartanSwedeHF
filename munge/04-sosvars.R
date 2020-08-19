

# Create comorbidity variables from Socialstyrelsen data ------------------

comorb <- left_join(
  pdata %>% select(lopnr, date),
  patreg,
  by = "lopnr"
) %>%
  filter(discharge_date <= date)


funcCoMorb("pah1y",
  diakod = " I270",
  yearsprior = 1
)
funcCoMorb("alcoholdrug1y",
  diakod = " F10 | E52| G621| I426| K292| K700| K703| K709| T51| Z502| Z714| F11| F12| F13| F14| F15| F16| F18| F19",
  yearsprior = 1
)
funcCoMorb("acutecor3m",
  diakod = " I21| I22 | I200",
  opkod = " FNG| FNA| FNB| FNC| FND| FNE| FNF| FNH| FMA00| FMA10| FMA20| FMA96| FMC00| FMC10| FMC20| FMC96| FMD00| FMD10| FMD20| FMD30| FMD33| FMD40| FMD96| FMW96| FKA(?!32)| FKB| FKC| FKD| FKW96",
  yearsprior = 0.25
)
funcCoMorb("percon",
  diakod = " I311| I421| I422| I423| I425| I428| I429"
)
funcCoMorb("conheartdisease",
  diakod = " Q20| Q21| Q22| Q23| Q24| Q25| Q26| Q27| Q28"
)
funcCoMorb("stroke3m",
  diakod = " I60| I61| I62| I63| I64",
  yearsprior = 0.25
)
funcCoMorb("transplant_mp",
  diakod = " Z940| Z941| Z942| Z943| Z944| Z946| Z948",
  opkod = " FQA| FQB| GDG| KAS"
)
funcCoMorb("transplant_r",
  diakod = " Z941| Z943",
  opkod = " FQB"
)
funcCoMorb("pancreatic5y_mp",
  diakod = " K860| K861",
  yearsprior = 5
)
funcCoMorb("pancreatic1y_r",
  diakod = " K860| K861| K70| K71| K72| K73| K74| K75| K76| K77| B18",
  yearsprior = 1
)
funcCoMorb("pancreatic3mo_r",
  diakod = " K250| K251| K252| K253| K260| K261| K262| K263",
  yearsprior = 0.25
)
funcCoMorb("malignancy5y",
  diakod = " C(?!440B|440C|440D|440E|440S|441B|441C|441D|441E|441S|442B|442C|442D|442E|442S|443B|443C|443D|443E|443S|444B|444C|444D|444E|444S|445B|445C|445D|445E|445S|446B|446C|446D|446E|446S|447B|447C|447D|447E|447S|448B|448C|448D|448E|448S|449B|449C|449D|449E|449S)",
  yearsprior = 5
)
funcCoMorb("liver1y", diakod = " K70| K71| K72| K73| K74| K75| K76| K77| B18", yearsprior = 1)
funcCoMorb("mental1y", diakod = " F0(?!0)| F1(?!7)| F2(?!6|7)| F30| F31", yearsprior = 1)
funcCoMorb("mental_pragmatic1y", diakod = " F01| F02| F03", yearsprior = 1)
