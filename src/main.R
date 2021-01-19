#' Main control script
#'
#' @description Use this script for controlling the processing.
#'
#' @author [Marvin], [marvin.ludwig@geo.uni-marburg.de]
#'

library(envimaR)
if (Sys.info()[["nodename"]] == "marvinpc") {
  root_folder = "/home/marvin/casestudies/forest_structural_indices/"
}
source(paste0(root_folder, "/src/functions/000_setup.R"))


# set control flags
update_trees = FALSE
calculate_fsi = FALSE
create_plot = FALSE

#---------------------------------
# execute scripts
if(update_trees) source(paste0(envrmt$src, "/001_update_trees.R"))

if(calculate_fsi) source(paste0(envrmt$src, "/002_calculate_FSI.R"))

if(create_plot) source(paste0(envrmt$src), "/003_create_plot.R")
