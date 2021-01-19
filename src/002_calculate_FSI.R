# calculate FSI for every grid cell

# clean trees

trees = st_read(paste0(envrmt$tree_positions, "/tree_positions.gpkg"))
trees = na.omit(trees)

g = raster(paste0(envrmt$level0, "/grid10m.tif"))


# extract cell value to points (to form groups based on 10m pixel)
trees$cellnumber = raster::extract(g, trees)


fsi = trees %>%
  dplyr::group_by(cellnumber) %>%
  summarise(fsi_function(dbh, species_code)) %>%
  st_drop_geometry()

# create raster layers


fsi_raster = list()
for(i in seq(2, ncol(fsi))){
  fsi_r = g
  fsi_r[!fsi_r %in% fsi$cellnumber] = NA
  # reclassification matrix
  m = matrix(data = c(pull(fsi, "cellnumber"), pull(fsi, i)), ncol = 2)
  fsi_raster[[colnames(fsi[i])]] = raster::reclassify(fsi_r, rcl = m)
}
fsi_raster = stack(fsi_raster)

# output
writeRaster(fsi_raster, paste0(envrmt$level1, "/fsi.grd"), overwrite = TRUE)

