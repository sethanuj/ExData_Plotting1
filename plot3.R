## plot3.R
## Coursera - Exploratory Data Analysis Week 1 Project Assignment

## Constants
zipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localFile <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Download file only if the ZIP doesn't exist
if(!file.exists(localFile)) {
  download.file(zipURL, destfile=localFile, method="curl")
  unzip (localFile)
}

## Parse Data into a Table
data <- read.table("household_power_consumption.txt", 
                   header=TRUE, 
                   na.strings="?", 
                   sep=";")

## Get required subset of data
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
dataRange <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"), ]

dateTime <- paste(dataRange$Date, dataRange$Time)
dataRange$DateTime <- as.POSIXct(dateTime)

## Create the graph
with(dataRange, {
  plot(Sub_metering_1~DateTime, type="l",ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~DateTime, col='Red')
  lines(Sub_metering_3~DateTime, col='Blue')
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## export file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

## Delete the local file
file.remove(localFile)