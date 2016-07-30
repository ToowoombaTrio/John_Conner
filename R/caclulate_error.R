#' Calcuate Root Mean Square Error
#'
#'Function that returns Root Mean Square Error (RMSE)
#'
#' @details
#'Details go here
#'
#' The CSV or ESRI format shapefile in the respective year-directory
#' will contain the following fields/values:
#' 
#' @examples
#' \dontrun{}
#'
#'
#' @export
#'
rmse <- function(actual, predicted)
{
  error <- actual - predicted
  sqrt(mean(error ^ 2))
}

#' Calcuate Root Mean Absolute Error
#'
#'Function that returns Root Mean Absolute Error (MAE)
#'
#' @details
#'Details go here
#'
#' 
#' @examples
#' \dontrun{}
#'
#'
#' @export
#'
mae <- function(actual, predicted)
{
  error <- actual - predicted
  mean(abs(error))
}
