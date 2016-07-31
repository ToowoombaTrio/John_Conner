#' Validate Downscaling Methods
#'
#'This function automates parsing of temperature and precipitation for
#'Queensland weather stations.
#'
#' @details
#'An R function which formats Australian Bureau of Meteorology (BoM) hourly
#'weather data and Queensland's Scientific Information for Land Owners (SILO)
#'daily weather data for validation of temporal downscaling of SILO temperature
#'data to hourly values.
#' 
#' @examples
#' \dontrun{downscale()}
#'
#' @importFrom foreach %dopar%
#'
#' @export
#'
downscale <- function() {
  
  station_number <- NULL
  Hour <- NULL
  SILO_TMP <- NULL
  BoM_TMP <- NULL
  Hour_01 <- NULL
  Hour_24 <- NULL
  
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
  
  utils::data("SILO_array", package = "JohnConner", envir = environment())
  SILO_array <- get("SILO_array", envir = environment())
  i <- NULL
  j <- NULL
  temp2 <- vector(mode = "list")
  
  itx <- iterators::iter(1:nrow(QLD_SILO_and_hourly_stations))
  
  cl <- parallel::makeCluster(2)
  doParallel::registerDoParallel(cl)
  
  merged <- as.data.frame(data.table::rbindlist(
      foreach::foreach(i = itx) %dopar% {
        j <- QLD_SILO_and_hourly_stations[i, 2]
        
        station <- subset(QLD_hourly_data, station_number == paste(j))
        temp <- station[station$parameter == "AIR_TEMP", ][, c(1, 4, 6)]
        temp[, 2] <- lubridate::yday(temp[, 2])
        temp[, 4] <- rep(c("Hour_01", "Hour_02", "Hour_03", "Hour_04", "Hour_05",
                       "Hour_06", "Hour_07", "Hour_08", "Hour_09", "Hour_10",
                       "Hour_11", "Hour_12", "Hour_13", "Hour_14", "Hour_15",
                       "Hour_16", "Hour_17", "Hour_18", "Hour_19", "Hour_20",
                       "Hour_21", "Hour_22", "Hour_23", "Hour_24"),
                       length.out = nrow(temp))
        names(temp) <- c("station_number", "JDay", "BoM_TMP", "Hour")
        
        
        # access array of SILO data ---------------------------------------------
        Tmax <- SILO_array[, "T.Max", paste(j)]
        Tmin <- SILO_array[, "T.Min", paste(j)]
        JDay <- SILO_array[, "Day", paste(j)]
        
        df <- data.frame(Tmin, Tmax, JDay)
        
        lat <- QLD_hourly_locations$LATITUDE[QLD_hourly_locations$station_number == paste(j)]
        
        # Calculate hourly temps from SILO daily data ---------------------------
        SILO_hourly <- chillR::make_hourly_temps(lat, df)
        SILO_hourly$station_number <- as.character(rep(j, nrow(SILO_hourly)))
        names(SILO_hourly) <- c("Tmin", "Tmax", "JDay", "Hour_01", "Hour_02",
                                "Hour_03", "Hour_04", "Hour_05", "Hour_06",
                                "Hour_07", "Hour_08", "Hour_09", "Hour_10",
                                "Hour_11", "Hour_12", "Hour_13", "Hour_14",
                                "Hour_15", "Hour_16", "Hour_17", "Hour_18",
                                "Hour_19", "Hour_20", "Hour_21", "Hour_22",
                                "Hour_23", "Hour_24", "station_number")
        SILO_hourly <- tidyr::gather(SILO_hourly, Hour, SILO_TMP,
                                     Hour_01:Hour_24)
        SILO_hourly <- SILO_hourly[, -c(1:2)]
        
        SILO_hourly <- plyr::arrange(SILO_hourly, JDay, Hour)
        temp <- plyr::arrange(temp, JDay, Hour)
        
        temp2[[i]] <- plyr::join(temp, SILO_hourly, 
                                               by = c("station_number", "JDay",
                                                      "Hour"), type = "left")
        
      }
    )
  )
  parallel::stopCluster(cl)
  settings::reset(opt)
  return(merged)
  }
