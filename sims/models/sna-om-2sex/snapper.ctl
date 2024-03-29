#V3.24O
#_data_and_control_files: snapper.dat // snapper.ctl
#_SS-V3.24O-opt-win64;_04/10/2013;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_11.1
1  #_N_Growth_Patterns
1 #_N_Morphs_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
#_Cond 0  #  N recruitment designs goes here if N_GP*nseas*area>1
#_Cond 0  #  placeholder for recruitment interaction request
#_Cond 1 1 1  # example recruitment design element for GP=1, seas=1, area=1
#
#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
0 #_Nblock_Patterns
#_Cond 0 #_blocks_per_pattern 
# begin and end years of blocks
#
0.5 #_fracfemale 
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate
  #_no additional input for selected M option; read 1P per morph
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_speciific_K; 4=not implemented
1 #_Growth_Age_for_L1
999 #_Growth_Age_for_L2 (999 to use as Linf)
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=read fec and wt from wtatage.ss
#_placeholder for empirical age-maturity by growth pattern
1 #_First_Mature_Age
1 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=age-specific fxn
3 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-GP1, 3=like SS2 V1.x)
1 #_env/block/dev_adjust_method (1=standard; 2=logistic transform keeps in base parm bounds; 3=standard w/ no bound check)
#
#_growth_parms
#_LO HI INIT PRIOR PR_type SD PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
 0.1 0.3 0.2 0.2 -1 0.8 -2 0 0 0 0 0.5 0 0 # NatM_p_1_Fem_GP_1
 4 12 8 12 -1 0.8 -3 0 0 0 0 0.5 0 0 # L_at_Amin_Fem_GP_1
 70 100 83 83 -1 0.8 -2 0 0 0 0 0.5 0 0 # L_at_Amax_Fem_GP_1
 0.05 0.25 0.1 0.1 -1 0.8 -3 0 0 0 0 0.5 0 0 # VonBert_K_Fem_GP_1
 0.01 0.25 0.1 0.1 -1 0.8 -3 0 0 0 0 0.5 0 0 # CV_young_Fem_GP_1
 -3 3 0 0 -1 0.8 -3 0 0 0 0 0.5 0 0 # CV_old_Fem_GP_1
 -3 3 0 0 -1 0.8 -3 0 0 0 0 0.5 0 0 # NatM_p_1_Mal_GP_1
 -3 3 0.738998 0 -1 0.8 3 0 0 0 0 0.5 0 0 # L_at_Amin_Mal_GP_1
 -3 3 -0.192649 0 -1 0.8 2 0 0 0 0 0.5 0 0 # L_at_Amax_Mal_GP_1
 -3 3 0.657896 0 -1 0.8 3 0 0 0 0 0.5 0 0 # VonBert_K_Mal_GP_1
 -3 3 0.855728 0 -1 0.8 4 0 0 0 0 0.5 0 0 # CV_young_Mal_GP_1
 -3 3 -2.04754 0 -1 0.8 4 0 0 0 0 0.5 0 0 # CV_old_Mal_GP_1
 -3 3 4.5e-005 0 -1 0.8 -3 0 0 0 0 0.5 0 0 # Wtlen_1_Fem
 1 4 2.795 0 -1 0.8 -3 0 0 0 0 0.5 0 0 # Wtlen_2_Fem
 25 50 36.3 0 -1 0.8 -3 0 0 0 0 0.5 0 0 # Mat50%_Fem
 -6 3 -0.25 0 -1 0.8 -3 0 0 0 0 0.5 0 0 # Mat_slope_Fem
 -3 3 1 0 -1 0.8 -3 0 0 0 0 0.5 0 0 # Eggs/kg_inter_Fem
 -3 3 0 0 -1 0.8 -3 0 0 0 0 0.5 0 0 # Eggs/kg_slope_wt_Fem
 -3 3 4.7e-005 0 -1 0.8 -3 0 0 0 0 0.5 0 0 # Wtlen_1_Mal
 1 4 2.78 0 -1 0.8 -3 0 0 0 0 0.5 0 0 # Wtlen_2_Mal
 -4 4 0 0 -1 99 -3 0 0 0 0 0.5 0 0 # RecrDist_GP_1
 -4 4 0 0 -1 99 -3 0 0 0 0 0.5 0 0 # RecrDist_Area_1
 -4 4 0 0 -1 99 -3 0 0 0 0 0.5 0 0 # RecrDist_Seas_1
 0.5 1.5 1 1 -1 99 -5 0 0 0 0 0.5 0 0 # CohortGrowDev
 0 2 1 3 -1 99 -4 0 0 0 0 0 0 0 # AgeKeyParm1
 -2 5 0.25 1 -1 99 -4 0 0 0 0 0 0 0 # AgeKeyParm2
 -3 5 1.25 1 -1 99 -4 0 0 0 0 0 0 0 # AgeKeyParm3
 0.01 5 1 1 -1 99 -4 0 0 0 0 0 0 0 # AgeKeyParm4
 0.01 5 2 1 -1 99 -4 0 0 0 0 0 0 0 # AgeKeyParm5
 0.01 5 4 1 -1 99 -4 0 0 0 0 0 0 0 # AgeKeyParm6
 0.01 5 1 1 -1 99 -4 0 0 0 0 0 0 0 # AgeKeyParm7
