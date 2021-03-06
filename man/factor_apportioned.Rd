% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/factor_apportioned.R
\name{factor_apportioned}
\alias{factor_apportioned}
\title{factor_apportioned}
\usage{
factor_apportioned(x)
}
\arguments{
\item{x}{a column giving the apportioned status of a case. One of 1, 0, HO or CO}
}
\value{
A factor with levels "Hospital-onset", "Community-onset" and "Total cases"
}
\description{
Converts apportioned column into a factor for production of long format tables.
}
\examples{
factor_apportioned(1)
factor_apportioned("CO")
}
\seealso{
\code{\link{mo_tab_long}}, \code{\link{ann_tab_long}}
}
