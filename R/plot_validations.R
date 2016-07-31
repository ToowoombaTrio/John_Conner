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
plot_density <- function(BoM_SILO_data) {
  BoM_SILO_data <- NULL
  
  ggplot2::ggplot(BoM_SILO_data, ggplot2::aes(x = SILO_TMP, y = BoM_TMP)) +
    ggplot2::stat_binhex() +
    ggplot2::geom_abline(slope = 1, colour = "white") +
    ggplot2::xlab("SILO Downscaled (Predicted, ˚C)") +
    ggplot2::ylab("BoM Hourly (Actual Values, ˚C)") +
    ggplot2::ggtitle("Density of Predicted Versus Actual Values")
}
