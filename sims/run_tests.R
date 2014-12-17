library(r4ss)
library(ggplot2)
library(ss3sim)

## Read in the assessment fit so we can see what changes


get.ts <- function(dir){
   x <- r4ss::SS_output(dir=dir, covar=FALSE,
        verbose=FALSE, compfile="none", forecast=FALSE, warn=TRUE, readwt=FALSE,
        printstats=FALSE, NoCompOK=TRUE)$timeseries
   return(invisible(x))
}

orig.ts <- get.ts("models/sna-am/")
orig.ts.long <- reshape2::melt(orig.ts[,c("Yr", "SpawnBio", "Recruit_0", "F:_1")], "Yr")
new2sex.ts <- get.ts("models/sna-om-2sex/")
new2sex.ts.long <- reshape2::melt(new2sex.ts[, c("Yr", "SpawnBio", "Recruit_0", "F:_1")], "Yr")
new1sex.ts <- get.ts("models/sna-om")
new1sex.ts.long <- reshape2::melt(new1sex.ts[, c("Yr", "SpawnBio", "Recruit_0", "F:_1")], "Yr")

ts.all <- rbind(cbind(model="am", orig.ts.long),
                cbind(model='om-1sex', new1sex.ts.long),
                cbind(model='om-2sex', new2sex.ts.long))
ggplot(ts.all, aes(x=Yr, y=value, group=model, color=model))+
    facet_wrap("variable", scales='free_y', ncol=1) + geom_line()
ggsave("plots/model_differences.png", width=7 ,height=5)

## Use ss3sim function to rework the data input file for the OM. For now
## putting all years/fleets in for age and length data
x <- SS_readdat("models/sna-om/snapper.dat")
change_data("models/sna-om/snapper.dat",
            file_out="models/sna-om/snapper.dat",
            fleets=1:2, years=1978:2013, types=c("age", "len"))
x <- SS_readctl("models/sna-om/snapper.ctl")
## write.table(expand.grid(years=1978:2013, seas=1, index=1:2, obs=1,
##                         se_log=.2), "test.csv", sep=",", row=F)
