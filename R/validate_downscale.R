#' Validate Downscaling Methods
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
#'
#' @export
#'

validate_downscale <- function() {
  opt <- settings::options_manager(warn = 2, timeout = 300,
                                   stringsAsFactors = FALSE)
  
  utils::data("QLD_SILO_and_hourly_stations", package = "JohnConner",
              envir = environment())
  QLD_SILO_and_hourly_stations <- get("QLD_SILO_and_hourly_stations",
                                      envir = environment())
  
  utils::data("QLD_hourly_data", package = "JohnConner", envir = environment())
  QLD_hourly_data <- get("QLD_hourly_data", envir = environment())
  
  utils::data("QLD_hourly_locations", package = "JohnConner",
              envir = environment())
  QLD_hourly_locations <- get("QLD_hourly_locations",
                              envir = environment())
  
  merged <- vector(mode = "list")
  
  itx <- iterators::iter(unique(QLD_SILO_and_hourly_stations[, 2]))
  
  cl <- parallel::makeCluster(parallel::detectCores() - 2)
  doParallel::registerDoParallel(cl)
  
  merged <- as.data.frame(
    data.table::rbindlist(
      foreach::foreach(i = itx) %dopar% 
        for (i in 1:length(unique(QLD_SILO_and_hourly_stations[, 2]))){
        j <- QLD_SILO_and_hourly_stations[i, 2]
        
        station <- subset(QLD_hourly_data, station_number == j)
        temp <- station[station$parameter == "AIR_TEMP", ][, c(1, 4, 6)]
        temp[, 2] <- lubridate::yday(temp[, 2])
        names(temp) <- c("station_number", "JDay", "BoM_TMP")
        
        # access array of SILO data ---------------------------------------------
        Tmax <- my_array[, "T.Max", paste(j)]
        Tmin <- my_array[, "T.Min", paste(j)]
        JDay <- my_array[, "Day", paste(j)]
        
        df <- data.frame(Tmin, Tmax, JDay)
        
        lat <- QLD_hourly_locations$LATITUDE[QLD_hourly_locations$station_number == j]
        
        # Calculate hourly temps from SILO daily data ---------------------------
        SILO_hourly <- chillR::make_hourly_temps(lat, df)
        SILO_hourly <- tidyr::gather(SILO_hourly, Hour, SILO_TMP,
                                     Hour_1:Hour_24)[, -4]
        
        merged[[i]] <- plyr::join(temp, SILO_hourly, type = "left")
        }
        parallel::stopCluster(cl)
        
      }
    )
  )
  settings::reset(opt)
  
}
