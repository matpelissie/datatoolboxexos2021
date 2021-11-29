###############################################
#'29/11/2021, mathieu.pelissie@ens-lyon.fr
#'
#'make.R
#'
#'script pour l'execution du projet entier
#'
################################################

# deps install
devtools::install_deps()

# load functions
# devtools::load_all()
source(here::here("R","data_wildfinder.R"))

# unlink("outputs/exo_dplyr_hist_mams.png") # remove

# run exodplyr
source(here::here("exercices","exo_dplyr.R"))

