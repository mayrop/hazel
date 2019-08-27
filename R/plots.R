#' Empirical Plot
#' @import dplyr
#' @export
plots.emplogit <- function(df, var = "x", response = "y", bins = 100) {
  labels <- (bins-1):0
  
  df$rank <- rank(-dplyr::pull(df[,var]))
  df$bin <- labels[as.numeric(cut(df$rank, breaks = bins, labels = 0:(bins-1)))]
  
  return(
    df %>%
      dplyr::group_by(bin) %>%
      dplyr::summarise(
        freq = n(),
        successes = sum(!!rlang::sym(response)),
        var := mean(!!rlang::sym(var))
      ) %>% 
      dplyr::mutate(
        elogit = log((successes + (sqrt(freq) / 2)) / (freq - successes + (sqrt(freq) / 2)))
      ) %>% 
      dplyr::arrange(
        bin
      )
  )
}
