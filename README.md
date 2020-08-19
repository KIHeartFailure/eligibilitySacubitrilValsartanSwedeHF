# R code for the project Eligibility PARAGON SwedeHF

The aim of this R code is to be transparant and document the data handling 
performed for the project Eligibility PARAGON in SwedeHF. 
## Language 

English (sprinkled with Swedish). 

## Data

The data consists of Swedish individual patient data and is not public, 
and therefore no data is stored in this repository. 

## Instructions

The project uses the R package projectTemplate, http://projecttemplate.net/ and 
is structured (and run) accordingly. Renv, 
https://rstudio.github.io/renv/articles/renv.html, is used for management of package dependencies.

Since the data is not available the code can not be run as is. 

Workflow: 

1. Run src/load_munge_cache.R or set loading and munging options in ProjectTemplate::reload.project() to TRUE in 
reports/Statistical_report_PARAGONSwedeHF.Rmd

2. Knit reports/Statistical_report_PARAGONSwedeHF.Rmd

## Publication

https://doi.org/10.1111/joim.13165
