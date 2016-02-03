library(r4ss)
library(ggplot2)
library(ss3sim)

## Read in the assessment fit so we can see what changes

om.dir <- "models/sna-om"

get.ts <- function(dir){
   x <- r4ss::SS_output(dir=dir, covar=FALSE,
        verbose=FALSE, compfile="none", forecast=FALSE, warn=FALSE, readwt=FALSE,
        printstats=FALSE, NoCompOK=TRUE)$timeseries
   return(invisible(x))
}
get.ssb <- function(dir){
    get.ts(dir=dir)$SpawnBio
}

orig.fit <- r4ss::SS_output(dir=om.dir, covar=FALSE,
        verbose=FALSE, compfile="none", forecast=FALSE, warn=TRUE, readwt=FALSE,
        printstats=FALSE, NoCompOK=TRUE)
orig.par <- orig.fit$parameters
orig.par[grep("RecrDev", orig.par$Label),]

orig.ts <- get.ts("models/sna-am/")
orig.ts.long <- reshape2::melt(orig.ts[,c("Yr", "SpawnBio", "Recruit_0", "F:_1")], "Yr")
new2sex.ts <- get.ts("models/sna-om-2sex/")
new2sex.ts.long <- reshape2::melt(new2sex.ts[, c("Yr", "SpawnBio", "Recruit_0", "F:_1")], "Yr")

new1sex.ts <- get.ts(om.dir)
new1sex.ts.long <- reshape2::melt(new1sex.ts[, c("Yr", "SpawnBio", "Recruit_0", "F:_1")], "Yr")
ts.all <- rbind(cbind(model="am", orig.ts.long),
                cbind(model='om-1sex', new1sex.ts.long),
                cbind(model='om-2sex', new2sex.ts.long))
ggplot(ts.all, aes(x=Yr, y=value, group=model, color=model))+
    facet_wrap("variable", scales='free_y', ncol=1) + geom_line()
## ggsave("plots/model_differences.png", width=7 ,height=5)

## Use ss3sim function to rework the data input file for the OM. For now
## putting all years/fleets in for age and length data
x <- SS_readdat("models/sna-om/snapper.dat")
change_data("models/sna-om/snapper.dat",
            file_out="models/sna-om/snapper.dat",
            fleets=1:2, years=1978:2013, types=c("age", "len"))
x <- SS_readctl("models/sna-om/snapper.ctl")
## write.table(expand.grid(years=1978:2013, seas=1, index=1:2, obs=1,
##                         se_log=.2), "test.csv", sep=",", row=F)

## Test ss3sim functions for manipulating OM files
names(orig.ts) <- gsub(":_", "", names(orig.ts))
Fvals <- with(orig.ts, F1+F2+F3+F4+F5+F6)*5
change_f(years=1976:2013, years_alter=1976:2013, fvals=Fvals,
         file_in="models/sna-om/ss3.par",
         file_out="models/sna-om/ss3.par")

## THese are the  recdevs estimated in the original assessment
recdevs.orig <- c(0.958245305575, 0.298952615404, -0.00993104818186, 0.122332557099,
                  0.419272828542, 0.104369940919, -0.0100280986768, -0.572547577741,
                  -0.982583815881, -0.565970129815, -0.875121327558, -0.827563918910,
                  -0.510413835542, 0.0511876052878, -0.470468157362, 1.13185579311,
                  1.38740226761, -4.30545577203, 2.02608902322, -0.260181537909,
                  -0.121706178297, 2.07809304422, 0.703491185974, 0.493990934258,
                  2.47080486846, 1.87955263850, -3.68414210526, -0.100309575304,
                  1.40445944300, 1.63466583728, 1.18131969697, -1.30918083344,
                  -3.74048167352)
setwd(om.dir)
change_rec_devs(recdevs.orig, file_in="ss3.par",
                file_out="ss3.par")
system("ss3_24o_safe -nohess -maxfn 1", ignore.stdout=TRUE)
ssb1 <- get.ssb(getwd())
change_rec_devs(rnorm(33,0,1), file_in="ss3.par",
                file_out="ss3.par")
system("ss3_24o_safe -nohess -maxfn 1", ignore.stdout=TRUE)
ssb2 <- get.ssb(getwd())
change_rec_devs(rnorm(33,0,1), file_in="ss3.par",
                file_out="ss3.par")
system("ss3_24o_safe -nohess -maxfn 1", ignore.stdout=TRUE)
ssb3 <- get.ssb(getwd())
x <- data.frame(cbind(year=1976:2013, ssb1=ssb1, ssb2=ssb2, ssb3=ssb3))
ssb.long <- reshape2::melt(x, "year")
ggplot(ssb.long, aes(year, value, group=variable, color=variable))+
    geom_line() + ylim(0, 10000)
setwd("../..")


### Testing for creating the EM
## Create .dat file iwth lots of data to test functions and that it runs
## properly
## NOTE: I copied over the OM files manually and then ran this to create
## the data.
infile <- SS_readdat("models/sna-em/snapper_all_data.dat", verbose=FALSE)
sample_agecomp(infile=infile,
               outfile="models/sna-em/snapper.dat", Nsamp=list(100,100),
               years=list(seq(1978, 2013, by=5),seq(1978, 2013, by=5)))
infile <- SS_readdat("models/sna-em/snapper.dat", verbose=FALSE)
sample_lcomp(infile=infile,
               outfile="models/sna-em/snapper.dat", Nsamp=list(100,100),
               years=list(seq(1978, 2013, by=5),seq(1978, 2013, by=5)))
infile <- SS_readdat("models/sna-em/snapper.dat", verbose=FALSE)
sample_index(infile=infile, fleets=c(1,2),
               outfile="models/sna-em/snapper.dat", sds_obs=list(.05,.05),
               years=list(seq(1978, 2013, by=5),seq(1978, 2013, by=5)))
## Run it manually and then come back here
ssb.om <- get.ssb("models/sna-om")
ssb.em <- get.ssb("models/sna-em")
ssb.re <- (ssb.om-ssb.em)/ssb.om
plot(ssb.re)
