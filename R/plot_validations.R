#' Visualise downscaled data
#'
#'Function that returns Root Mean Square Error (RMSE)
#'
#' @details
#'Details go here
#' 
#' @examples
#' \dontrun{}
#'
#'
#' @export
#'

merged <- NULL
ggplot2::ggplot(merged, ggplot2::aes(x = SILO_TMP, y = BoM_TMP)) +
  ggplot2::stat_binhex() +
  ggplot2::geom_abline(slope = 1, colour = "white")
