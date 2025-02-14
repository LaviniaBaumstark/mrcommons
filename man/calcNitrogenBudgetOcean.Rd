% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calcNitrogenBudgetOcean.R
\name{calcNitrogenBudgetOcean}
\alias{calcNitrogenBudgetOcean}
\title{calcNitrogenBudgetOcean}
\usage{
calcNitrogenBudgetOcean(deposition = "ACCMIP", leaching = "Nsurplus")
}
\arguments{
\item{deposition}{Method for calculating Atmospheric deposition: Nsurplus2 and Nsurplus are based on deposition rates based on own emission calculations after 2 or after 1 iteration, respectively.}

\item{leaching}{Method for calculating leaching: Nsurplus2 and Nsurplus are based on deposition rates based on own emission calculations after 2 or after 1 iteration, respectively.}
}
\value{
List of magpie object with results on country level, weight on country level, unit and description.
}
\description{
Calculates Nitrogen Budgets for Oceans on global level. Values are placed in Antarcica (ATA)
}
\examples{
\dontrun{
calcOutput("NitrogenBudgetOcean")
}
}
\author{
Benjamin Leon Bodirsky
}
