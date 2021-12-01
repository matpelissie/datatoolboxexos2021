#################################
# 30/11/2021 mathieu.pelissie@ens-lyon.fr
#
# github.R
#
# github functions
#
#################################

usethis::create_github_token() # create token
usethis::edit_r_profile()
options(usethis.protocol="ssh")
usethis::use_github() # run once
usethis::use_description()
