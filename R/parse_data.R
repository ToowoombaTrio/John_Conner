#' Parse 2015/16 Meteorological Verification Data
#'
#'This function automates parsing of temperature and precipitation for
#'Queensland weather stations.
#'
#' @details
#'Details about the resulting files go here
#'
#' The CSV or ESRI format shapefile in the respective year-directory
#' will contain the following fields/values:
#' 
#' @examples
#' \dontrun{}
#'
#' @importFrom foreach %dopar%
#' @importFrom foreach %do%
#' @importFrom data.table :=
#'
#' @export
#'

fit_curves <- function(QLD_hourly_data) {
  opt <- settings::options_manager(warn = 2, timeout = 300,
                                   stringsAsFactors = FALSE)
  
  utils::data("QLD_SILO_and_hourly_stations", package = "JohnConner",
              envir = environment())
  QLD_SILO_and_hourly_stations <- get("QLD_SILO_and_hourly_stations",
                                      envir = environment())
  
  utils::data("QLD_hourly_data", package = "JohnConner", envir = environment())
  QLD_hourly_data <- get("QLD_hourly_data", envir = environment())
  
  for (i in seq_along(length(unique(QLD_SILO_and_hourly_stations[, 2])))) {
       j <- QLD_SILO_and_hourly_stations[i, 2]
       station <- QLD_hourly_data[[i]]
       station <- day[day$station_number == j, ]
       
       temp <- station[station$parameter == "AIR_TEMP_MAX", ][, c(1, 4, 6)]
       temp$TMN <- station[station$parameter == "AIR_TEMP_MIN", ][, 6]
       temp$AVG <- station[station$parameter == "AIR_TEMP", ][, 6]
       names(temp)[names(temp) == "value"] <- "TMX"
       
       # access array of SILO data ---------------------------------------------
       Tmax <- my_array[, "T.Max", paste(j)]
       Tmin <- my_array[, "T.Min", paste(j)]
       JDay <- my_array[, "Day", paste(j)]
       
       df <- data.frame(Tmin, Tmax, JDay)
       
       lat <- spatial$LATITUDE[spatial$station_number == j]
       
       # Calculate hourly temps from SILO daily data ---------------------------
       SILO_hourly <- make_hourly_temps(lat, df)
  }
       
       settings::reset(opt)
       
}