#
#_Cond 0  #custom_MG-env_setup (0/1)
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-environ parameters
#
#_Cond 0  #custom_MG-block_setup (0/1)
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no MG-block parameters
#_Cond No MG parm trends 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
#_Cond -4 #_MGparm_Dev_Phase
#
#_Spawner-Recruitment
3 #_SR_function: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm
#_LO HI INIT PRIOR PR_type SD PHASE
 4 12 7.42888 0 -1 10 1 # SR_LN(R0)
 0.2 1 0.8 0 -1 0.8 -2 # SR_BH_steep
 0 2 0.8 0 -1 0.8 -3 # SR_sigmaR
 -5 5 0 0 -1 1 -3 # SR_envlink
 -5 5 0 0 -1 1 -4 # SR_R1_offset
 0 0.5 0 0 -1 99 -2 # SR_autocorr
0 #_SR_env_link
0 #_SR_env_target_0=none;1=devs;_2=R0;_3=steepness
1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1980 # first year of main recr_devs; early devs can preceed this era
2012 # last year of main recr_devs; forecast devs start in following year
-1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1947 #_last_early_yr_nobias_adj_in_MPD
 1995 #_first_yr_fullbias_adj_in_MPD
 2011 #_last_yr_fullbias_adj_in_MPD
 2025 #_first_recent_yr_nobias_adj_in_MPD
 -1 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for all estimated recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -15 #min rec_dev
 15 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#DisplayOnly 0.974551 # Main_RecrDev_1980
#DisplayOnly 0.289876 # Main_RecrDev_1981
#DisplayOnly -0.00737553 # Main_RecrDev_1982
#DisplayOnly 0.112436 # Main_RecrDev_1983
#DisplayOnly 0.423311 # Main_RecrDev_1984
#DisplayOnly 0.100678 # Main_RecrDev_1985
#DisplayOnly -0.0233225 # Main_RecrDev_1986
#DisplayOnly -0.56339 # Main_RecrDev_1987
#DisplayOnly -0.985863 # Main_RecrDev_1988
#DisplayOnly -0.562171 # Main_RecrDev_1989
#DisplayOnly -0.837896 # Main_RecrDev_1990
#DisplayOnly -0.854352 # Main_RecrDev_1991
#DisplayOnly -0.534953 # Main_RecrDev_1992
#DisplayOnly 0.0555245 # Main_RecrDev_1993
#DisplayOnly -0.465566 # Main_RecrDev_1994
#DisplayOnly 1.12753 # Main_RecrDev_1995
#DisplayOnly 1.39915 # Main_RecrDev_1996
#DisplayOnly -4.30518 # Main_RecrDev_1997
#DisplayOnly 2.00974 # Main_RecrDev_1998
#DisplayOnly -0.25946 # Main_RecrDev_1999
#DisplayOnly -0.11931 # Main_RecrDev_2000
#DisplayOnly 2.08972 # Main_RecrDev_2001
#DisplayOnly 0.701134 # Main_RecrDev_2002
#DisplayOnly 0.493813 # Main_RecrDev_2003
#DisplayOnly 2.47227 # Main_RecrDev_2004
#DisplayOnly 1.8863 # Main_RecrDev_2005
#DisplayOnly -3.68248 # Main_RecrDev_2006
#DisplayOnly -0.101126 # Main_RecrDev_2007
#DisplayOnly 1.38838 # Main_RecrDev_2008
#DisplayOnly 1.63485 # Main_RecrDev_2009
#DisplayOnly 1.18904 # Main_RecrDev_2010
#DisplayOnly -1.30729 # Main_RecrDev_2011
#DisplayOnly -3.73857 # Main_RecrDev_2012
#

#Fishing Mortality info 
0.1		# F ballpark for tuning early phases
2000 	# F ballpark year (neg value to disable)
3 		# F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
4		# max F or harvest rate, depends on F_Method
5 		#N iterations for tuning F in hybrid method (recommend 3 to 7)

