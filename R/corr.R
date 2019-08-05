#' Hoeffding's D and Spearman matrix in order to produce a scatterplot
#' Inspired in SAS Certification Prep Guide: Statistical Business Analysis Using SAS9

#' @param x Matrix x
#' @param y Response y
#'
#' @return The matrix with the following columns:
#'   \item{spearman_corr_coeff}{Correlation coefficient for Spearmans}
#'   \item{hoeffding_d_corr_coeff}{Correlation coefficient for Hoeffding's D measure}
#'   \item{spearman_abs}{Absolute value of the correlation coefficient}
#'   \item{hoeffding_d_abs}{Absolute value of the Hoeffding's D correlation coefficient}
#' @seealso \link{https://www.ncbi.nlm.nih.gov/pubmed/23962479}
#' @examples
#'
#' @keywords hoeffding, spearman, monotonic
#' @export
corr.hoeffding <- function(x, y) {
  hoeff_matrix <- hoeffd(x, y)
  hoeff_matrix <- apply(hoeff_matrix$D, 1, as.data.frame)$y

  matrix <- as.data.frame(cbind(
    cor(x, y, method = "spearman"),
    # remove "y" from the rows
    hoeff_matrix[-which(rownames(hoeff_matrix) == "y"), ]
  ))
  # adding friendly colnames
  colnames(matrix) <- c("spearman_corr_coeff", "hoeffding_d_corr_coeff")

  matrix$spearman_abs <- abs(matrix[, 1])
  matrix$hoeffding_d_abs <- abs(matrix[, 2])

  # sorting by Spearman's Correlation Coeff in descending order
  matrix <- matrix[order(-matrix$spearman_abs), ]

  matrix$spearman_rank <- rank(-matrix$spearman_abs)
  matrix$hoeffding_d_rank <- rank(-matrix$hoeffding_d_abs)

  return(matrix)
}
