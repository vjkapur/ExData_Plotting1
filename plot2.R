##handle file matters
fileName <- "household_power_consumption.txt"

if(!file.exists(fileName)) {
	zipFile <- "data.zip"
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(fileUrl, destfile=zipFile, method="curl")
	unzip(zipFile)
	file.remove(zipFile)
}

##read in data, subset by date
data <- read.table(fileName, na.strings = "?", sep = ";", header = TRUE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
subdata <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
rm(data)
subdata$Time <- paste(subdata$Date, subdata$Time)
subdata$Time <- strptime(subdata$Time, format = "%Y-%m-%d %H:%M:%S")

##output to PNG
png(file='plot2.png')
plot(subdata$Time, subdata$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", ylim = c(0,6), xlab = "")
dev.off()
