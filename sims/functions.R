calculate_re <- function(dat, add = TRUE) {

  cols <- names(dat)[grep("_em", names(dat))]
  cols <- gsub("_em", "", cols)
  em_names <- paste0(cols, "_em")
  om_names <- paste0(cols, "_om")

  re <- (dat[, em_names] - dat[, om_names]) /
    dat[, om_names]
  names(re) <- gsub("_em", "_re", names(re))

  # strip out NLL if these are scalar data:
  re <- re[, !grepl("NLL", names(re))]

  if (!add) {
    data.frame(dat[,-which(names(dat) %in%
      c(om_names, em_names))], re)
  } else {
    data.frame(dat, re)
  }
}
