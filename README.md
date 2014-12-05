Snapper Stock Assessment and Simulation Modelling
=================================================

Stock Assessment Modelling, Simulation Testing, and Management Strategy Evaluation, for the Western Victorian Snapper stock by Mezo Research, Australia.  

## Table of contents
- [Overview](#stock-assessment)
- [Assessment Modelling](#assessment-model)
- [Simulation Testing](#simulation-testing)
- [Management Strategy Evaluation](#management-strategy-evaluation)
- [Recreational fishing effort survey](#recreational-fishing-effort-survey)

## Overview
The Victorian snapper fishery is divided into eastern and western stocks for management purposes. The two stocks are managed separately by the Department of Environment and Primary Industries (Fisheries Victoria). This project focusses on the *Western Victorian* snapper fishery which encompasses waters from the west of Wilsons Promontory to the South Australian and Victorian border, including Port Phillip Bay and Western Port Bay. The Victorian snapper fishery is multi-sectoral (it comprises both commercial and recreational components) and multi-jurisdictional (the commercial sector is subject to both Victorian and Commonwealth licensing arrangements).

## Assessment Modelling
A pilot stock assessment model for the Western Victorian snapper stock is implemented using Stock Synthesis Version 3 (SS3, [Methot and Wetzel, 2013](http://dx.doi.org/doi:10.1016/j.fishres.2012.10.012)). The test-case models (see the `folder` assess) are configured to describe a one-stock, one-area fishery with multiple 'fleets', and thus t upon the 'areas as fleets' method to account for spatial disagregation among the fishing pressures  ([Cope and Punt, 2011](http://dx.doi.org/10.1016/j.fishres.2010.10.002)).

Integrated stock assessment modelling of the form presented here, allows for quantitative assessments of fish stocks drawing on multiple data sets. This is the first time integrated stock assessment modelling techniques have been used to assess Victoria’s western snapper stock. The development of state-of-the-art stock assessment and simulation tools for the Western Victorian snapper stock will provide key fishery stakeholders provide better long-term management of the fishery.

## Simulation Testing
A simulation testing framework for the Western Victorian snapper stock is being developed with the use of `ss3sim`, an R package that facilitates reproducible, flexible, and rapid end-to-end simulation testing with SS3 ([Anderson et al. 2014](http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0092725)).

## Management Strategy Evaluation
Management Strategy Evaluation (MSE) is a technique for assessing the performance of a particular management approach against pre-defined management goals. The MSE approach involves specifiying the objectives for the management (which may involve ecological, social and economic dimensions) applying the management measures to the fishery, asessing the performance of the management through data collection and stock assessment modelling, and evaluating those performance measures against pre-defined objectives. 

In practice, only one management strategy can be implemented in a real-world fishery at any given time. So that alternative candidate management strategies can be compared, MSE typically employs simulation modelling of a fishery and its biological and/or socioeconomic components. The MSE approach explicitly seeks to identify and model uncertainties, and understand how those uncertainties may affect performance measures.

The development of a Management Strategy Evaluation for the Western Victorian Snapper stock is scheduled for 2015.

### Developing MSE Tools

Figure 1: Designing an MSE framework for the the Western Victorian Snapper fishery. Adapted from [Schnute et al. 2007](doi: 10.1093/icesjms/fsm109) ![Mezo Research MSE Framework Diagram](https://github.com/mezo-research/snapper/raw/master/src/common/images/mse-framework.png "Snapper MSE Framework")

## Recreational fishing effort survey
Fisheries Victoria are currently engaged in a monitoring program for the recreational snapper fishery, using video cameras at the five major boat ramps in Port Phillip Bay. The cameras are currently collecting an image every minute, which will translate to approximately 1 million images by mid 2015. As comprehensive human analysis of all the images is infeasible, a subsampling methodology will be required.

Fisheries Victoria will engage MEZO Research to develop a technique for sampling the image data from the cameras. MEZO will have access to the raw data in a SQL database (or similar). Key questions include:
- what level of survey is needed to give an acceptable estimate of total fishing effort?
- what are the relative cost implications of human checking vs image recognition software?
- How should the current camera arrangement be modified for the best results from future surveys?

MEZO will develop a data sampling methodology to give a >95% reliable estimate of the true effort. This will require a certain amount of truthing against human-validated results. 
