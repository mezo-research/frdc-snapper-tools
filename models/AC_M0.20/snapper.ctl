# SSV3.24S
# Control File
# C Western Victorian Snapper Stock Assessment, 2013
# C Athol Whitten, Mezo Research, athol.whitten@mezo.com.au
# C Fleet Information Placeholder

1 #_N_Growth_Patterns
1 #_N_Morphs_Within_GrowthPattern 

0 #_Nblock_Patterns
# Consider time-blocking as an option if good reason to expect change in gear-selectivity or biology.

# Biological specifications
0.5   #_Fracfemale 
0     #_NatM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
1     #_GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_speciific_K; 4=not implemented
1     #_Growth_Age_for_L1
999   #_Growth_Age_for_L2 (999 to use as Linf)
0     #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0     #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
1     #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=read fec and wt from wtatage.ss
1     #_First_Mature_Age
1     #_Fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0     #_Hermaphroditism option:  0=none; 1=age-specific fxn
3     #_Parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3= M and CV old offset to young same sex (as per SS2 V1.x)
1     #_Env/block/dev_adjust_method (1=standard; 2=logistic transform keeps in base parm bounds; 3=standard w/ no bound check)

# Mortality and growth parameters
#LO		HI		INIT	PRIOR  PR_ty SD PHASE env-variable	use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
0.10	0.30	0.20	0.2		-1	0.8	 	-2		0	0	0	0	0.5		0	0	# M young	
4		12		8		12	    -1	0.8	 	 3		0	0	0	0	0.5		0	0	# Lmin
70		100		83	    83		-1	0.8	 	 2		0	0	0	0	0.5		0	0	# Lmax
0.05	0.25	0.10	0.10	-1	0.8	 	 3		0	0	0	0	0.5		0	0	# VBK
0.01	0.25	0.1		0.1		-1	0.8	 	 3		0	0	0	0	0.5		0	0	# CV young
-3		3		0		0		-1	0.8	 	 3		0	0	0	0	0.5		0	0	# CV old: exp offset to CV young

# Males (Offset to Females)
-3		3		0		0		-1	0.8		-3		0	0	0	0	0.5		0	0	# M young: exp offset to morph 1
-3		3		0		0		-1	0.8		 3		0	0	0	0	0.5		0	0	# Lmin: exp offset to morph 1
-3		3		0		0		-1	0.8		 2		0	0	0	0	0.5		0	0	# Lmax: exp offset to morph 1
-3		3		0		0		-1	0.8		 3		0	0	0	0	0.5		0	0	# VBK: exp offset to morph 1
-3		3		0		0		-1	0.8		 4		0	0	0	0	0.5		0	0	# CV young: exp offset to morph 1
-3		3		0		0		-1	0.8		 4		0	0	0	0	0.5		0	0	# CV old: exp offset to CV young (male)

# Weight-length and maturity parameters (L in cm, W in kg)
# Females
# Lo	Hi	 	Init	Prior Prior		Prior	Param	Env	Use	Dev		Dev		Dev	Block	block
# bnd	bnd  	value	mean  type		SD		phase	var	dev	minyr	maxyr	SD	design	switch
-3		3		0.000045 	0	-1		0.8		-3		0	0	0	0	0.5		0	0	# W-L scale (Female) (Parameter A in W=A*L^B, Weight in kg)
 1		4		2.795		0	-1		0.8		-3		0	0	0	0	0.5		0	0	# W-L power (Female) (Parameter B in W=A*L^B, Weight in kg)
 25		50		36.3		0	-1		0.8		-3		0	0	0	0	0.5		0	0	# Len at 50% maturity (Logistic curve inflection point (size at 50% Maturity), in cm)
-6		3  		-0.25		0	-1		0.8		-3		0	0	0	0	0.5		0	0	# Maturity slope (Logistic curve slope, must have a negative value)
-3		3		1			0	-1		0.8		-3		0	0	0	0	0.5		0	0	# Intercept eggs/gm
-3		3		0			0	-1		0.8		-3		0	0	0	0	0.5		0	0	# Slope eggs/gm

-3		3		0.000047 	0 	-1		0.8		-3		0	0	0	0	0.5		0	0	# W-L scale (Male) (Parameter A in W=A*L^B, Weight in kg)
 1		4		2.780		0	-1		0.8		-3		0	0	0	0	0.5		0	0	# W-L power	(Male) (Parameter B in W=A*L^B, Weight in kg)

