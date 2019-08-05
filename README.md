### Summary
The R package hazel is meant to help on random but helpful functions. The only purpose is personal use.

This package is licensed under GPL.

```
install.packages("devtools")
devtools::install_github("mayrop/hazel")
```

### How to perform static code analysis and style checks
We use lintr which also performs the analysis on Travis-CI. Configuration for lintr is in .lintr file. Lints are treated as warnings, but we strive to be lint-free.

In RStudio, you can run lintr from the console as follows:

```
> lintr::lint_package()
```