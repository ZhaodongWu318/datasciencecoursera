rm(list=ls())

# Load data
dat_obj <- readRDS("data_required.rds")

# Create Plot
png("plot3.png", width=480, height=480)
with(dat_obj, plot(Timestamp, Sub_metering_1, type = "l", xlab = "", 
                   ylab = "Energy sub metering"))
with(dat_obj, lines(Timestamp, Sub_metering_2, type = "l", col = "red"))
with(dat_obj, lines(Timestamp, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty = 1, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()