# Distribute recruitment among growth pattern x area x season
-4 		4 		0 			0 	-1 		99 		-3 		0 	0 	0 	0	0.5 	0 	0 	# RecrDist_GP_1	
-4 		4 		0 			0 	-1 		99 		-3 		0 	0 	0 	0 	0.5 	0 	0 	# RecrDist_Area_1
-4 		4 		0 			0 	-1 		99 		-3 		0 	0 	0 	0	0.5 	0 	0 	# RecrDist_Seas_1

# Cohort growth (K) deviation parameter
0.5   	1.5 	1 			1 	-1 		99 		-5 		0 	0 	0 	0 	0.5 	0 	0 	# CohortGrowDev

# Ageing error matrix parameters
 0 		2 		1 			3 	-1 		99 		-4 		0 	0 	0 	0 	0 		0 	0	# Age_Key_Parm_1_Start_Age
-2	 	5 		0.25		1 	-1 		99	 	-4 		0 	0 	0 	0 	0 		0 	0 	# Age_Key_Parm_2_Bias_Start_Age
-3 		5 		1.25		1 	-1 		99	 	-4 		0 	0 	0 	0 	0 		0 	0 	# Age_Key_Parm_3_Bias_Max_Age
 0.01 	5 		1 			1 	-1 		99 		-4 		0 	0 	0 	0 	0 		0 	0 	# Age_Key_Parm_4_Power_Fxn_Coef_Btwn_P1_P2 (0 = Linear)
 0.01 	5 		2 			1 	-1 		99	 	-4 		0 	0 	0 	0 	0 		0 	0 	# Age_Key_Parm_5_Stdv_Start_Age
 0.01 	5 		4 			1 	-1 		99	 	-4 		0 	0 	0 	0 	0 		0 	0 	# Age_Key_Parm_6_Stdv_Max_Age
 0.01 	5 		1 			1 	-1 		99	 	-4 		0 	0 	0 	0 	0 		0 	0 	# Age_Key_Parm_7_Power_Fxn_Coef_Btwn_P5_P6 (0 = Linear)
 
# Seasonal_effects_on_biology_parms
0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K

# MG_Deviations Parm Phase (CONDITIONAL, if any MG parameters use annual-devs, then estimation for the deviations will begin in this phase)
#4

# Spawner-recruit parameters
3 #_SR_function: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm
# Lo	Hi		Init	Prior	Prior	Prior	Param
# bnd	bnd		value	mean	type	SD		phase
 4		12		8		0		-1		10	 	 1		# Ln(R0)	# SR_R0
 0.2	1		0.8		0		-1		0.8		-2		# Steepness # SR_steep
 0		2		0.8		0		-1		0.8		-3		# Sigma R	# SR_sigmaR
-5		5		0		0		-1		1		-3		# Environmental link coefficient		# SR_envlink
-5		5		0		0		-1		1		-4		# Initial equilibrium offset to virgin	# SR_R1_offset
0.0		0.5		0.0		0		-1		99		-2 		#_Reserve for future autocorrelation	# SR_autocorr

# Spawner-recruit set-up
0		#_SR_env_link
0 		#_SR_env_target_0=none;1=devs;_2=R0;_3=steepness

1		# do_recr_dev:  0=none; 1=devvector; 2=simple deviations
1980	# first year of main recr_devs; early devs can preceed this era
2012	# last year of main recr_devs; forecast devs start in following year
4 		#_recdev phase
1 		# (0/1) to read 13 advanced options
0 		#_recdev_early_start (0=none; neg value makes relative to recdev_start)
-4 		#_recdev_early_phase
0 		#_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
1000 	#_lambda for prior_fore_recr occurring before endyr+1
1947 	#_last_early_yr_nobias_adj_in_MPD
1995 	#_first_yr_fullbias_adj_in_MPD
2011 	#_last_yr_fullbias_adj_in_MPD
2025 	#_first_recent_yr_nobias_adj_in_MPD
0.97	#_max_bias_adj_in_MPD
0.0  	# period for recruitment cycles - use only if modelling seasons as years 
-15 	#min rec_dev
15 		#max rec_dev
0 		#_read_recdevs
# End of advanced SR options

#Fishing Mortality info 
0.1		# F ballpark for tuning early phases
2000 	# F ballpark year (neg value to disable)
3 		# F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
4		# max F or harvest rate, depends on F_Method
5 		#N iterations for tuning F in hybrid method (recommend 3 to 7)

