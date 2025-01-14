% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/readRegressionsILO.R
\name{readRegressionsILO}
\alias{readRegressionsILO}
\title{readRegressionsILO}
\usage{
readRegressionsILO(subtype = "AgEmpl")
}
\arguments{
\item{subtype}{Type of ILOSTAT data for which regression coefficients should be read
\itemize{
\item \code{AgEmpl}: "Employment by sex and economic activity -- ILO modelled estimates, Nov. 2020 (thousands)"
\item \code{HourlyLaborCosts}: "Mean nominal hourly labour cost per employee by economic activity"
}}
}
\value{
regression coefficients as MAgPIE object
}
\description{
Read regression coefficients which are used to fill missing values of ILO datasets
}
\examples{
\dontrun{
  readSource("RegressionsILO", "AgEmpl")
}
}
\author{
Debbora Leip
}
