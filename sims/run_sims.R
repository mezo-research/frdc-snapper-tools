### ------------------------------------------------------------
## Startup the working environment
## Update the development tools, if you haven't recently
update.packages(c('r4ss','knitr', 'devtools', 'roxygen2'))
## Load the neccessary libraries
library(devtools)
library(r4ss)
library(ggplot2)
## Might have development ss3sim around so remove it to be safe
remove.packages("ss3sim")
install.packages("ss3sim")
library(ss3sim)
## Setup parallel option
## install.packages(c("doParallel", "foreach"))
require(doParallel)
registerDoParallel(cores = 4)
require(foreach)
getDoParWorkers()
## Some global settings
om.dir <- "models/sna-om"
em.dir <- "models/sna-em"
cases.dir <- "cases/"
## user.recdevs <- matrix(data=rnorm(100^2, mean=0, sd=.001),
##                        nrow=100, ncol=100)
## End of startup
### ------------------------------------------------------------

### ------------------------------------------------------------
## Run deterministic tests (lots of data, little process error)
## Check case files are read in properly
casefiles <- list(F = "F", D = c("index","lcomp", "agecomp"))
scenarios <- expand_scenarios(species="sna", cases=list(F=0, D=100))
get_caseargs(cases.dir, scenarios, case_files=casefiles)

run_ss3sim(iterations=1, scenarios=scenarios, case_folder=cases.dir,
           om_dir=om.dir em_dir=em.dir, case_files=casefiles)


