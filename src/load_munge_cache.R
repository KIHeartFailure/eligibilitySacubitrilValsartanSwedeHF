# 1. Set options in config/global.dcf
# 2. Load packages listed in config/global.dcf
# 3. Import functions and code in lib directory
# 4. Load data in data directory
# 5. Run data manipulations in munge directory

ProjectTemplate::reload.project(
    reset = TRUE,
    data_loading = TRUE,
    munging = TRUE, 
    cache_loaded_data = FALSE
) 

ProjectTemplate::cache("popnames")
ProjectTemplate::cache("popnamesout")
ProjectTemplate::cache("elvars_mp")
ProjectTemplate::cache("elvars_r")
ProjectTemplate::cache("tabvars")
ProjectTemplate::cache("flow")
ProjectTemplate::cache("cm.out")
ProjectTemplate::cache("pdata")
ProjectTemplate::cache("imp")
ProjectTemplate::cache("impdata")
ProjectTemplate::cache("impvars")
