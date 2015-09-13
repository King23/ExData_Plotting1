library(data.table)
library(lubridate)

setwd("C:/Rtraining1/R_MDec/Module4")

#Download the data from the URL given from instruction
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="household_power_consumption.zip")
unzip ("household_power_consumption.zip")

#Use 'fread' function, very fast and simple within 2-3 seconds
data_frame <- fread("household_power_consumption.txt",sep=";",header=TRUE,na.strings='?',stringsAsFactors=FALSE)

#Combine both Date and Time into one column
data_frame$DateTime <- paste(data_frame$Date, data_frame$Time, sep=" ") 

#change 'DateTime' column from character to datetime format then filter to get the 2 days dataset
data_frame$DateTime <- dmy_hms(data_frame$DateTime)
data_frame <- subset(data_frame, DateTime >= strptime("2007-02-01 00:00:00 UTC", "%Y-%m-%d %H:%M:%S", "UTC"))
data_frame <- subset(data_frame, DateTime <= strptime("2007-02-02 23:59:59 UTC", "%Y-%m-%d %H:%M:%S", "UTC"))

#Covert columns 3 to 9 from character to numeric
data_frame$Global_active_power <- as.numeric(data_frame$Global_active_power)
data_frame$Global_reactive_power <- as.numeric(data_frame$Global_reactive_power)
data_frame$Voltage <- as.numeric(data_frame$Voltage)
data_frame$Global_intensity <- as.numeric(data_frame$Global_intensity)
data_frame$Sub_metering_1 <- as.numeric(data_frame$Sub_metering_1)
data_frame$Sub_metering_2 <- as.numeric(data_frame$Sub_metering_2)
data_frame$Sub_metering_3 <- as.numeric(data_frame$Sub_metering_3)

#plot3
png(filename="plot3.png",width = 480, height = 480, units = "px")
plot(x= data_frame$DateTime, y=data_frame$Sub_metering_1, type='line', lty=1, lwd=1, xlab='' ,ylab='Energy sub metering')
lines(x= data_frame$DateTime, y=data_frame$Sub_metering_2, lty=1, lwd=1, col='red')
lines(x= data_frame$DateTime, y=data_frame$Sub_metering_3, lty=1, lwd=1, col='blue')
legend("topright", c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), cex=0.8, col=c('black', 'red', 'blue'), lty=1, lwd=1);
dev.off()