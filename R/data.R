#'QLD_hourly_data
#'
#' @format A list of 366 data frame objects, each containing one day of hourly
#' weather observations from 2015-04-30 to 2016-04-29
#' \describe{
#'   \item{station_number}{}
#'   \item{area_code}{}
#'   \item{parameter}{}
#'   \item{valid_start}{}
#'   \item{valid_end}{}
#'   \item{value}{}
#'   \item{unit}{}
#'   \item{statistic}{}
#'   \item{instantaneous}{}
#'   \item{level}{}
#'   \item{qc_valid_minutes}{}
#'   \item{qc_valid_minutes_start}{}
#'   \item{qc_valid_mintues_end}{}
#' }
#' 
"QLD_hourly_data"

#' QLD_hourly_locations
#' @format A data frame with 293 observations of 4 variables:
#' \describe{
#' \item{WMO_NUM}{}
#' \item{station_number}{}
#' \item{station_name}{}
#' \item{LATITUDE}{}
#' \item{LONGITUDE}{}
#' \item{STN_HT}{}
#' \item{AVIATION_ID}{}
#' \item{REGION}{}
#' \item{GridPt Lat}{}
#' \item{GridPt Lon}{}
#' \item{MSAS elevation}{}
#' \item{Distance from GridPt}{}
#' \item{Roughness}{}
#' \item{Distance from coast}{}
#' \item{Category}{}
#' \item{forecast_district}{}
#' \item{sa_special}{}
#' }
#'
"QLD_hourly_locations"

#'QLD_SILO_and_hourly_stations
#'
#' @format A list of 366 data frame objects, each containing one day of hourly
#' weather observations from 2015-04-30 to 2016-04-29
#' \describe{
#'   \item{station_number}{}
#'   \item{area_code}{}
#'   \item{parameter}{}
#'   \item{valid_start}{}
#'   \item{valid_end}{}
#'   \item{value}{}
#'   \item{unit}{}
#'   \item{statistic}{}
#'   \item{instantaneous}{}
#'   \item{level}{}
#'   \item{qc_valid_minutes}{}
#'   \item{qc_valid_minutes_start}{}
#'   \item{qc_valid_mintues_end}{}
#' }
#' 
"QLD_SILO_and_hourly_stations"

#'SILO_array
#'
#' @format An array of Queensland Scientific Information for Land Owners (SILO)
#' daily weather data, which have corresponding Bureau of Meteorology (BoM)
#' hourly data used for validation
#' \describe{
#'   \item{Station}{Station number}
#'   \item{Date}{Date (YYYYMMDD}
#'   \item{Day}{Day of year}
#'   \item{Date2}{}
#'   \item{T.Max}{Maximum daily air temperature record}
#'   \item{Smx}{}
#'   \item{T.Min}{Minimum daily air temperature recorded}
#'   \item{Smn}{}
#'   \item{Rain}{}
#'   \item{Srn}{}
#'   \item{Evap}{}
#'   \item{Sev}{}
#'   \item{Radn}{}
#'   \item{Ssl}{}
#'   \item{VP}{}
#'   \item{Svp}{}
#'   \item{RHmaxT}{}
#'   \item{RHminT}{}
#'   \item{FAO56}{}
#' }
#' 
"SILO_array"