##Fishing Mortality info 
#0.1 # F ballpark for annual F (=Z-M) for specified year
#-2000 # F ballpark year (neg value to disable)
#3 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
#4 # max F or harvest rate, depends on F_Method
## no additional F input needed for Fmethod 1
## if Fmethod=2; read overall start F value; overall phase; N detailed inputs to read
## if Fmethod=3; read N iterations for tuning for Fmethod 3
#0.2 1 1 # overall start F value; overall phase; N detailed inputs to read
## N iterations for tuning F in hybrid method (recommend 3 to 7)
##Fleet  Year   Seas    F_value  SE     Phase
#1	1913	1	0.004	0.005	-1

#_initial_F_parms
#_LO HI INIT PRIOR PR_type SD PHASE
0 1 0.015141 0 -1 99 1 # InitF_1Long_Line
0 1 0.020022 0 -1 99 1 # InitF_2Haul_Seine
0 1 0.0152549 0 -1 99 1 # InitF_3Comm_Other
0 1 0.0264141 0 -1 99 1 # InitF_4RR_Pinky
0 1 0.00717991 0 -1 99 1 # InitF_5RR_Adult
0 1 0.00299162 0 -1 99 1 # InitF_6Rec_Other

 #0 1 0.00299162 0 -1 99 1 # InitF_6Rec_Other # added 12/16 from line above, as place holder for seemingly missing fleet CCM
 #0 1 0.00299162 0 -1 99 1 # InitF_6Rec_Other # added 12/16 from line above, as place holder for seemingly missing fleet CCM

#_Q_setup
 # Q_type options:  <0=mirror, 0=float_nobiasadj, 1=float_biasadj, 2=parm_nobiasadj, 3=parm_w_random_dev, 4=parm_w_randwalk, 5=mean_unbiased_float_assign_to_parm
#_for_env-var:_enter_index_of_the_env-var_to_be_linked
#_Den-dep  env-var  extra_se  Q_type
 0 0 0 2 # 1 Long_Line
 0 0 0 2 # 2 Haul_Seine
 0 0 0 2 # 3 Comm_Other
 0 0 0 2 # 4 RR_Pinky
 0 0 0 2 # 5 RR_Adult
 0 0 0 2 # 6 Rec_Other
 0 0 0 2 # 7 YOY_Survey
#
#_Cond 0 #_If q has random component, then 0=read one parm for each fleet with random q; 1=read a parm for each year of index
#_Q_parms(if_any);Qunits_are_ln(q)
#LO  HI    INIT    PRIOR  PR_type  SD   PHASE
-3   3      0       0       -1     99     -5    # 1 Long_Line
-3   3      0       0       -1     99     -5    # 2 Haul_Seine
-3   3      0       0       -1     99     -5    # 3 Comm_Other
-3   3      0       0       -1     99     -5    # 4 RR_Pinky
-3   3      0       0       -1     99     -5    # 5 RR_Adult
-3   3      0       0       -1     99     -5    # 6 Rec_Other
-3   3      0       0       -1     99     -5    # 7 YOY_Survey
#
#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead
#_Pattern Discard Male Special
 1 0 0 0 # 1 Long_Line
 24 0 0 0 # 2 Haul_Seine
 5 0 0 2 # 3 Comm_Other
 24 0 0 0 # 4 RR_Pinky
 1 0 0 0 # 5 RR_Adult
 5 0 0 5 # 6 Rec_Other
 33 0 0 0 # 7 YOY_Survey
#
#_age_selex_types
#_Pattern ___ Male Special
 10 0 0 0 # 1 Long_Line
 10 0 0 0 # 2 Haul_Seine
 10 0 0 0 # 3 Comm_Other
 10 0 0 0 # 4 RR_Pinky
 10 0 0 0 # 5 RR_Adult
 10 0 0 0 # 6 Rec_Other
 10 0 0 0 # 7 YOY_Survey
