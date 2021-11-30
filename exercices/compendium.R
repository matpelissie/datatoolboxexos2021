###############################################
# 29/11/2021, mathieu.pelissie@ens-lyon.fr
#
# compendium_fct.R
#
# main functions to create package-like compendium
#
################################################

rrtools::use_compendium("../datatoolboxexos2021/", open=FALSE)

usethis::use_r("data_wildfinder") # create R paired files
dir.create("R") # create R directory at root as removed by use_r

usethis::use_package("here") # add package/dependency as imports in DESCRIPTION

rrtools::use_readme_rmd() # creates README files with default frontmatter to fill in

devtools::install_deps() # install all dependencies in imports in the DESCRIPTION

devtools::document() # fill in package NAMESPACE

devtools::load_all() # charger tous les fichiers et fonctions dans /R
source("R/data_wildfinder.R") # exécuter tout le code du script

