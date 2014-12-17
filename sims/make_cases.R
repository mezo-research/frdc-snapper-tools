## This file uses R to write the case files. It's a bit awkward but is
## reproducible and easily maintainable.

## Write the F trajectory, basing this on approximate fishing levels from
## assessment
case.dir <- "cases/"
Fvals <- c(0, 0.45, 0.52, 0.63, 0.54, 0.62, 0.48, 0.5, 0.45, 0.46, 0.47,
           0.47, 0.69, 0.57, 0.58, 0.62, 0.86, 0.91, 0.89, 0.93, 0.77, 0.71,
           0.73, 0.58, 0.71, 0.74, 0.64, 0.57, 0.59, 0.55, 0.61, 0.6, 0.62,
           0.66, 0.63, 0.61, 0.56, 0.49)
Fcase <- c("years; c(1976:2013)",
           "years_alter; c(1976:2013)",
           paste0("fvals; c(", paste(Fvals, collapse=","), ")"))
writeLines(Fcase, paste0(case.dir, "F0-sna.txt"))

index100 <- c("fleets; c(1,2)", "sds_obs;list(.05,.05)",
              "years;list(seq(1976,2013, by=4),seq(1976,2013, by=4))",
            "cpar;c(1,1)")
writeLines(index100, paste0(case.dir, "index100-sna.txt"))

lcomp100 <- c("fleets; c(1,2)", "Nsamp; list(50,100)",
              "years;list(seq(1976,2013, by=4),seq(1976,2013, by=4))",
            "cpar;c(1,1)")
writeLines(lcomp100, paste0(case.dir, "lcomp100-sna.txt"))
agecomp100 <- c("fleets; c(1,2)", "Nsamp; list(50,100)",
              "years;list(seq(1976,2013, by=4),seq(1976,2013, by=4))",
            "cpar;c(1,1)")
writeLines(agecomp100, paste0(case.dir, "agecomp100-sna.txt"))
