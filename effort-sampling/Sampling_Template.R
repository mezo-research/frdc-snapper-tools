# ------------------------------------------------------------------
# R functions to extract ramp camera images for sample viewing.
# This script configured to run for any given time period.
# Sampling parameters currently set for a single month of sampling.
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
file_paths <- extract_images(base_dir)

# Compile image info from paths listed above:
image_data <- compile_image_info(file_paths)

# Sample images based on image data:
sample_images(image_data, sample_dir = sample_dir, nwe = number_weekends, nwd = number_weekdays, target_effort = target_effort, randomize_each = randomize)

# EOF.