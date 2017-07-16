# ------------------------------------------------------------------
# R script to extract ramp camera images for sample viewing.
# This script configured to run for a series of months.
#
# Athol Whitten, athol.whitten@mezo.com.au
#
# Last Updated: May 2017
# ------------------------------------------------------------------

# Set base directory to top level images folder:
base_dir <- "/Users/awhitten/Working/PPB_Images"

# Set and create sampling directory:
sample_dir <- file.path(base_dir, "Sample")
dir.create(sample_dir)

# Sampling parameters:
number_weekends <- 2
number_weekdays <- 3
target_effort <- TRUE
randomize <- TRUE

# Source R functions for image extraction:
source(file.path(base_dir, 'Extract_Images.R'))

# Unzip (extract) images and return list of all image paths: 
extract_images_monthly(base_dir,
                       nwe = number_weekends,
                       nwd = number_weekdays, 
                       target_effort = target_effort, 
                       randomize_each = randomize)

# FIX: Get image data out as an object, together with the resulting sampled data.

# Addition: do count of final image sampling numbers, by hour and day, for weekend and weekdays.
# This acts as a check of the sampling, do we get a distribution of images per month that we expect?

# Should we always get the same number of images per month? Is this affected by the underlying availabiluty of images?
# Write some code to check the image_data first, check if there are enough images in that month?
# i.e. is there at least X number of images per day, and X number of weekends / weekdays.
# We need to be cautios about thresholds. Should be pretty coarse. 

# Do a count of the image_data direct from the images, show the counts. Think about the relevant thresholds. 
# If an hour has < 20. 

# How many images should we expect, ballpark? Can we do a check of this?
# Also, do a check to be sure that the same number of images are in the sample folder, AND the CSV file.

# Another problem, when Paul chose 3 wd, and 3 we, then the sampling works as expected, 
# but the CSV file leaves out the first hour for each new day. Does this repicate for me?

# Also, ask Michael, to explain the targetted effort method. How was this apportioned? 
# If this is a +/- 1 change, then the proportional change is different with different numbers of we and wd.

# EOF.