#_LO HI INIT PRIOR PR_type SD PHASE env-var use_dev dev_minyr dev_maxyr dev_stddev Block Block_Fxn
 20 80 44.5104 0 -1 99 2 0 0 0 0 0.5 0 0 # SizeSel_1P_1_Long_Line
 1 22 11.0351 0 -1 99 3 0 0 0 0 0.5 0 0 # SizeSel_1P_2_Long_Line
 20 40 29.7528 0 -1 99 2 0 0 0 0 0.5 0 0 # SizeSel_2P_1_Haul_Seine
 -30 0 -17.5462 0 -1 99 3 0 0 0 0 0.5 0 0 # SizeSel_2P_2_Haul_Seine
 0 5 2.82283 0 -1 99 4 0 0 0 0 0.5 0 0 # SizeSel_2P_3_Haul_Seine
 -1 9 3.62088 0 -1 99 3 0 0 0 0 0.5 0 0 # SizeSel_2P_4_Haul_Seine
 -25 -10 -17.7889 0 -1 99 5 0 0 0 0 0.5 0 0 # SizeSel_2P_5_Haul_Seine
 -15 5 -4.56702 0 -1 99 5 0 0 0 0 0.5 0 0 # SizeSel_2P_6_Haul_Seine
 0 0 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # SizeSel_3P_1_Comm_Other
 0 0 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # SizeSel_3P_2_Comm_Other
 15 35 22.8481 0 -1 99 2 0 0 0 0 0.5 0 0 # SizeSel_4P_1_RR_Pinky
 -20 10 -6.76385 0 -1 99 3 0 0 0 0 0.5 0 0 # SizeSel_4P_2_RR_Pinky
 -1 5 0.124211 0 -1 99 4 0 0 0 0 0.5 0 0 # SizeSel_4P_3_RR_Pinky
 -1 7 3.59552 0 -1 99 3 0 0 0 0 0.5 0 0 # SizeSel_4P_4_RR_Pinky
 -10 0 -4.18991 0 -1 99 5 0 0 0 0 0.5 0 0 # SizeSel_4P_5_RR_Pinky
 -9 3 -2.53848 0 -1 99 5 0 0 0 0 0.5 0 0 # SizeSel_4P_6_RR_Pinky
 20 44 33.4581 0 -1 99 2 0 0 0 0 0.5 0 0 # SizeSel_5P_1_RR_Adult
 8 16 14.3125 0 -1 99 3 0 0 0 0 0.5 0 0 # SizeSel_5P_2_RR_Adult
 0 0 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # SizeSel_6P_1_Rec_Other
 0 0 0 0 -1 99 -1 0 0 0 0 0.5 0 0 # SizeSel_6P_2_Rec_Other
#_Cond 0 #_custom_sel-env_setup (0/1) 
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no enviro fxns
#_Cond 0 #_custom_sel-blk_setup (0/1) 
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no block usage
#_Cond No selex parm trends 
#_Cond -4 # placeholder for selparm_Dev_Phase
#_Cond 0 #_env/block/dev_adjust_method (1=standard; 2=logistic trans to keep in base parm bounds; 3=standard w/ no bound check)
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
0 #_Variance_adjustments_to_input_values
#_fleet: 1 2 3 4 5 6 7 
# 0 0 0 0 0 0 0 #_add_to_survey_CV
# 0 0 0 0 0 0 0 #_add_to_discard_stddev
# 0 0 0 0 0 0 0 #_add_to_bodywt_CV
# 1 1 1 1 1 1 1 #_mult_by_lencomp_N
# 1 1 1 1 1 1 1 #_mult_by_agecomp_N
# 1 1 1 1 1 1 1 #_mult_by_size-at-age_N
#
2 #_maxlambdaphase
1 #_sd_offset
#
0 # number of changes to make to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark
#like_comp fleet/survey  phase  value  sizefreq_method
#4 1 1 0.25 1
#4 2 1 0.25 1
#4 4 1 0.25 1
#4 5 1 0.25 1
#5 1 1 0.25 1
#5 2 1 0.25 1
#5 4 1 0.25 1
#5 5 1 0.25 1
#1 1 1 2 1
#1 2 1 2 1
#1 4 1 2 1
#1 5 1 2 1
#1 7 1 5 1
#
# lambdas (for info only; columns are phases)
#  2 2 #_CPUE/survey:_1
#  2 2 #_CPUE/survey:_2
#  0 0 #_CPUE/survey:_3
#  2 2 #_CPUE/survey:_4
#  2 2 #_CPUE/survey:_5
#  0 0 #_CPUE/survey:_6
#  5 5 #_CPUE/survey:_7
#  0.25 0.25 #_lencomp:_1
#  0.25 0.25 #_lencomp:_2
#  0 0 #_lencomp:_3
#  0.25 0.25 #_lencomp:_4
#  0.25 0.25 #_lencomp:_5
#  0 0 #_lencomp:_6
#  0 0 #_lencomp:_7
#  0.25 0.25 #_agecomp:_1
#  0.25 0.25 #_agecomp:_2
#  0 0 #_agecomp:_3
#  0.25 0.25 #_agecomp:_4
#  0.25 0.25 #_agecomp:_5
#  0 0 #_agecomp:_6
#  0 0 #_agecomp:_7
#  1 1 #_init_equ_catch
#  1 1 #_recruitments
#  1 1 #_parameter-priors
#  1 1 #_parameter-dev-vectors
#  1 1 #_crashPenLambda
#  1 1 # F_ballpark_lambda
0 # (0/1) read specs for more stddev reporting 
 # 0 1 -1 5 1 5 1 -1 5 # placeholder for selex type, len/age, year, N selex bins, Growth pattern, N growth ages, NatAge_area(-1 for all), NatAge_yr, N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

