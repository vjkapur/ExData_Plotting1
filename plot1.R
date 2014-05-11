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

##output to PNG
png(file='plot1.png')
hist(subdata$Global_active_power, ylim=c(0,1200), xlab='Global Active Power (kilowatts)', main='Global Active Power', col="red")
dev.off()