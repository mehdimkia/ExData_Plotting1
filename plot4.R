# Load necessary library
library(data.table)

# Set working directory to the location of the dataset
setwd("file/path")

# Read data from file and handle missing values
power_data <- fread("household_power_consumption.txt", na.strings = "?")

# Convert 'Global_active_power' to numeric to prevent scientific notation
power_data[, Global_active_power := as.numeric(Global_active_power)]

# Create a POSIXct datetime column for filtering and plotting by time of day
power_data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter data for the specified date range
filtered_data <- power_data[dateTime >= "2007-02-01" & dateTime < "2007-02-03"]

# Set up the plot
png("plot4.png", width = 480, height = 480)

# Set up a 2x2 plotting area
par(mfrow = c(2, 2))

# Plot 1: Global Active Power
plot(filtered_data$dateTime, filtered_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# Plot 2: Voltage
plot(filtered_data$dateTime, filtered_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Plot 3: Energy Sub Metering
plot(filtered_data$dateTime, filtered_data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(filtered_data$dateTime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$dateTime, filtered_data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = "n", cex = 0.5)

# Plot 4: Global Reactive Power
plot(filtered_data$dateTime, filtered_data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")

# Save the plot
dev.off()
