
Western Victorian Snapper Modelling Project
============================================

Stock Assessment Modelling, Simulation Testing, and Management Strategy Evaluation for the Western Victorian snapper fishery. By Mezo Research, Australia.

**Note:** *This is a draft document under development as part of the above mentioned project. It is not intended to be used for anything other than information to interested parties. Do not cite without explicit permission from the authors at Mezo Research.*

- [Overview](#stock-assessment)
- [Assessment Modelling](#assessment-modelling)
- [Simulation Testing](#simulation-testing)
- [Management Strategy Evaluation](#management-strategy-evaluation)
- [Recreational Fishing Effort Survey](#recreational-fishing-effort-survey)

## Overview
The Victorian snapper fishery is divided into eastern and western stocks for management purposes. Each stock is managed separately by the Department of Environment and Primary Industries (Fisheries Victoria). This project focusses on the Western Victorian snapper stock which encompasses waters from the west of Wilsons Promontory to the South Australian and Victorian border, including Port Phillip Bay and Western Port Bay. The Victorian snapper fishery is multi-sectoral (it comprises both commercial and recreational components) and multi-jurisdictional (the commercial sector is subject to both Victorian and Commonwealth licensing arrangements).

## Assessment Modelling
A pilot stock assessment model for the Western Victorian snapper stock is implemented using Stock Synthesis Version 3 (SS3, [Methot and Wetzel, 2013](http://dx.doi.org/doi:10.1016/j.fishres.2012.10.012)) Test-case models (see `folder` assess) are configured to describe a single-stock, single-area fishery with multiple fishing and survey 'fleets'. This approach draws upon the 'areas as fleets' method to account for spatial disagregation among fishery and survey based data sources ([Cope and Punt, 2011](http://dx.doi.org/10.1016/j.fishres.2010.10.002)).

Integrated stock assessment modelling permits quantitative analyses of fish stocks whilst drawing upon multiple data sets. This is the first time integrated stock assessment modelling techniques have been used to assess Victoria’s western snapper stock. The development of a suite of modelling tools for stock assessment and simulation of the Western Victorian snapper stock will enable better long-term management of this important fishery.

## Simulation Testing
A simulation testing framework for the Western Victorian snapper stock is being developed with the use of `ss3sim`, an R package that facilitates reproducible, flexible, and rapid end-to-end simulation testing with SS3 ([Anderson et al. 2014](http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0092725)).

### Prototyping
1. Simulation set-up
2. Testing procedure
3. Example simulation outputs

## Management Strategy Evaluation
A Management Strategy Evaluation (MSE) framework and modelling tool for the Western Victorian Snapper stock is being developed to assess the performance of alternative management procedures against pre-defined objectives. MSE modelling frameworks allow managers and other stakeholders to test a range of management procedures and performance indicators in both a conceptual and simulation modelling context. Management objectives in a fishery context often encompass ecological, social, and economic dimensions, meaning a range of considerations must be made when developing a fishery MSE framework.  In a real-world fishery, only one management strategy can be implemented at any given time. So that alternative candidate management strategies can be compared, MSE typically employs simulation modelling of a fishery and its biological and/or socioeconomic components. The MSE approach explicitly seeks to identify and model uncertainties, and to improve understanding of how those uncertainties may affect performance measures and thus management. The development of an MSE framework for the Western Victorian Snapper stock will allow fishery managers, scientists, industry representatives, and other key stakeholders to collective inform the development of robust management streatgies for this important fishery. 

### Developing Simulation Tools
Figure 1: Designing an MSE framework for the Western Victorian Snapper fishery. Adapted from [Schnute et al. 2007](http://doi.org/10.1093/icesjms/fsm109) 

![Mezo Research MSE Framework Diagram](https://github.com/Mezo-research/snapper/blob/master/images/mse-framework.png "Proposed Snapper MSE Framework")

### Candidate Harvest Strategies
A wide range of harvest strategies, harvest control rules, and management procedures are employed around the world for fisheries management. This project will review and consider the most successful strategies and test those in a simulation framework for the Western Victorian Snapper stock. 

## Recreational Fishing Effort Survey
Many coastal and estuarine fisheries around Australia are now dominated by recreational fishing. This poses a problem for assessment and sustainable fisheries management because recreational catch and effort are difficult to track. While creel surveys and diary angler-type approaches can provide information on catch composition and catch rates, critical information on fishing effort is generally missing. This element of the project trialled the use of boat ramp cameras to obtain data on overall recreational boat fishing effort in Port Phillip Bay and the adjacent Western Port Bay in Victoria, Australia.

Using video cameras at five major boat ramps in Port Phillip Bay, Fisheries Victoria collected approximately one image every two minutes at each camera. This image capture rate results in approximately one million images being collected and stored every 12 months. As comprehensive human analysis of this many images is infeasible, a subsampling methodology and image analsysis technique was developed. Mezo Research investigated alternative techniques for sampling image data and developed simple methods to extract randomly sampled images from Fisheries Victoria databases. The key questions considered were:

1. What level of survey image sub-sampling is required to provide an accurate and reliable estimate of total recreational fishing effort?
2. What are the relative cost implications of human checking vs image recognition software?
3. How should the current camera arrangement be modified to ensure good results from future surveys?

Mezo performed sub-sampling estimates of total effort using 20-50 percent of the total available images, and tested randomization routines using whole days or hourly blocks of images. Mezo also developed a sub-sampling routine to focuss more effort on expected times of increased activity (pre-dawn and pre-dusk). Sampling in hourly blocks randomized across all days of the study produced estimates with greater than 80 percent accuracy using less than 30 percent of total images, although the error rate increased as the total effort in the underlying data decreased. Further improvements were made to overall effort estimates when targeting sampling effort on high activity periods. An alternative approach to reducing the total number of images is to use activity sensor software that is programmed so that ramp cameras take images only when a specific type of motion is detected in a set field of view. The activity sensor method produced results that were consistent with the continuous image sampling, but required 75-90% fewer images to be captured and viewed.

Full results of this study will be made available as part of the final FRDC report related to this project.

