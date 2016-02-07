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

# produce a line graph
plot(usableDataset$Datetime, usableDataset$Sub_metering_1, type="l", col="black", ylab="Energy Sub Metering", xlab="", ylim=c(0,40))
# don't clear the canvas
par(new=T)
# plot the second line on top of the first
plot(usableDataset$Datetime, usableDataset$Sub_metering_2, type="l", col="red", ylab="", xlab="", ylim=c(0,40))
# don't clear the canvas
par(new=T)
# plot the third line on top of the first and second
plot(usableDataset$Datetime, usableDataset$Sub_metering_3, type="l", col="blue", ylab="", xlab="", ylim=c(0,40))

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# reset the clear canvas flag (not sure if this has to be done)
par(new=F)


# Save to a file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
