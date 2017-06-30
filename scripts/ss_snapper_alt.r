#------------------------------------------------------------------
# Get SS plots from directory specified.
# Comparison of two or more models can be enabled. 
# This file configured for Snapper, DEPI, 2013/14.
# 
# by Athol Whitten, awhitten@gmail.com
#------------------------------------------------------------------

# Open the libraries/updates/functions required:
library(r4ss)

# Or: Install required version of r4ss from Github:
# devtools::install_github("r4ss/r4ss", ref="v1.22.1")

# Specify working folder (directory where subdirectories are species folders):
folder <- "C:/Dropbox/Fisheries/DEPI/Assessment"

# Enter species name:
species <- "Snapper"
year <- 2013

# Which plots from SS plots function required? (all = 1:27):
which.plots <- (1:27)

# Set max and min values for absolute correlation between estimated parameters, R4SS will report parameters with correlations above or below this level:
cormax <- 0.95
cormin <- 0.01

# Specify model names as folder names of each set of model files, set the base case as model one;
model.names <- c("AC_M0.20")

# Specify if summary table (.tex) of model comparisons should be saved to file (this summary shown to screen by default);
save.summary <- FALSE

# Specify if model comparison functions (including plots) are required;
compare.plots <- FALSE

# Specify last year for comparison plots and summary stats (may wish to ignore forecast period for example);
last.year <- 2032

# Specifiy if running retrospective tests and set retrospective model year;
retro <- FALSE
retro.year <- 2011

# For spawning depletion plots, specify biomass target and biomass minimum threshold;
biomass.target <- 0.50
biomass.threshold <- 0.20

# Enter TRUE/FALSE (1/0) for output options for each model (same number entries as number of models);
include <- c(1,0)
compare <- c(0,0)

hessian <- c(1,1)
forecast <- c(0,1)

show.plots <- c(1,0)
pdf.plots <- c(0,0)
print.plots <- c(1,0)
 
#-------------------------------------------------------------------
# End user specs; start subroutines. 
#-------------------------------------------------------------------

# Create model directory array and print information as such:
model.dirs <- array()
for(i in 1:length(model.names)){
	next.dir <- paste(folder,year,species,"Models",model.names[i],sep="/")
	if(retro==TRUE){next.dir <- paste(folder,species,"Retrospective",retro.year,model.names[i],sep="/")}
	model.dirs <- append(model.dirs,next.dir)
	}
model.dirs <- model.dirs[-1]

model.string <- "Output sought from these model directories: \n"
for(i in which(include==TRUE)){
	next.dir <- paste(folder,year,species,"Models",model.names[i],sep="/")
	if(retro==TRUE){next.dir <- paste(folder,species,"Retrospective",retro.year,model.names[i],sep="/")}
	model.string <- cat(model.string,next.dir,"\n")
	}

# Create input/ouput control data frame:
iocontrol <- data.frame(cbind(model.names,include,forecast,hessian,show.plots,pdf.plots,print.plots))
print(iocontrol)

