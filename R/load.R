#' Function to install and load libraries
#' @export
load.libraries <- function(libraries) {
  if (!is.array(libraries)) {
    libraries <- as.array(libraries)
  }
  for (library in libraries) {
    if (!require(library, character.only = TRUE)) {
      install.packages(library)
    }

    library(library, character.only = TRUE)
  }
}

#' Function to install from devtools::install_github
#' @export
load.github <- function(libraries) {
  load.libraries(c("remotes"))

  if (!is.array(libraries)) {
    libraries <- as.array(libraries)
  }

  for (library in libraries) {
    suffix <- gsub(".*?/", "", library)

    if (!require(suffix, character.only = TRUE)) {
      remotes::install_github(library)
    }

    library(suffix, character.only = TRUE)
  }
}

#' Function to load from source
#' @export
load.sources <- function(sources) {
  for (s in sources) {
    source(s)
  }
}

#' Function to load from specified folder
#' @export
load.datasets <- function(folder = "data") {
  datasets <- list()

  for (file in list.files(folder)) {
    path <- paste(folder, "/", file, sep = "")
    name <- gsub("\\.\\w+$", "", file)

    datasets[[name]] <- read.csv(path)
  }

  return(datasets)
}
