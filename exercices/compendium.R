rrtools::use_compendium("../datatoolboxexos2021/", open=FALSE)
dir.create("R")

library(usethis)
usethis::use_r("data_wildfinder")
usethis::use_package("here")

rrtools::use_readme_rmd()

devtools::install_deps()
devtools::document()

devtools::load_all() # charger tous les fichiers et fonctions dans /R
source("R/data_wildfinder.R") # exécuter tout le code du/des fichiers


dir.create("exercices")
dir.create("outputs")
