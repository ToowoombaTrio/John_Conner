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
  
  utils::data("QLD_hourly_locations", package = "JohnConner", envir = environment())
  stations <- get("QLD_hourly_locations", envir = environment())
  
  utils::data("QLD_hourly_data", package = "JohnConner", envir = environment())
  stations <- get("QLD_hourly_data", envir = environment())
  
  for (i in seq_along(length(unique(QLD_hourly_locations$station_number))))) {
    
       j <- QLD_hourly_locations[i, 2]
       day <- QLD_hourly_data[[i]]
       station <- day[day$station_number == j, ]
       
       temp <- station[station$parameter == "AIR_TEMP_MAX", ][, c(1, 4, 6)]
       temp$TMN <- station[station$parameter == "AIR_TEMP_MIN", ][, 6]
       temp$AVG <- station[station$parameter == "AIR_TEMP", ][, 6]
       names(temp)[names(temp) == "value"] <- "TMX"
       
       # array of SILO data
       Tmax <- my_array[, "T.Max", "45025"]
       Tmin <- my_array[, "T.Min", "45025"]
       JDay <- my_array[, "Day", "45025"]
       
       df <- data.frame(Tmin, Tmax, JDay)
       
       lat <- spatial$LATITUDE[spatial$station_number == "45025"]
       
       make_hourly_temps(lat, df)
  }
       
       settings::reset(opt)
       
}
