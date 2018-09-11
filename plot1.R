## Plot1.R
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
         
## Generate the histogram (Plot1)
hist(dataRange$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     col="Red")

## export file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

## Delete the local file
file.remove(localFile)