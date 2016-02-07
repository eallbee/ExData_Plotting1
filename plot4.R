# This R Script will produce a bar graph of Gobal Active Power
# utilizing data from the UC Irvine Machine Learning Repository 
# Electric power consumption dataset

# load the file
#myfile <- read.delim("household_power_consumption.txt", sep=";")
myfile <- read.csv("household_power_consumption.txt", header=T, sep=";", na.strings = "?", stringsAsFactors=F)
head(myfile)

# Convert the date column to a Date 
#usableDataset <- subset(myfile, myfile$Date %in% c("2007-02-01" , "2007-02-02"))
#head(usableDataset)
myfile$Date <- as.Date(myfile$Date, format="%d/%m/%Y")
head(myfile)

# subset the file to get just the data needed
usableDataset <- subset(myfile, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
head(usableDataset)

# create a datetime column concatenating the Date and Time columns
# so we can show a continuous line
datetime <- paste(as.Date(usableDataset$Date), usableDataset$Time)
usableDataset$Datetime <- as.POSIXct(datetime)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
# produce line graph 1 
plot(usableDataset$Datetime, usableDataset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

# produce line graph 2 
plot(usableDataset$Datetime, usableDataset$Voltage, type="l", xlab="datetime", ylab="Voltage")

# produce line graph 3
plot(usableDataset$Datetime, usableDataset$Sub_metering_1, type="l", col="black", ylab="Energy Sub Metering", xlab="", ylim=c(0,40))
# don't clear the canvas
par(new=T)
# plot the second line on top of the first
plot(usableDataset$Datetime, usableDataset$Sub_metering_2, type="l", col="red", ylab="", xlab="", ylim=c(0,40))
# don't clear the canvas
par(new=T)
# plot the third line on top of the first and second
plot(usableDataset$Datetime, usableDataset$Sub_metering_3, type="l", col="blue", ylab="", xlab="", ylim=c(0,40))
# add a legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# produce line graph 4 
plot(usableDataset$Datetime, usableDataset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")


# reset the clear canvas flag (not sure if this has to be done)
par(new=F)


# Save to a file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
