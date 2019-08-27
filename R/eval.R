#' Compute McNemar's test
#' @export
eval.mcnemar <- function(response,
                         model1,
                         model2,
                         names = c("Model 1", "Model 2"),
                         headings = c("Correct", "Incorrect"),
                         correct = TRUE) {

  vals <- list(
    # both correct
    a = sum(response == model1 & response == model2),

    # only model 1 correct
    b = sum(response == model1 & response != model2),

    # only model 2 correct
    c = sum(response != model1 & response == model2),

    # both incorrect
    d = sum(response != model1 & response != model2)
  )

  my_dimnames <- list()
  my_dimnames[[names[1]]] <- headings
  my_dimnames[[names[2]]] <- headings

  mcnemar_table <- matrix(
    rbind(c(vals$a, vals$b), c(vals$c, vals$d)),
    nrow = 2,
    dimnames = my_dimnames
  )

  return(
    list(
      # redundant with mcnemar.table, but useful
      "classifications" = as.data.frame(vals),
      "mcnemar.table" = mcnemar_table,
      "mcnemar.test" = mcnemar.test(mcnemar_table, correct = correct)
    )
  )
}

#' Compute Ccochran's_q Q
#' @import expss
#' @export
eval.cochrans_q <- function(y_target, x) {
  # k will be the number of classifiers
  k <- ncol(x)

  # changing colnames for convenience
  colnames(x) <- 1:k

  # calculate G
  G <- rep(0, length.out = k)

  for (i in 1:k) {
    G[i] <- sum(y_target == x[, i])
  }

  x$y_target <- y_target

  correct <- apply(x[, ], 1, function(row) {
    # here we count how many classifiers equal the true class
    expss::count_if(row[length(row)], row[-length(row)])
  })

  method <- "Cochran's Q test for comparing the performance of multiple classifiers"
  parameter <- k-1
  statistic <- (k - 1) * (k * sum((G - mean(G)) ** 2)) / (k * sum(G) - sum(correct ** 2))
  # Old: (k-1) * (k * sum(G**2) - sum(G)**2) / (k*sum(G) - sum(correct**2))
  p <- pchisq(statistic, df = parameter, lower.tail = FALSE)

  names(statistic) <- "Cochran's Q chi-squared"
  names(parameter) <- "df"

  rval <- list(
    statistic = statistic,
    parameter = parameter,
    p.value = p,
    method = method,
    data.name = "data",
    alternate = ""
  )

  class(rval) <- "htest"
  return(rval)
}
