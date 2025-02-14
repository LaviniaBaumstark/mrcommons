#' @title calcNitrogenFixationPast
#' @description calculates fixation from freeliving bacteria and from nitrogen-fixing crops
#' @param fixation_types either "fixation_crops", "fixation_freeliving", or "both"
#' @param sum_plantparts if false, crop residues, belowground residues and harvested organ are reported separately
#' @param cellular cellular estimates optional
#' @param irrigation if TRUE, distinguishes irrigated and non-irrigated crops
#' @return List of magpie objects with results on country level, weight on country level, unit and description.
#' @author Benjamin Leon Bodirsky
#' @seealso
#' [calcNitrogenFixationPast()]
#' @examples
#' \dontrun{
#' calcOutput("calcNitrogenFixationPast")
#' }
#' @importFrom magpiesets findset
#'

calcNitrogenFixationPast <- function(fixation_types = "both", # nolint: object_name_linter.
                                     sum_plantparts = TRUE, # nolint: object_name_linter.
                                     cellular = FALSE,
                                     irrigation = FALSE) {
  fixBiomass <- NULL
  fixFreeliving <- NULL
  past <- findset("past")
  if ((fixation_types == "both") && (sum_plantparts == FALSE)) {
    warning("sum_plantparts set to true")
    sum_plantparts <- TRUE # nolint: object_name_linter.
  }
  if (fixation_types %in% c("both", "fixation_crops")) {
    harvest <- collapseNames(calcOutput("Production", products = "kcr", cellular = cellular,
                                        attributes = "nr", irrigation = irrigation, aggregate = FALSE)[, past, ])
    harvest <- add_dimension(harvest, dim = 3.1, add = "data1", nm = "organ")
    resAg <- collapseNames(calcOutput("ResBiomass", cellular = cellular,
                                       plantparts = "ag", irrigation = irrigation,
                                       attributes = "nr", aggregate = FALSE)[, past, ],
                            collapsedim = "attributes")
    resBg <- collapseNames(calcOutput("ResBiomass", cellular = cellular,
                                       plantparts = "bg", irrigation = irrigation,
                                       attributes = "nr", aggregate = FALSE)[, past, ],
                            collapsedim = "attributes")
    biomass <- mbind(harvest, resAg, resBg)
    if (sum_plantparts == TRUE) {
      biomass <- dimSums(biomass, dim = 3.1)
    }
    ndfa <- setYears(readSource("Herridge", subtype = "ndfa"), NULL)
    ndfa <- ndfa[getItems(biomass, dim = 1), , ]
    biomass <- biomass * ndfa
    fixBiomass <- add_dimension(biomass, dim = 3.1, nm = "fixation_crops")
  }
  if (fixation_types %in% c("both", "fixation_freeliving")) {
    area <- collapseNames(calcOutput("Croparea", cellular = cellular, aggregate = FALSE,
                                     sectoral = "kcr", physical = TRUE, irrigation = irrigation)[, past, ])
    freeliving <- setYears(readSource("Herridge", subtype = "freeliving", convert = FALSE), NULL)
    freeliving <- area * freeliving
    freeliving <- freeliving[, getYears(fixBiomass), ]
    fixFreeliving <- add_dimension(freeliving, dim = 3.1, nm = "fixation_freeliving")
  }

  out <- collapseNames(mbind(fixBiomass, fixFreeliving))

  return(list(x = out,
              weight = NULL,
              unit = "Mt Nr",
              description = "Nitrogen fixation by crops and freeliving bacteria",
              isocountries = !cellular
              ))
}
