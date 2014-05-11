##handle file matters
fileName <- "household_power_consumption.txt"

if(!file.exists(fileName)) {
	zipFile <- "data.zip"
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(fileUrl, destfile=zipFile, method="curl")
	unzip(zipFile)
	file.remove(zipFile)
}

##read in data
data <- read.table(fileName, na.strings = "?", sep = ";", header = TRUE)

##format/subset data
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
subdata <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
rm(data)
subdata$Time <- paste(subdata$Date, subdata$Time)
subdata$Time <- strptime(subdata$Time, format = "%Y-%m-%d %H:%M:%S")

##create plots
png(filename="plot4.png")
par(mfcol = c(2, 2))
plot(subdata$Time, subdata$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", ylim = c(0,6), xlab = "")
plot(subdata$Time, subdata$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")

lines(subdata$Time, subdata$Sub_metering_2, col = "red")
lines(subdata$Time, subdata$Sub_metering_3, col = "blue")

legend("topright", lty = 1, lwd = 2, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(subdata$Time, subdata$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(subdata$Time, subdata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()