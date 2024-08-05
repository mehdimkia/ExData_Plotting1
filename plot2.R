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
png("plot2.png", width = 480, height = 480)

# Create the plot
plot(x = filtered_data$dateTime, 
     y = filtered_data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

# Save the plot
dev.off()
