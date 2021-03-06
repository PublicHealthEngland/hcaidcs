% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/age_sex_pyramid.R
\name{age_sex_pyramid}
\alias{age_sex_pyramid}
\title{Age sex pyramid}
\usage{
age_sex_pyramid(dat, age_group, sex_var, y_var, y_var_label)
}
\arguments{
\item{x}{A dataframe providing the data}
}
\value{
A ggplot object
}
\description{
Create an age-sex pyramid for commentaries.
Credit where it's due, much of this has been cribbed from Seb Fox's
fingertipscharts package.
\url{https://github.com/publichealthengland/fingertipscharts/blob/master/R/quick_charts.R}
}
\examples{
data(age_trends_data)
head(age_trends_data)

## To get the right sorting and labels for the age groups

age_trends_data$age_group2 <- graph_age_groups(age_trends_data$age_group_new,
  data_collection = "cdi")

p <- age_sex_pyramid(dat = subset(age_trends_data, fyear6 == 200708),
  age_group = age_group2, sex_var = sex, y_var = rate,
  y_var_label = "Rate, per 100,000 population")
p
}
