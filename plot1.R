library(data.table)
library(lubridate)

setwd("C:/Rtraining1/R_MDec/Module4")

#Download the data from the URL given from instruction
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="household_power_consumption.zip")
unzip ("household_power_consumption.zip")

#Use 'fread' function, very fast and simple within 2-3 seconds
data_frame <- fread("household_power_consumption.txt",sep=";",header=TRUE,na.strings='?',stringsAsFactors=FALSE)

#change 'Date' column from character to date format then filter to get the 2 days dataset
data_frame$Date <- dmy(data_frame$Date)
data_frame <- subset(data_frame, Date >= strptime("2007-02-01 UTC", "%Y-%m-%d", "UTC"))
data_frame <- subset(data_frame, Date <= strptime("2007-02-02 UTC", "%Y-%m-%d", "UTC"))

#Covert columns 3 to 9 from character to numeric
data_frame$Global_active_power <- as.numeric(data_frame$Global_active_power)
data_frame$Global_reactive_power <- as.numeric(data_frame$Global_reactive_power)
data_frame$Voltage <- as.numeric(data_frame$Voltage)
data_frame$Global_intensity <- as.numeric(data_frame$Global_intensity)
data_frame$Sub_metering_1 <- as.numeric(data_frame$Sub_metering_1)
data_frame$Sub_metering_2 <- as.numeric(data_frame$Sub_metering_2)
data_frame$Sub_metering_3 <- as.numeric(data_frame$Sub_metering_3)

#plot1
png(filename="plot1.png",width = 480, height = 480, units = "px")
hist(data_frame$Global_active_power, breaks = 12, xlab= "Global Active Power (kilowatts)", ylab="Frequency", main = "Global Active Power", freq=TRUE, col = "red", cex.lab=0.8, cex.axis=0.8)
dev.off()


