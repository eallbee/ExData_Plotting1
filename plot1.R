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


# produce a bar graph
hist(usableDataset$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Save to a file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
