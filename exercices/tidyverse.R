###############################################
#'30/11/2021, mathieu.pelissie@ens-lyon.fr
#'
#'tidyverse.R
#'
#'script pour tidyverse
#'
################################################

library(tidyverse)
citations_raw <- readr::read_csv('https://raw.githubusercontent.com/oliviergimenez/intro_tidyverse/master/journal.pone.0166570.s001.CSV')

citations_raw %>%
  dplyr::rename(
    journal      = 'Journal identity',
    impactfactor = '5-year journal impact factor',
    pubyear      = 'Year published',
    colldate     = 'Collection date',
    pubdate      = 'Publication date',
    nbtweets     = 'Number of tweets',
    woscitations = 'Number of Web of Science citations') %>%
  dplyr::mutate(journal = as.factor(journal)) -> citations

citations %>%
  tidyr::separate(pubdate, c('month', 'day', 'year'), sep = '/')

citations %>%
  dplyr::mutate(
    pubdate  = lubridate::mdy(pubdate),
    colldate = lubridate::mdy(colldate),
    pubyear2 = lubridate::year(pubdate))

citations %>%
  dplyr::filter(stringr::str_detect(Authors, 'et al')) %>%
  dplyr::select(Authors)

citations %>%
  dplyr::count(journal, wt = nbtweets, sort = TRUE)

citations %>%
  dplyr::group_by(journal) %>%
  dplyr::summarize(dplyr::across(where(is.numeric), mean)) %>%
  head()

citations %>%
  ggplot() +
  aes(x = nbtweets, y = woscitations, color = journal) +
  geom_point()

citations_ecology <- citations %>%
  mutate(journal = str_to_lower(journal)) %>% # all journals names lowercase
  filter(journal %in%
           c('journal of animal ecology','journal of applied ecology','ecology')) # filter
citations_ecology


citations_ecology %>%
  ggplot() +
  aes(x = nbtweets) +
  geom_histogram(fill = "orange", color = "brown") +
  labs(x = "Number of tweets",
       y = "Count",
       title = "Histogram of the number of tweets") +
  facet_wrap(vars(journal))

citations %>%
  count(journal) %>%
  ggplot() +
  aes(x = journal, y = n) +
  geom_col()

#################################
# Exercice tidyverse
#################################

source(here::here("R","data_wildfinder.R"))

wildfinder_mammals_list <- data_sp_list()
wildfinder_ecoregions_list <- data_eco_list()
wildfinder_ecoregions_species <- data_sp_eco()

wildfinder_mammals_list %>%
  dplyr::filter(family=="Ursidae") %>%
  dplyr::filter(sci_name!="Ursus malayanus") %>%
  dplyr::left_join(wildfinder_ecoregions_species, by="species_id") %>%
  dplyr::left_join(wildfinder_ecoregions_list, by="ecoregion_id") -> ursidae_wildfinder

ursidae_wildfinder %>%
  dplyr::group_by(common) %>%
  dplyr::summarise(n_realm = n_distinct(realm)) -> n_realm

ursidae_wildfinder %>%
  dplyr::group_by(common) %>%
  dplyr::summarise(n_biome = n_distinct(biome)) -> n_biome

ursidae_wildfinder %>%
  dplyr::group_by(common) %>%
  dplyr::summarise(n_ecoregion = dplyr::n_distinct(ecoregion)) -> n_ecoregion

n_realm %>%
  dplyr::left_join(n_biome) %>%
  dplyr::left_join(n_ecoregion) -> urs_tot

urs_tot %>%
  pivot_longer(-common) -> urs_tot_long

ggplot(urs_tot_long)+
  aes(x=common, y=value, fill=name)+
  geom_col()+
  facet_wrap(vars(name))

#################################
# Exercice ggplot2
#################################

library(tidyverse)
pantheria <- readr::read_delim("data/pantheria-traits/PanTHERIA_1-0_WR05_Aug2008.txt", delim = "\t")

pantheria %>%
  dplyr::mutate(order = as.factor(MSW05_Order),
                family = as.factor(MSW05_Family)) %>%
  dplyr::rename(body_mass = "5-1_AdultBodyMass_g",
                disp_age = "7-1_DispersalAge_d",
                gestation = "9-1_GestationLen_d",
                home_range = "22-2_HomeRange_Indiv_km2",
                litter_size = "16-1_LittersPerYear",
                longevity = "17-1_MaxLongevity_m") %>%
  dplyr::select(family, order, longevity, home_range, litter_size) %>%
  na_if(-999) -> pantheria

pantheria %>%
  dplyr::count(family)

pantheria %>%
  dplyr::count(order)

pantheria %>%
  dplyr::filter(!is.na(home_range)) %>%
  dplyr::group_by(family) %>%
  dplyr::summarise(m = mean(home_range), sd = sd(home_range), n = n())

pantheria %>%
  dplyr::group_by(family) %>%
  dplyr::mutate(n = n()) %>%
  dplyr::filter(n>100) %>%

  ggplot()+
  aes(x = fct_reorder(family, n), y = n)+
  geom_col()+
  coord_flip()+
  xlab("family")+
  ylab("Number of observations")

pantheria %>%
  dplyr::filter(!is.na(litter_size) & !is.na(longevity)) %>%
  dplyr::group_by(family) %>%
  dplyr::mutate(n=n()) %>%
  dplyr::mutate(longevity = longevity / 12) %>%
  dplyr::filter(n > 10) %>%

ggplot() +
  aes(x = longevity, y = litter_size, col = family) + # scatter plot
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) + # se = TRUE to add confidence intervals
  xlab("Longevity") + # add label for X axis
  ylab("Litter size") + # add label for Y axis
  ggtitle("Scatterplot") + # add title
  facet_wrap(~ family, nrow = 3)
