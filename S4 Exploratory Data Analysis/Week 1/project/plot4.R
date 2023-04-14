rm(list=ls())

# Load data
dat_obj <- readRDS("data_required.rds")

# Create Plot
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
with(dat_obj, plot(Timestamp, Global_active_power, type = "l", xlab = "", 
                   ylab = "Global Active Power"))
with(dat_obj, plot(Timestamp, Voltage, type = "l", xlab = "datetime", 
                   ylab = "Voltage"))

with(dat_obj, plot(Timestamp, Sub_metering_1, type = "l", xlab = "", 
                   ylab = "Energy sub metering"))
with(dat_obj, lines(Timestamp, Sub_metering_2, type = "l", col = "red"))
with(dat_obj, lines(Timestamp, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty = 1, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex = 0.9, bty = "n")

with(dat_obj, plot(Timestamp, Global_reactive_power, type = "l", xlab = "datetime", 
                   ))

dev.off()

