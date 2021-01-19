# create plots


fsi = stack(paste0(envrmt$level1, "/fsi.grd"))


fsi  = raster::trim(fsi)

png(filename = paste0(envrmt$figures, "/fsi_raster.png"), width = 20, height = 20, units = "cm", res = 300)
plot(fsi, col = viridis::viridis(10))
dev.off()

