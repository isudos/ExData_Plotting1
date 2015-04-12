zipFile <- "exdata-data-household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"

if(! file.exists(dataFile)){
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=zipFile, method='curl')
  unzip(zipFile)
}

energyConsumptionData <- read.table(file = dataFile, sep = ";",,colClasses="character",
                                    header = TRUE)
startDate = as.Date("2007-02-01")
finishDate = as.Date("2007-02-02")


energyConsumptionData <- subset(energyConsumptionData, as.Date(Date, "%d/%m/%Y") >= startDate & 
                                  as.Date(Date, "%d/%m/%Y") <= finishDate )
png(filename="plot1.png",width=480,height=480)
hist(x=as.numeric(energyConsumptionData$Global_active_power ), breaks = 12, freq=TRUE, col="red",
     main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()
