Select QLD Only Stations and Hourly Data
================

``` r
library(foreach)
```

``` r
QLD_hourly_locations <- readr::read_csv("BoM_ETA_20150501-20160430/spatial/StationData.csv")
QLD_hourly_locations <- QLD_hourly_locations[QLD_hourly_locations$REGION == "QLD", ]
devtools::use_data(QLD_hourly_locations, overwrite = TRUE,
                   compress = "bzip2")
```

    ## Saving QLD_hourly_locations as QLD_hourly_locations.rda to /Users/asparks/Development/JohnConner/data

``` r
cl <- parallel::makeCluster(parallel::detectCores() - 2)
doParallel::registerDoParallel(cl)
day_files <- list.files("BoM_ETA_20150501-20160430/obs/", full.names = TRUE)
QLD_hourly_data <- vector(mode = "list")
f <- NULL
itx <- iterators::iter(day_files)

QLD_hourly_data <- (foreach::foreach(f = itx) %dopar% {
  day <- read.csv(f)
  
  day[, 4] <- as.Date(as.POSIXct(day[, 4], origin = "1970-01-01"))
  day[, 5] <- as.Date(as.POSIXct(day[, 5], origin = "1970-01-01"))
  
  # Join with QLD_hourly_locations metadata
  QLD_hourly_data[[f]] <- day[day$station_number %in% QLD_hourly_locations$station_number == TRUE, ]
})

# Combine list into single data frame
QLD_hourly_data <- plyr::rbind.fill(QLD_hourly_data)

# Write list into .rda file for use with R package
devtools::use_data(QLD_hourly_data, overwrite = TRUE, compress = "bzip2")
```

    ## Saving QLD_hourly_data as QLD_hourly_data.rda to /Users/asparks/Development/JohnConner/data
