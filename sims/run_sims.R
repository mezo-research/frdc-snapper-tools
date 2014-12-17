### ------------------------------------------------------------
## Startup the working environment
## Update the development tools, if you haven't recently
## update.packages(c('r4ss','knitr', 'devtools', 'roxygen2'))
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
## Load helper functions
source("functions.R")
## Some global settings
om.dir <- "models/sna-om/"
em.dir <- "models/sna-em/"
cases.dir <- "cases/"
width <- 9; height <- 5.5
## user.recdevs <- matrix(data=rnorm(100^2, mean=0, sd=.001),
##                        nrow=100, ncol=100)
## End of startup
### ------------------------------------------------------------

### ------------------------------------------------------------
## Run deterministic tests (lots of data, little process error)
## Check case files are read in properly
Nsim <- 10
casefiles <- list(F = "F", E="E", D = c("index","lcomp", "agecomp"))
scenarios <- expand_scenarios(species="sna", cases=list(F=0, E=0, D=100:101))
## get_caseargs(cases.dir, scenarios, case_files=casefiles)
unlink(scenarios, TRUE)
## generate tiny recdevs, adjusted accordingly
user.recdevs <- matrix(rnorm(n=Nsim*33, 0, .01)-.01^2/2, nrow=33)
run_ss3sim(iterations=1:Nsim, scenarios=scenarios, case_folder=cases.dir,
           om_dir=om.dir, em_dir=em.dir, case_files=casefiles,
           user_recdevs=user.recdevs)
## Read in results and make basic plots
get_results_all(user_scenarios=scenarios, over=TRUE)
file.copy("ss3sim_scalar.csv", "results/det_scalar.csv", over=TRUE)
file.copy("ss3sim_ts.csv", "results/det_ts.csv", over=TRUE)
file.remove("ss3sim_scalar.csv", "ss3sim_ts.csv")

results <- read.csv("results/det_scalar.csv")
results <- within(results,{
    CV_young_re <- (CV_young_Fem_GP_1_em-CV_young_Fem_GP_1_om)/CV_young_Fem_GP_1_om
    SizeSel_1P_1_fishery_re <- (SizeSel_1P_1_fishery_em-SizeSel_1P_1_fishery_om)/SizeSel_1P_1_fishery_om
    SizeSel_1P_2_fishery_re <- (SizeSel_1P_2_fishery_em-SizeSel_1P_2_fishery_om)/SizeSel_1P_2_fishery_om
    SizeSel_2P_1_survey_re <- (SizeSel_2P_1_survey_em-SizeSel_2P_1_survey_om)/SizeSel_2P_1_survey_om
    SizeSel_2P_2_survey_re <- (SizeSel_2P_2_survey_em-SizeSel_2P_2_survey_om)/SizeSel_2P_2_survey_om
    SizeSel_2P_3_survey_re <- (SizeSel_2P_3_survey_em-SizeSel_2P_3_survey_om)/SizeSel_2P_3_survey_om
    SizeSel_2P_4_survey_re <- (SizeSel_2P_4_survey_em-SizeSel_2P_4_survey_om)/SizeSel_2P_4_survey_om
    SizeSel_2P_5_survey_re <- (SizeSel_2P_5_survey_em-SizeSel_2P_5_survey_om)/SizeSel_2P_5_survey_om
    SizeSel_2P_6_survey_re <- (SizeSel_2P_6_survey_em-SizeSel_2P_6_survey_om)/SizeSel_2P_6_survey_om
    SR_LN_R0_re <- (SR_LN_R0_em-SR_LN_R0_om)/SR_LN_R0_om
    depletion_re <- (depletion_em-depletion_om)/depletion_om
})
results_re <- results[, grep("_re", names(results))]
results_re$D <- results$D
results_re$replicate <- results$replicate
results_long <- reshape2::melt(results_re, c("D","replicate"))
## Make exploratory plots; first scalar quantities
ggplot(results_long, aes(x=variable, y=value)) + facet_grid("D~.")+
    geom_boxplot()+ ylab("relative error")+ ylim(-1, 1) +
    theme(text = element_text(size=15),
        axis.text.x = element_text(angle=90, vjust=1))
ggsave("plots/det_params_re.png", width=width, height=height)

## Now time series (ts) quantities
det.ts <- read.csv("results/det_ts.csv")
det.ts <- det.ts[, c("year", "replicate", "SpawnBio_om", "Recruit_0_om","D",
                     "F_om", "SpawnBio_em", "Recruit_0_em", "F_em" )]
det.ts <- within(det.ts, {
    SSB_re <- (SpawnBio_om-SpawnBio_em)/SpawnBio_om
    F_re <- (F_om-F_em)/F_om
    recruits_re <- (Recruit_0_om-Recruit_0_em)/Recruit_0_om})
det.ts1 <- subset(det.ts, D=="D100")
ggplot(det.ts1, aes(year, SpawnBio_om, group=replicate))+geom_line() +
    ylab("OM: Spawning Biomass") + facet_grid("D~.")
ggsave("plots/det_SSB_om.png", width=width, height=height)
ggplot(det.ts, aes(year, SSB_re, group=replicate)) + ylim(-1,1)+
    geom_line()+ylab("Relative Error: Spawning Biomass")+ facet_grid("D~.")
ggsave("plots/det_SSB_re.png", width=width, height=height)
ggplot(det.ts1, aes(year, F_om, group=replicate))+geom_line() +
    ylab("OM: Fishing Effort")+ facet_grid("D~.")
ggsave("plots/det_F_om.png", width=width, height=height)
ggplot(det.ts, aes(year, F_re, group=replicate)) + #ylim(-1,1)+
    geom_line()+ylab("Relative Error: Fishing Effort")+ facet_grid("D~.")
ggsave("plots/det_F_re.png", width=width, height=height)
ggplot(det.ts1, aes(year, Recruit_0_om, group=replicate))+geom_line() +
    ylab("OM: Recruits") + ylim(0, max(det.ts$Recruit_0_om))+ facet_grid("D~.")
ggsave("plots/det_recruits_om.png", width=width, height=height)
ggplot(det.ts, aes(year, recruits_re, group=replicate)) + #ylim(-1,1)+
    geom_line()+ylab("Relative Error: Recruits")+ facet_grid("D~.")
ggsave("plots/det_recruits_re.png", width=width, height=height)



