#' Function to dynamically build formula
#' @export
formula.build <- function(y, x=c(), regex="", transformations=list()) {
  formula <- ""

  for (predictor in x) {
    # needs to have one of the following regex to be valid
    if (regex != "" & !grepl(regex, predictor)) {
      next
    }

    if (!(predictor %in% names(transformations))) {
      transformations[[predictor]] <- predictor
    }

    sep <- ifelse(formula == "", " ", " + ")
    formula <- paste(formula, transformations[[predictor]], sep = sep)
  }

  return(as.formula(paste(y, " ~ ", formula, sep = "")))
}
