# ------------------------------------------------------------------
# R functions to extract ramp camera images for sample viewing.
# Extraction follows samplng algorithms with specified parameters.
#
# Athol Whitten, athol.whitten@mezo.com.au
# and Michael Smith, michael.smith@mezo.com.au
#
# Last Updated: May 2017
# ------------------------------------------------------------------

# Define function to locate archive images, extract, and create new directories for images and samples:
extract_images <- function(base_dir){

  archive_dir <- file.path(base_dir, "Archive")
  unzip_dir   <- file.path(base_dir, "Extracted")

  # Create new directories:
  dir.create(unzip_dir)

  # Get a list of all zipped files in the working directory:
  zip_list <- list.files(archive_dir, full.names = TRUE, recursive = TRUE)

  # Apply unzip() to each zipped file, and extract images to 'Extracted' folder:
  lapply(zip_list, unzip, exdir = unzip_dir)

  # Get list of paths for each extracted image:
  file_paths <- list.files(unzip_dir, full.names = TRUE, recursive = TRUE)
  
  return(file_paths)
}
  
# Define function to extract image information frame a file path:
get_image_info <- function(path){
  
  name <- basename(path)
  
  string_split <- unlist(strsplit(name, "_"))
  
  camera <- string_split[1]
  date <- as.Date(string_split[2])
  hour <- as.numeric(string_split[3])
  
  year <- as.numeric(format(date, "%Y"))
  year_month <- format(date, "%Y-%m")
  month <- as.numeric(format(date, "%m"))
  day <- as.numeric(format(date, "%d"))
  weekday <- weekdays(date)
  date_hour <- paste0(date, "-", hour)
  
  date <- format(date, "%Y-%m-%d")
  
  new_row <- cbind(Path = path, 
                   Name = name, 
                   Camera = camera, 
                   Date = date, 
                   Year = year, 
                   Year_Month = year_month,
                   Month = month, 
                   Day = day, 
                   Weekday = weekday, 
                   Hour = hour,
                   Date_Hour = date_hour)
  
  return(new_row)
}

# Define function to compile image info from multiple files:
compile_image_info <- function(file_paths){
  
  # Apply get_image_info() function to each file path:
  image_info <- sapply(file_paths, get_image_info)
  image_data <- as.data.frame(t(image_info), row.names = 1:length(file_paths))
  names(image_data) <- c("Path", "Name", "Camera", "Date", "Year", "Year_Month","Month", "Day", "Weekday", "Hour", "Date_Hour")
  
  return(image_data)
  
}

# Define function to sample images, with number of weekdays, weekends, and high/low periods specified by the user:
random_sample <- function(image_data, nwe=2, nwd=3, 
                          randomize_each = TRUE, 
                          target_effort = TRUE, 
                          low_period = c(0:3, 20:23),
                          high_period = c(4:7, 16:19)){
  
  output_hours <- unique(image_data$Hour)
  
  data_weekend <- image_data[which(image_data$Weekday %in% c("Saturday", "Sunday")), ]
  data_weekday <- image_data[which(image_data$Weekday %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")), ]
  
  dates_weekday <- unique(data_weekday$Date)
  dates_weekend <- unique(data_weekend$Date)
  
    if(randomize_each == FALSE){
      subsample_weekend <- sample(1:length(dates_weekend), nwe, replace=F)
      subsample_weekday <- sample(1:length(dates_weekday), nwd, replace=F)
    }
  
  # Create vector to store list of date-hours for sampling:
  sample_hours <- vector(mode = "character")
  
  for(i in 1:length(output_hours)){
    
    if (randomize_each == TRUE) {
      if (target_effort == TRUE) {
        
        if (any(low_period == i)) {
          
          subsample_weekend <- sample(1:length(dates_weekend), (nwe - 1), replace = F)
          subsample_weekday <- sample(1:length(dates_weekday), (nwd - 1), replace = F)
        }
        
        if (any(high_period == i)) {
          
          subsample_weekend <- sample(1:length(dates_weekend), (nwe + 1), replace = F)
          subsample_weekday <- sample(1:length(dates_weekday), (nwd + 1), replace = F)
        }
        
        if ((!any(low_period == i)) && (!any(high_period == i))) {
          
          subsample_weekend <- sample(1:length(dates_weekend), nwe, replace = F)
          subsample_weekday <- sample(1:length(dates_weekday), nwd, replace = F)
        }
      }
      
      else {
        
        subsample_weekend <- sample(1:length(dates_weekend), nwe, replace=F)
        subsample_weekday <- sample(1:length(dates_weekday), nwd, replace=F)
      }
    }
    
    # For each hour (i) from the vector of hours used in this month, get the sub-sampled days:
    for(j in 1:length(subsample_weekend)) {
      sample_hours <- append(sample_hours, paste0(dates_weekend[subsample_weekend[j]], "-", output_hours[i]))
    }
    
    for(k in 1:length(subsample_weekday)) {
      sample_hours <- append(sample_hours, paste0(dates_weekday[subsample_weekday[k]], "-", output_hours[i]))
    }
    
  }
  # Return the resulting vector.
  return(sample_hours)
}

# Define function to sample and copy images to 'sample' folder:
sample_images <- function(image_data, sample_dir, nwe = 2, nwd =3, target_effort = TRUE, randomize_each = TRUE){
  
  # Get list of sample images (by date and hour):
  image_list <- random_sample(image_data, 
                              nwe = nwe, 
                              nwd = nwd, 
                              target_effort = target_effort, 
                              randomize_each = randomize_each)

  # Get list of images to be viewed:
  image_sample <- image_data[which(image_data$Date_Hour %in% image_list) ,]

  # Copy file paths and paste into new sample directory:
  file.copy(from = as.character(image_sample$Path), to = sample_dir)

  # Create a blank data frame, with image info and blank columns for adding information once images are viewed:
  sample_data <- cbind(image_sample, Launches = 0)
  write.csv(sample_data, file = file.path(sample_dir, paste0("Blank_Image_Data_", image_data$Year_Month[1], ".csv")))

}

# Define wrapper function to run other functions by month:
extract_images_monthly <- function(base_dir, nwe = 2, nwd = 3, target_effort = TRUE, randomize_each = TRUE){
  
  file_paths <- extract_images(base_dir)
  image_data <- compile_image_info(file_paths)
  unique_months <- unique(image_data$Year_Month)
  
  for(m in unique_months){
    
    image_data_month <- image_data[which(image_data$Year_Month == m) ,]
    sample_dir <- file.path(base_dir, "Sample", m)
    dir.create(sample_dir)
    sample_images(image_data_month, sample_dir = sample_dir, nwe = nwe, nwd = nwd, target_effort = target_effort, randomize_each = randomize_each)
    
  }
}

# EOF.