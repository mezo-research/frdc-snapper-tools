#------------------------------------------------------------------
# Get SS plots from directory specified.
# Comparison of two or more models can be enabled. 
# This file configured for Snapper, DEPI, 2013/14.
# 
# by Athol Whitten, awhitten@gmail.com
#------------------------------------------------------------------

# Open the libraries/updates/functions required:
library(r4ss)
# OR: Install required version of r4ss from Github:
# devtools::install_github("r4ss/r4ss", ref="v1.22.1")

# Specify species, year:
species <- "Snapper"
year 		<- 2013

# Specify model folder names, set the base case as model one:
model.names <- c("AC_M0.20","AC_FG")

# Which plots from SS plots function required? (all = 1:24):
which.plots <- (1:24)

# Set max and min values for reporting absolute correlation between estimated parameters:
cormax <- 0.95
cormin <- 0.01

# For spawning depletion plots, specify biomass target and biomass minimum threshold:
biomass.target 		<- 0.50
biomass.threshold <- 0.20

# Specify if summary table (.tex) of model comparisons should be saved to file:
save.summary <- FALSE

# Enter TRUE/FALSE (1/0) output options for each model specified above:
include 		<- c(1,1)
hessian 		<- c(0,0)
forecast 		<- c(0,0)
compare 		<- c(1,1)
do.plots 		<- c(1,1)
png.plots 	<- c(1,1) # Note: Cannot print to png and pdf at same time.
pdf.plots 	<- c(1,1) # If both TRUE, png given precedence.

# Specify if model comparison functions (including plots) are required:
compare.plots <- FALSE
save.compare  <- FALSE
last.year 		<- 2032

# Specifiy if running retrospective tests and set retrospective model year:
retro 			<- FALSE
retro.year 	<- 2012


#-------------------------------------------------------------------
# End user specs; start subroutines. 
#-------------------------------------------------------------------

# Create model directory array and print information as such:
model.dirs <- array()
for(i in 1:length(model.names)){
	next.dir <- paste("./models", model.names[i], sep="/")
	if(retro==TRUE){next.dir <- paste("/models/retro", retro.year, model.names[i], sep="/")}
	model.dirs <- append(model.dirs, next.dir)
	}
model.dirs <- model.dirs[-1]

model.string <- "Output sought from these model directories: \n"
for(i in which(include==TRUE)){
	next.dir <- paste("./models", model.names[i], sep="/")
	if(retro==TRUE){next.dir <- paste("/models/retro", retro.year, model.names[i], sep="/")}
	model.string <- cat(model.string, next.dir, "\n")
	}

# Create input/ouput control data frame:
iocontrol <- data.frame(
	cbind(model.names, include, forecast, hessian, do.plots, pdf.plots, png.plots)
)
print(iocontrol)

# Draw plots from SS report file/s:
for(i in which(include==TRUE)){
	replist <- SS_output(
		dir=model.dirs[i],
		covar=hessian[i],
		forecast=forecast[i],
		cormax=cormax,
		cormin=cormin,
		printhighcor=50
	)

	# Specify folder into which PDF files should be directed;
	if(retro==FALSE){
	dir.create(paste("./models", model.names[i], "output",sep="/"))
	output.folder=paste("./models", model.names[i], "output",sep="/")
	}

	if(retro==TRUE){
	dir.create(paste("./models/retro", retro.year, model.names[i], "output",sep="/"))
	output.folder=paste("./models/retro", retro.year, model.names[i], "output",sep="/")
	}

	if(do.plots[i]==TRUE){
		if(png.plots[i]==TRUE) pdf.plots[i] <- FALSE
		if(pdf.plots[i]==TRUE) dir <- output.folder else dir <- "default"
		
		SS_plots(
			replist=replist,
			btarg=biomass.target,
			minbthresh=biomass.threshold,
			uncertainty=hessian,
			plot=which.plots,
			forecastplot=forecast[i],
			png=png.plots[i],
			pdf=pdf.plots[i],
			dir=dir,
			html=FALSE,
			datplot=TRUE			
		)

		SS_html(replist=replist,openfile=FALSE)
	}
}

#-------------------------------------------------------------------
# Model comparison section below.
#-------------------------------------------------------------------

if(compare.plots==TRUE){

	# Get all report files into one 'biglist' 
	# Make each report list a global variable for plotting features:
	biglist <- SSgetoutput(
		dirvec=model.dirs[which(compare==TRUE)],
		getcovar=FALSE,
		forecast=FALSE,
		verbose=TRUE,
		underscore=TRUE,
		listlists=TRUE
	)

	#Summarise the contents of 'biglist' using the SSsummarize function
	bigsummary=SSsummarize(biglist)

	#See estimated quantities summary (rounded):
	cbind(round(bigsummary$quants[1:2],2),bigsummary$quants[3:4])

	#Compare plots of interest using SSplotcomparisons;
	SSplotComparisons(
		bigsummary,
		btarg=biomass.target,
		endyrvec=last.year,
		minbthresh=biomass.threshold,
		subplots=1:14,
		spacepoints=5,
		staggerpoints=0,
		plot=TRUE,
		print=FALSE,
		legendlabels=model.names[which(compare==TRUE)]
	)
}

if(save.compare==TRUE){
	# Save Comparison Plots to specified directory:
	SSplotComparisons(
		bigsummary,
		btarg=biomass.target,
		endyrvec=last.year,
		minbthresh=biomass.threshold,
		subplots=1:14,
		spacepoints=5,
		staggerpoints=1,
		plot=TRUE,
		print=TRUE,
		legendlabels=model.names[which(compare==TRUE)],
		plotdir=""
	)
}

#-------------------------------------------------------------------
# TODO: SS Modelling
#-------------------------------------------------------------------

# Note: There is no male or female data, thus check estimate male offsets in growth. 
# Females and males may have to be the same... for growth (for now). 
# Note: Ling model est. offsets with no sex-specific data.
# Entering the age-comp data with sex-specific information might help with this.
# Also, estimating growth slows the model run-time significantly,
# ... consider re-binning the cond-age-length data.

# Things to do:
# (1) 	Add extra ageing error, 
#				try use of parameters for age-matrices, as per simple example.
# (2) 	Make male and female growth parameters the same (or males with fixed zero offsets).
# (3) 	Downweight the ageing data.
# (4) 	Implement code for Francis method for age and length re-weighting.
# (5) 	Check creation of length data (R file): producing outputs as expected?
# (6) 	Check estimation of M: No age-comp data so this should be hard to estimate.
# (7) 	Try estimating growth, but not M. Assume M = 0.2 as per other assessments.
# (8)	 	Get better growth estimates! Will require sex-specific age-comp data.
# (9) 	Try different values of M.
# (10) 	Check male vs. female growth from raw data and size at age 1 or 2,
#				... remember this can be changed.
# (11) 	Add a lot more weight to the spawning-recruit index: This should be believed more!
# (12) 	Upweight all the indices, see if that makes a change.