library(r4ss)
library(ggplot2)

## Read in the assessment fit so we can see what changes


get.ts <- function(dir){
   x <- r4ss::SS_output(dir=dir, covar=FALSE,
        verbose=FALSE, compfile="none", forecast=FALSE, warn=TRUE, readwt=FALSE,
        printstats=FALSE, NoCompOK=TRUE)$timeseries
   return(invisible(x))
}

orig.ts <- get.ts("models/sna-am/")
orig.ts.long <- reshape2::melt(orig.ts[,c("Yr", "SpawnBio", "Recruit_0", "F:_4")], "Yr")
new.ts <- get.ts("models/sna-om")
new.ts.long <- reshape2::melt(new.ts[, c("Yr", "SpawnBio", "Recruit_0", "F:_4")], "Yr")
ts.all <- rbind(cbind(model="am", orig.ts.long), cbind(model='om', new.ts.long))
ggplot(ts.all, aes(x=Yr, y=value, group=model, color=model))+
    facet_wrap("variable", scales='free', ncol=1) + geom_line()
