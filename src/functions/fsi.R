#' Calculate forest structural indices
#' @description Forest structural indices for dplyr::summarise
#'
#' @param dbh column name of diameter at breast height
#' @param species column name of tree species
#'
#' @return
#'
#' @author Marvin Ludwig
#'
#' @export

#




fsi_function = function(dbh, species){
  tibble(stem_number = length(dbh),
         basal_area = sum(pi*(dbh/2)**2),
         dbh_sd = sd(dbh),
         dbh40 = sum(dbh > 0.4),
         species_richness = length(unique(species)))
}
