#' Parse 2015/16 Meteorological Verification Data
#'
#'This function automates parsing of temperature and precipitation for
#'Queensland weather stations.
#'
#' @param
#'
#'
#' @details
#'Details about the resulting files go here
#'
#' The CSV or ESRI format shapefile in the respective year-directory
#' will contain the following fields/values:
#' \describe{
#' \item{station_number}{Station number (WMO/DATSAV3 number) for the location}
#' \item{area_code}{}
#' \item{start}{}
#' \item{end}{}
#' \item{Temperature}{Degrees Celsius}
#' \item{Rainfall}{Millimetres}
#' \item{LAT}{Latitude}
#' \item{LON}{Longitude}
#' \item{STN_HT}{Station reported elevation (metres to hundredths)}
#' \item{Aviation ID}{}
#' \item{MSAS Elevation}{}
#' \item{Distance from GridPt}{}
#' \item{Roughness}{}
#' \item{Distance from coast}{}
#' \item{Category}{}
#' \item{Forecast district}{}
#' \item{sa_special}{}
#'
#'@note Users of these data should take into account the following }
#'
#' @examples
#' \dontrun{
#' #'
#'
#' @references {}
#'
#' @importFrom foreach %dopar%
#' @importFrom foreach %do%
#' @importFrom data.table :=
#'
#' @export

spatial <- readr::read_csv("data/BoM_ETA_20150501-20160430/spatial/StationData.csv")
spatial <- spatial[spatial$REGION == "QLD", ]

day_files <- list.files("data/BoM_ETA_20150501-20160430/obs/")
itx <- iterators::iter(day_files)

foreach::foreach(f = ity) %do% {

day <- readr::read_csv(f)

