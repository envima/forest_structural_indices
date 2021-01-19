#!/usr/bin/env Rscript


# get latest version of MOFgeoDB
git2r::clone("https://github.com/MarburgOpenForest/MOFGeoDB.git", local_path = paste0(envrmt$data_tmp, "/MOFGeoDB"))
envrmt$MOFGeoDB_path = paste0(envrmt$data_tmp, "/MOFGeoDB/MOFgeoDB.sqlite")


# load current tree layer and overwrite it in NatGeoDB and Meta-Treestructure
t = sf::st_read(dsn = envrmt$MOFGeoDB_path , layer = "vw_tree_living")

# join with useful tree species information
lut_specis = st_read(envrmt$MOFGeoDB_path, "lut_tree_species")
t = dplyr::left_join(t, lut_specis[,1:2], by = "species_id")

# clean up columns
t = t[,c("tree_id", "easting", "northing", "species_code", "dbh", "socialposition", "geometry")]

# write out as Level 0 data
dir.create(paste0(envrmt$level0, "/tree_positions"))
sf::st_write(t, paste0(envrmt$level0, "/tree_positions/tree_positions.gpkg"), overwrite = TRUE, append = FALSE)

# remove MOFGeoDB
unlink(envrmt$MOFGeoDB, recursive = TRUE)

