#' Format date into short text financial year.
#'
#' Formats date from date or POSIX class to a text string giving the financial
#' year as 'yy/yy'
#'
#' @param date_var A date variable in class Date or POSIX
#' @param sep A separator between two years. Defaults to "/"
#' @return A text string giving the financial year.
#' @seealso \code{\link{fy_long}}
#' @examples
#' x <- lubridate::dmy("01/01/2001")
#' fy_short(x)
#' fy_short(x, sep = "_")
#' @export

fy_short <- function(date_var, sep = "/"){
  if (!requireNamespace("lubridate", quietly = TRUE)) {
    stop("lubridate is needed for this function to work. Please install it.",
         call. = FALSE)
  }
  assertthat::assert_that(lubridate::is.Date(date_var),
                          msg = "date_var must be of class date")
  qtr <- lubridate::quarter(date_var)
  date_var <- as.Date(date_var)
  this_year <- as.numeric(substr(as.character(lubridate::year(date_var)), 3, 4))
  z <- ifelse(qtr > 1,
    paste(sprintf("%02i", this_year), sprintf("%02i", this_year + 1), sep = sep ),
    paste(sprintf("%02i", this_year - 1), sprintf("%02i", this_year), sep = sep ))
  return(z)
}
