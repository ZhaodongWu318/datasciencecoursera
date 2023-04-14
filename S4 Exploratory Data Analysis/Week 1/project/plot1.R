rm(list=ls())

# Load data
dat_obj <- readRDS("data_required.rds")

# Create Plot
png("plot1.png", width=480, height=480)
with(dat_obj, hist(as.numeric(Global_active_power), col = "red", 
                   border="black", xlab = "Global Active Power (kilowatts)",
                   ylab = "Frequency", main = "Global Active Power", freq = TRUE))

dev.off()