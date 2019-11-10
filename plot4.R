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

# set up a plot with 2 row 2 columns and adjust the margin and outer margin
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2), mar = c(4,4,2,1), oma = c(0,0,2,0))

# plot the four plots
# plot 1
with(select_data, plot(DateTime, Global_active_power, type = "l", xlab = NA,
                       ylab = "Gloabl Active Power (kilowatts)"))

# plot 2
with(select_data, plot(DateTime, Voltage, type = "l", xlab = "datetime",
                       ylab = "Voltage"))

# plot 3
with(select_data, plot(DateTime, Sub_metering_1, type = "l", col = "black",
                       xlab = NA, ylab = "Energy sub metering"))
with(select_data, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(select_data, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot 4
with(select_data, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime",
                       ylab = "Global_reactive_power"))
dev.off()
