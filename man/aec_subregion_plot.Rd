% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/aec_subregion_plot.R
\name{aec_subregion_plot}
\alias{aec_subregion_plot}
\title{Plot rates by NHS subregion}
\usage{
aec_subregion_plot(x)
}
\arguments{
\item{x}{A spatial dataframe as described above.}
}
\value{
A ggplot2 object
}
\description{
Subregions (aka local offices) are subdivisions of the four NHS regions.
This plots rates by region in a choropleth map.
Although the function takes a single argument (the spatial data frame),
it relies on the presence of several variables to that data frame:
* \code{long} The longitude
* \code{lat} The latitude
* \code{rate} The rate to be plotted as a filled value
* \code{ODC_CD} The ODS code for the subregion for labelling
* \code{centroid_long} The longitude for the centroid of a polygon
* \code{centroid_lat} The latitude for the centroid of a polygon
Both of the last two are used for the plotting of the labels within the polygon.
}
\examples{
data(subregion_test_data)

# Join example data to subregions_sp_df based on ODS_CD variable
subregions_sp_df <- dplyr::left_join(subregions_sp_df, subregion_test_data)

# Need to convert rand_val to factor and correctly label levels
# Can't do this before left_join as factors are coerced to characters.
subregions_sp_df$rand_val <- cut(subregions_sp_df$rand_val,
  c(0, 0.2, 0.4, 0.6, 0.8, 1.0),
  labels = c("0.0-0.2", "0.21-0.4", "0.41-0.6", "0.61-0.8", "0.81-1.0" ))
# Rename for plotting
subregions_sp_df <- dplyr::rename(subregions_sp_df, rate = rand_val)
p <- aec_subregion_plot(subregions_sp_df)
p
}
