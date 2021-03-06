% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/graph_age_groups.R
\name{graph_age_groups}
\alias{graph_age_groups}
\title{graph_age_groups}
\usage{
graph_age_groups(x, data_collection)
}
\arguments{
\item{x}{A character vector of age groups}

\item{data_collection}{a string giving the data collection of the labels to
be converted.}
}
\value{
A factor with labels that can be printed in ggplot2
}
\description{
Produces nice age groups for plotting on graphs. Different output for
CDI and BSI
}
\examples{
data(age_trends_data)
head(age_trends_data)

## To get the right sorting and labels for the age groups

age_trends_data$age_group2 <- graph_age_groups(age_trends_data$age_group_new,
  data_collection = "cdi")
}
\seealso{
\code{\link{age_sex_pyramid}} for its use in a graph.
}
