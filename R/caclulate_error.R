#' Calculate Root Mean Square Error
#'
#'Function that calculates Root Mean Square Error (RMSE)
#' @param actual observed values
#' @param predicted predicted values
#' @details
#'Details go here
#'
#' @examples
#' actual <- c(4, 6, 9, 10, 4, 6, 4, 7, 8, 7)
#' predicted <- c(5, 6, 8, 10, 4, 8, 4, 9, 8, 9)
#' rmse(actual, predicted)
#'
#' @export
#'
rmse <- function(actual, predicted)
{
  error <- actual - predicted
  sqrt(mean(error ^ 2))
}

#' Calculate Root Mean Absolute Error
#'
#'Function that calculates Root Mean Absolute Error (MAE)
#'
#' @param actual observed values
#' @param predicted predicted values
#' @examples
#' # Example data
#' actual <- c(4, 6, 9, 10, 4, 6, 4, 7, 8, 7)
#' predicted <- c(5, 6, 8, 10, 4, 8, 4, 9, 8, 9)
#' mae(actual, predicted)
#'
#' @export
#'
mae <- function(actual, predicted)
{
  error <- actual - predicted
  mean(abs(error))
}