# Initial_F_parms
#LO 	HI	INIT PRIOR	PR_type 	SD		PHASE
0.00	1	0.05	0 		-1 		99 		1		# Long_Line
0.00	1 	0.05 	0 		-1 		99 		1		# Haul_Seine
0.00	1	0.05	0	 	-1 		99 		1		# Comm_Other
0.00 	1 	0.05 	0 		-1 		99 		1		# RR_Pink
0.00	1	0.05	0	 	-1 		99 		1		# RR_Adult
0.00 	1 	0.05	0 		-1 		99 		1		# Rec_Other

# 0		1	0.0		0 		-1 		99 		-1		# Long_Line
# 0 	1 	0.0 	0 		-1 		99 		-1		# Haul_Seine
# 0		1	0.0		0	 	-1 		99 		-1		# Comm_Other
# 0 	1 	0.0 	0 		-1 		99 		-1		# RR_Pink
# 0		1	0.0		0	 	-1 		99 		-1		# RR_Adult
# 0 	1 	0.0		0 		-1 		99 		-1		# Rec_Other

# Q_setup
# Q_type options:  <0=mirror, 0=float_nobiasadj, 1=float_biasadj, 2=parm_nobiasadj, 3=parm_w_random_dev, 4=parm_w_randwalk, 5=mean_unbiased_float_assign_to_parm
0 0 0 0 # 1 Long_Line
0 0 0 0 # 2 Haul_Seine
0 0 0 0 # 3 Comm_Other
0 0 0 0 # 4 RR_Pinky
0 0 0 0 # 5 RR_Adult
0 0 0 0 # 6 Rec_Other
0 0 0 0 # 7 Zero_Survey

# Size_selex_types
# Discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead
# Pattern Discard Male Special
1 	0 	0 	0 	# 1 Long_Line
24 	0 	0 	0 	# 2 Haul_Seine
5 	0 	0 	2 	# 3 Comm_Other
24 	0 	0 	0 	# 4 RR_Pinky
1 	0 	0 	0 	# 5 RR_Adult
5 	0 	0 	5 	# 6 Rec_Other
33 	0 	0 	0 	# 7 Zero_Survey

# Age_selex_types
# Pattern :: Male Special
10 0 0 0 # 1 Long_Line
10 0 0 0 # 2 Haul_Seine
10 0 0 0 # 3 Comm_Other
10 0 0 0 # 4 RR_Pinky
10 0 0 0 # 5 RR_Adult
10 0 0 0 # 6 Rec_Other
10 0 0 0 # 7 Zero_Survey

# Size_selex_parms
# LO 	HI 		INIT 	PRIOR PR_type SD PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn

# Size_Selex_Parms 1: Long_Line (Logistic)
20		80		45		0		-1		99		2	0	0	0	0	0.5		0	0	# 1 Inflection point
1		22		12		0		-1		99		3	0	0	0	0	0.5		0	0	# 2 Width

# Size_Selex_Parms 2: Haul_Seine (Double Normal)
 20		40		 30		0 		-1 		99 		2 	0 	0 	0 	0 	0.5 	0 	0 	# 1 Peak
-30		0		-15	 	0		-1		99 		3 	0 	0 	0 	0 	0.5 	0 	0	# 2 Top
 0		5		 2.5 	0		-1		99		4	0	0	0	0	0.5		0	0	# 3 Asc - width
-1		9		 4	 	0		-1		99		3	0	0	0	0	0.5		0	0	# 4 Desc - width
-25	  -10		-15	 	0		-1		99		5	0	0	0	0	0.5		0	0	# 5 Init
-15		5		-5	 	0		-1		99		5	0	0	0	0	0.5		0	0	# 6 Final

# Size_Selex_Parms 3: Comm_Other (Mirror 2: Haul_Seine)
0 		0 		0 		0 		-1 		99 		-1 	0 	0 	0 	0 	0.5 	0 	0 	# 1 Inflection point
0 		0 		0 		0 		-1 		99 		-1 	0 	0 	0 	0 	0.5 	0 	0 	# 2 Width

# Size_Selex_Parms 4: RR_Pinky (Double Normal)
 15		35		 25		0 		-1 		99 		2 	0 	0 	0 	0 	0.5 	0 	0 	# 1 Peak
