#' Visualise fit of downscaled data
#'
#'Function that creates a hexbin density graph of observed versus predicted
#'hourly values.
#'
#' @param BoM_SILO_data Data object generated from using \code{downscale} to
#' generate hourly downscaled weather data from daily SILO data along with BoM
#' hourly data for validation
#' @examples
#' \dontrun{plot_density(BoM_SILO_data)}
#'
#' @export
#'
plot_density <- function(BoM_SILO_data) {
  SILO_TMP <- BoM_SILO_data$SILO_TMP
  BoM_TMP <- BoM_SILO_data$BOM_TMP
  ggplot2::ggplot(BoM_SILO_data, ggplot2::aes(x = SILO_TMP, y = BoM_TMP)) +
    ggplot2::stat_binhex() +
    viridis::scale_fill_viridis(alpha = 1, begin = 0, end = 1, discrete = FALSE,
                                option = "D", direction = 1) +
    ggplot2::geom_abline(slope = 1, colour = "white") +
    ggplot2::xlab("SILO Downscaled (Predicted, degrees C)") +
    ggplot2::ylab("BoM Hourly (Actual Values, degrees C)") +
    ggplot2::ggtitle("Density of Predicted\nVersus Actual Values") +
    ggplot2::theme(text = ggplot2::element_text(size = 5))
}
