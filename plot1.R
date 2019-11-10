# read data
power_data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# convert columns Date and Time to create a POSIXLt column DateTime
power_data$DateTime <- strptime(paste(power_data$Date, power_data$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

# select the data from dates 2007-02-01 and 2007-02-02
select_data <- subset(power_data, (DateTime >= "2007-02-01 00:00:00" & DateTime < "2007-02-03 00:00:00"))

# convert the rest of columns to appropriate classes
select_data$Global_active_power <- as.numeric(select_data$Global_active_power)
select_data$Global_reactive_power <- as.numeric(select_data$Global_reactive_power)
select_data$Voltage <- as.numeric(select_data$Voltage)
select_data$Global_intensity <- as.numeric(select_data$Global_intensity)
select_data$Sub_metering_1 <- as.numeric(select_data$Sub_metering_1)
select_data$Sub_metering_2 <- as.numeric(select_data$Sub_metering_2)
select_data$Sub_metering_3 <- as.numeric(select_data$Sub_metering_3)

# plot histogram of global active power
png(filename = "plot1.png", width = 480, height = 480)
hist(select_data$Global_active_power, col = "red", xlab = "Gloabl Active Power (kilowatts)", 
     ylab = "Frequency", main = "Global Active Power")
dev.off()