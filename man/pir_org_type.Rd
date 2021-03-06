% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pir_org_type.R
\name{pir_org_type}
\alias{pir_org_type}
\title{Create ordered factor variable for PIR organisation type.}
\usage{
pir_org_type(x)
}
\arguments{
\item{x}{The column of a data frame giving the PIR organisation type.}
}
\description{
As imported, PIR organisation types are character variables.
For the correct ordering when reshaping wide, this needs to be a factor variable.
}
\examples{
x <- data.frame(pir = c("", "NHS Trust", "Clinical Commissioning Group",
"Total Reported Cases", NA))

x$pir2 <- pir_org_type(x$pir)
}
