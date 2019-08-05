# Hazel R Package 🌰

### Summary
The R package hazel is meant to help on random but helpful functions. The only purpose is personal use.

This package is licensed under GPL.

```R
install.packages("devtools")
devtools::install_github("mayrop/hazel")
```

### How to perform static code analysis and style checks
Configuration for lintr is in .lintr file. Lints are treated as warnings, but we strive to be lint-free.

In RStudio, you can run lintr from the console as follows:

```R
> lintr::lint_package()
```

### License
This package is free and open source software, licensed under GPL.