# Make plots from SS report file/s and create tables to compare models:
mdata=rbind(1:12,data.frame())
#names(mdata) <- c("SBZero","SBCurr","PrevDepl","CurrDepl","RBC","RBCLong","No. Est. Parameters","SurveyL","LengthL","AgeL","OtherL","TotalL (-LnL)","LDiff")
names(mdata) <- c("SBZero","SBCurr","PrevDepl","CurrDepl","RBC","RBCLong","No. Est. Parameters","SurveyL","LengthL","OtherL","TotalL (-LnL)","LDiff")
ldata <- data.frame(Likelihoods_Used=0:11)
tslist <- list()
j <- 1

	for(i in which(include==TRUE))
	{
		j <- j + 1
		replist <- SS_output(dir=model.dirs[i],covar=hessian[i],forecast=forecast[i],cormax=cormax,cormin=cormin,printhighcor=50)
		k <- replist$N_estimated_parameters
		L <- round(replist$likelihoods_used[1,1],0)

		if(i==1) BaseL <- L else BaseL <- 0
		LDiff <- L - BaseL

		time.series <- replist$timeseries
		SBzero <- round(replist$SBzero,0)

		ts.SB <- time.series[,c("Yr","SpawnBio")]
		ts.SB <- cbind(ts.SB,"Depletion"=ts.SB$SpawnBio/(ts.SB$SpawnBio[1]))
		curr.depl=round(ts.SB[ts.SB$Yr==year+1,"Depletion"],2)
		SBcurr=round(ts.SB[ts.SB$Yr==year+1,"SpawnBio"])
		prev.depl=round(ts.SB[ts.SB$Yr==year,"Depletion"],2)
		SBprev=round(ts.SB[ts.SB$Yr==year,"SpawnBio"])

		next.year=replist$timeseries[replist$timeseries$Yr==(year+1),]
		long.term=replist$timeseries[replist$timeseries$Yr==last.year,]
		rbc=round(next.year$"dead(B):_1" + next.year$"dead(B):_2",0)
		rbc.long=round(long.term$"dead(B):_1" + long.term$"dead(B):_2",0)

		report.likes <- replist$likelihoods_used[1]
		ldata=cbind(ldata,report.likes)
		names(ldata)[j]=model.names[i]

		mlikes <- round(report.likes[c("Survey","Length_comp","Age_comp"),],2)
		mlikes.extra <- report.likes["TOTAL",]-sum(mlikes)
		mlikes <- c(mlikes,mlikes.extra)

		mtrow=as.list(c(SBzero,SBcurr,prev.depl,curr.depl,rbc,rbc.long,k,mlikes,L,LDiff))
		mdata=rbind(mdata,mtrow)
		row.names(mdata)[j]=model.names[i]

		tslist=c(tslist,time.series)
		names(tslist)[i]=model.names[i]

		# Specify folder into which graphics and PDF files should be directed;
		if(retro==FALSE){
		dir.create(paste(folder,species,"Models",model.names[i],"Output",sep="/"))
		output.folder=paste(folder,species,"Models",model.names[i],"Output",sep="/")
		}

		if(retro==TRUE){
		dir.create(paste(folder,species,"Retrospective",retro.year,model.names[i],"Output",sep="/"))
		output.folder=paste(folder,species,"Retrospective",retro.year,model.names[i],"Output",sep="/")
		}

		if(show.plots[i]==TRUE){SS_plots(replist=replist,btarg=biomass.target,minbthresh=biomass.threshold,uncertainty=hessian,plot=which.plots,forecastplot=forecast[i])}
		if(print.plots[i]==TRUE){SS_plots(replist=replist,btarg=biomass.target,minbthresh=biomass.threshold,uncertainty=hessian,plot=which.plots,forecastplot=forecast[i],png=TRUE)}
		if(pdf.plots[i]==TRUE)
		{
			SS_plots(replist=replist,btarg=biomass.target,minbthresh=biomass.threshold,uncertainty=hessian,forecastplot=forecast[i],pdf=TRUE,plot=which.plots,dir=output.folder)
			dev.off()	
		}
	}

mdata=mdata[-1,]
ldata=round(ldata,2)

# Model Comparison Data Frame (mdata) and Component Likelihoods (ldata) will be displayed (and saved to file if required) and can be called from R console after script completes.
print(ldata)
print(mdata)

if(save.summary==TRUE){
	sink(paste(output.folder,"/ModelSummary.tex",sep=""))
	xtable(mdata,caption=paste("Comparison of SS models for ",species,sep=""),label=paste("tab:ModelSummary",short.name,sep=""))
	}
if(save.summary==TRUE){sink()}

if(save.summary==TRUE){
	sink(paste(output.folder,"/ComponentLikelihoods.tex",sep=""))
	xtable(ldata[,-1],caption=paste("Comparison of model component likelihood values for ",species,sep=""),label=paste("tab:CompLikelihoods",short.name,sep=""))
	}
if(save.summary==TRUE){sink()}	
	

#-------------------------------------------------------------------
# Model comparison section below.
#-------------------------------------------------------------------

if(compare.plots==TRUE){

	#Get all report files into one 'biglist' and make each report list a global variable for plotting features;
	biglist=SSgetoutput(dirvec=model.dirs[which(compare==TRUE)],forecast=TRUE,verbose=TRUE,underscore=TRUE,listlists=TRUE)

	#Summarise the contents of 'biglist' using the SSsummarize function
	bigsummary=SSsummarize(biglist)

	#See estimated quantities summary (rounded):
	cbind(round(bigsummary$quants[1:2],2),bigsummary$quants[3:4])

	#Compare plots of interest using SSplotcomparisons;
	SSplotComparisons(bigsummary,btarg=biomass.target,endyrvec=last.year,minbthresh=biomass.threshold,subplots=1:14,spacepoints=5,staggerpoints=0,plot=TRUE,print=FALSE,legendlabels=model.names[which(compare==TRUE)])
	}
	
	
	#Enable line below to direct Comparison Plots to some specified directory;
	#SSplotComparisons(bigsummary,btarg=biomass.target,endyrvec=last.year,minbthresh=biomass.threshold,subplots=1:14,spacepoints=5,staggerpoints=1,plot=TRUE,print=TRUE,legendlabels=model.names[which(compare==TRUE)],plotdir="")

#---------------------------
# EOF