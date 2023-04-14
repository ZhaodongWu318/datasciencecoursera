rm(list=ls())

# Load data
dat_obj <- readRDS("data_required.rds")

# Create Plot
png("plot2.png", width=480, height=480)
with(dat_obj, plot(Timestamp, Global_active_power, type = "l", xlab = "", 
                   ylab = "Global Active Power (kilowatts)"))

dev.off()