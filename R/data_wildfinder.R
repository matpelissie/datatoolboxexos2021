
#' Import WWF Species Data
#'
#' @return A tibble containing species ID & taxonomy
#' @export
#'
data_sp_list <- function() {

  dat <- readr::read_csv(
    here::here("data", "wwf-wildfinder", "wildfinder-mammals_list.csv")
  )

  return(dat)
}


#' Import WWF ecoregions data
#'
#' @return A tibble containing ecoregions ID & geographical info
#' @export
#'
data_eco_list <- function() {

  dat <- readr::read_csv(
    here::here("data", "wwf-wildfinder", "wildfinder-ecoregions_list.csv")
  )

  return(dat)
}

#' Import WWF species-coregions data
#'
#' @return A tibble linking species IDs to ecoregions IDs
#' @export
#'
data_sp_eco <- function() {

  dat <- readr::read_csv(
    here::here("data", "wwf-wildfinder", "wildfinder-ecoregions_species.csv")
  )

  return(dat)
}
