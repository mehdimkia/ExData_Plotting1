# Load necessary library
library(data.table)

# Set working directory to the location of the dataset
setwd("file/path")

# Read data from file and handle missing values
power_data <- fread("household_power_consumption.txt", na.strings = "?")

# Convert 'Global_active_power' to numeric
power_data[, Global_active_power := as.numeric(Global_active_power)]

# Convert 'Date' to Date type
power_data[, Date := as.Date(Date, format = "%d/%m/%Y")]

# Filter data for the specified date range
filtered_data <- power_data[Date >= "2007-02-01" & Date <= "2007-02-02"]

# Set up the plot
png("plot1.png", width = 480, height = 480)

# Create histogram
hist(filtered_data$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = "red")

# Save the plot
dev.off()
