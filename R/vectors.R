#' Compute Vector Diff
#'
#' This function computes the difference of arrays
#'
#' @param array1 Vector to compare from
#' @param array2 Vector to compare against
#' @return Vector containing all the items from vector1 that are not part of vector2
#' @export
vectors.diff <- function(vector1, vector2) {
  return(vector1[!(vector1 %in% vector2)])
}
