rm(list=ls())
# Check if the data exists
filename <- "exdata_data_household_power_consumption.zip"

# Check if data already exists
if (!file.exists(filename)) {
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileurl, filename, method="curl")
}

if (!file.exists("household_power_consumption.txt")) {
  unzip(filename)
}

# Load data and assign variables
dat <- read.table("household_power_consumption.txt",header = TRUE, sep = ";")
dat_obj <- subset(dat, Date %in% c("1/2/2007", "2/2/2007"))
rm(dat)

dat_obj$Date <- as.Date(dat_obj$Date, "%d/%m/%Y")
dat_obj$Timestamp <- as.POSIXct(paste(dat_obj$Date, dat_obj$Time), "%d/%m/%Y %H:%M:%S")

saveRDS(dat_obj, "data_required.rds")
