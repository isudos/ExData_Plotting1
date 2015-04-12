zipFile <- "exdata-data-household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"
if(! file.exists(dataFile)){
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=zipFile, method='curl')
  unzip(zipFile)
}


energyConsumptionData <- read.table(file = dataFile, sep = ";",colClasses="character",
                                    header = TRUE)
startDate = as.Date("2007-02-01")
finishDate = as.Date("2007-02-02")


energyConsumptionData <- subset(energyConsumptionData, as.Date(Date, "%d/%m/%Y") >= startDate & 
                                  as.Date(Date, "%d/%m/%Y") <= finishDate )
timeticks = strptime(paste(energyConsumptionData$Date,energyConsumptionData$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")

png(filename="plot3.png",width=480,height=480)


plot(x=timeticks, 
     y=as.numeric(energyConsumptionData$Sub_metering_1 ), pch=".",col="black",
     main="", xlab="", ylab="Energy sub metering")
lines(x=timeticks,
      y=as.numeric(energyConsumptionData$Sub_metering_1 ),col="black")
lines(x=timeticks,
      y=as.numeric(energyConsumptionData$Sub_metering_2),col="red")
lines(x=timeticks,
      y=as.numeric(energyConsumptionData$Sub_metering_3 ),col="blue")


legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lty=c(1,1,1), lwd=c(1,1,1))



dev.off()

