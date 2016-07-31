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
  ggplot2::ggplot(BoM_SILO_data, ggplot2::aes(x = SILO_TMP, y = BoM_TMP)) +
    ggplot2::stat_binhex() +
    viridis::scale_fill_viridis(alpha = 1, begin = 0, end = 1, discrete = FALSE,
                                option = "D", direction = 1) +
    ggplot2::geom_abline(slope = 1, colour = "white") +
    ggplot2::xlab("SILO Downscaled (Predicted, ˚C)") +
    ggplot2::ylab("BoM Hourly (Actual Values, ˚C)") +
    ggplot2::ggtitle("Density of Predicted\nVersus Actual Values") +
    ggplot2::theme(text = ggplot2::element_text(size = 5))
}