-20		10		-15	 	0		-1		99 		3 	0 	0 	0 	0 	0.5 	0 	0	# 2 Top
-1		5		 2	 	0		-1		99		4	0	0	0	0	0.5		0	0	# 3 Asc - width
-1		7		 3	 	0		-1		99		3	0	0	0	0	0.5		0	0	# 4 Desc - width
-10		0		-5	 	0		-1		99		5	0	0	0	0	0.5		0	0	# 5 Init
-9		3		-3	 	0		-1		99		5	0	0	0	0	0.5		0	0	# 6 Final

# Size_Selex_Parms 5: RR_Adult (Logistic)
20		44		32		0		-1		99		2	0	0	0	0	0.5		0	0	# 1 Inflection point
8		16		12		0		-1		99		3	0	0	0	0	0.5		0	0	# 2 Width

# Size_Selex_Parms 6: Rec_Other (Mirror 5: RR_Adult)
0 		0 		0 		0 		-1 		99 		-1 	0 	0 	0 	0 	0.5 	0 	0 	# 1
0 		0 		0 		0 		-1 		99 		-1 	0 	0 	0 	0 	0.5 	0 	0 	# 2

# Size_Selex_Parms 7: Otter_Survey (Double Normal)
# No parms required here: set as Special Selectivity Pattern 33; Expecting only 0+ fish.

# Cond: Custom_sel-env_setup
# Cond: 2 2 0 0 -1 99 -2 #_placeholder when no enviro fxns

# Cond: Selex time-block setup:
#1  #(0=Read one line apply all, 1=read one line each parameter)

# Tag loss and tag reporting
0  # 0=no read; 1=read if tags exist

### Likelihood related quantities ###
# Variance adjustments to input values
1 #_Variance_adjustments_to_input_values
# Fleets 1, 2, 3, 4, 5, 6, and Survey 7
0.000 0.000 0.000 0.000 0.000 0.000 0.000   # constant added to survey CV 
0.000 0.000 0.000 0.000 0.000 0.000 0.000   # constant added to discard SD
0.000 0.000 0.000 0.000 0.000 0.000 0.000   # constant added to body weight SD
1.000 1.000 1.000 1.000 1.000 1.000 1.000   # multiplicative scalar for length comps
1.000 1.000 1.000 1.000 1.000 1.000 1.000   # multiplicative scalar for agecomps
1.000 1.000 1.000 1.000 1.000 1.000 1.000   # multiplicative scalar for length at age obs
  
2	# Max number of lambda phases: read this number of values for each component below
1	# SD offset (CPUE, discard, mean body weight, recruitment devs): 0=omit log(s) term, 1=include

13 # number of changes to make to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 
# 9=init_equ_catch; 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin
#like_comp fleet/survey  phase  value  sizefreq_method
# Lambda values for length data
4  	1 	1 	0.25 	1
4  	2 	1 	0.25 	1
4  	4 	1 	0.25 	1
4  	5 	1 	0.25 	1
# Lambda values for age data
5  	1 	1 	0.25 	1
5  	2 	1 	0.25 	1
5  	4 	1 	0.25 	1
5  	5 	1 	0.25 	1
# Lambda values for YOY survey
1   1	1	2.0 	1
1	2	1	2.0		1
1	4	1	2.0		1
1	5	1	2.0		1
1   7   1   5.0		1

0 # (0/1) read specs for more stddev reporting 
999 # EOF

# Note: There is no male or female data, so it seems strange to estimate male offsets in growth parameters. 
# Females and males may have to be the same... for growth (for now). Note: Ling model est. offsets with no sex-specific data.
# Entering the age-comp data with sex-specific information might help with this.

# Things to do:
# (1) Add extra ageing error, and try use of parameters for age-matrices, as per simple example.
# (2) Make male and female growth parameters the same (or males with fixed zero offsets).
# (3) Downweight the ageing data.
# (4) Implement code for Francis method for age and length re-weighting.
# (5) Check creation of length data (R file): producing outputs as expected?
# (6) Check estimation of M: No age-comp data so this should be hard to estimate.
# (7) Try estimating growth, but not M. Assume M = 0.2 as per other assessments.
# (8) Get better growth estimates! Will require sex-specific age-comp data.
# (9) Try different values of M.
# (10) Check male vs. female growth from raw data and size at age 1 or 2 and remember this can be changed.
# (11) Add a lot more weight to the spawning-recruit index: This should be believed more!
# (12) Upweight all the indices, see if that makes a change.
