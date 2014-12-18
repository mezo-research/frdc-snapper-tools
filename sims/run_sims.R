### ------------------------------------------------------------
## Startup the working environment
## Update the development tools, if you haven't recently
## update.packages(c('r4ss','knitr', 'devtools', 'roxygen2'))
## Load the neccessary libraries
library(devtools)
library(r4ss)
library(ggplot2)
## Might have development ss3sim around so remove it to be safe
## remove.packages("ss3sim")
## install.packages("ss3sim")
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
width <- 9; height <- 5.5               # plot file dims
## End of startup
### ------------------------------------------------------------

### ------------------------------------------------------------
## Run deterministic tests (lots of data, little process error)
## Check case files are read in properly
Nsim <- 25
casefiles <- list(F = "F", E="E", D = c("index","lcomp", "agecomp"))
scenarios <- expand_scenarios(species="sna", cases=list(F=100, E=0, D=100:101))
## get_caseargs(cases.dir, scenarios, case_files=casefiles)
## unlink(scenarios, TRUE)
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
## End of initial deterministic runs and analysis
### ------------------------------------------------------------

### ------------------------------------------------------------
## Run sample trajectories under different fishing scenarios after 1994
Nsim <- 1
casefiles <- list(F = "F", E="E", D = c("index","lcomp", "agecomp"))
scenarios <- expand_scenarios(species="sna",
                              cases=list(F=100:102, E=0, D=100))
## generate tiny recdevs, adjusted accordingly
user.recdevs <- matrix(rnorm(n=Nsim*33, 0, .01)-.01^2/2, nrow=33)
unlink(scenarios, TRUE)
run_ss3sim(iterations=1:Nsim, scenarios=scenarios, case_folder=cases.dir,
           om_dir=om.dir, em_dir=em.dir, case_files=casefiles,
           user_recdevs=user.recdevs, parallel=TRUE)
## Read in results and make basic plots
get_results_all(user_scenarios=scenarios, over=TRUE)
file.copy("ss3sim_scalar.csv", "results/Ftraj_scalar.csv", over=TRUE)
file.copy("ss3sim_ts.csv", "results/Ftraj_ts.csv", over=TRUE)
file.remove("ss3sim_scalar.csv", "ss3sim_ts.csv")
## Results dont contain catch so read those in manually
ts0 <- SS_readdat("D100-E0-F100-sna/1/om/data.ss_new")
ts1 <- SS_readdat("D100-E0-F101-sna/1/om/data.ss_new")
ts2 <- SS_readdat("D100-E0-F102-sna/1/om/data.ss_new")
catch0 <- cbind(ts0$catch[,-3], F="F100")
catch1 <- cbind(ts1$catch[,-3], F="F101")
catch2 <- cbind(ts2$catch[,-3], F="F102")
catch <- rbind(catch0, catch1, catch2)
catch$F <- as.character(catch$F)


## Plot the trajectories
Ftraj.ts <- read.csv("results/Ftraj_ts.csv")
Ftraj.ts <- Ftraj.ts[, c("year",  "SpawnBio_om","F", "F_om")]
Ftraj.ts$F <- as.character(Ftraj.ts$F)

d <- merge(catch, Ftraj.ts, by.x=c("year", "F"))
names(d) <- c("year", "F", "catch", "biomass", "effort")
d.long <- reshape2::melt(d, c("year", "F"))
ggplot(d.long, aes(x=year, y=value, group=F, color=F))+geom_line() +
    facet_wrap("variable", scales="free_y", ncol=1)
ggsave("plots/Ftraj_multipanel.png", width=width, height=height)
