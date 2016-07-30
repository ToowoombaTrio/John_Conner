Select QLD Only Stations and Hourly Data
================

``` r
library(foreach)
```

Import Station Spatial Data
---------------------------

``` r
spatial <- readr::read_csv("BoM_ETA_20150501-20160430/spatial/StationData.csv")
spatial <- spatial[spatial$REGION == "QLD", ]
devtools::use_data(spatial, overwrite = TRUE, compress = "bzip2")
```

    ## Saving spatial as spatial.rda to /Users/asparks/Development/JohnConner/data

``` r
cl <- parallel::makeCluster(parallel::detectCores() - 2)
doParallel::registerDoParallel(cl)
day_files <- list.files("BoM_ETA_20150501-20160430/obs/", full.names = TRUE)
QLD_list <- vector(mode = "list")
f <- NULL
itx <- iterators::iter(day_files)

QLD_list <- (foreach::foreach(f = itx) %dopar% {
  day <- read.csv(f)
  
  day[, 4] <- as.Date(as.POSIXct(day[, 4], origin = "1970-01-01"))
  day[, 5] <- as.Date(as.POSIXct(day[, 5], origin = "1970-01-01"))
  
  # Join with spatial metadata
  QLD_list[[f]] <- day[day$station_number %in% spatial$station_number == TRUE, ]
})

devtools::use_data(QLD_list, overwrite = TRUE, compress = "bzip2")
```

    ## Saving QLD_list as QLD_list.rda to /Users/asparks/Development/JohnConner/data
