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

png(filename="plot4.png",width=480,height=480)

par(mfrow=c(2,2))

plot(x=timeticks,
     y=as.numeric(energyConsumptionData$Global_active_power ), pch=".",
     main="", xlab="", ylab="Global Active Power")
lines(x=timeticks,
      y=as.numeric(energyConsumptionData$Global_active_power ))


plot(x=timeticks,
     y=as.numeric(energyConsumptionData$Voltage ), pch=".",
     main="", xlab="datetime", ylab="Voltage")
lines(x=timeticks,
      y=as.numeric(energyConsumptionData$Voltage ))


plot(x=timeticks, 
     y=as.numeric(energyConsumptionData$Sub_metering_1 ), pch=".",col="black",
     main="", xlab="", ylab="Energy sub metering")
lines(x=timeticks,
      y=as.numeric(energyConsumptionData$Sub_metering_1 ),col="black")
lines(x=timeticks,
      y=as.numeric(energyConsumptionData$Sub_metering_3 ),col="blue")
lines(x=timeticks,
      y=as.numeric(energyConsumptionData$Sub_metering_2),col="red")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n",
       col=c("black","red","blue"),lty=c(1,1,1), lwd=c(1,1,1))



plot(x=timeticks,
     y=as.numeric(energyConsumptionData$Global_reactive_power ), pch=".",
     main="", xlab="datetime", ylab="Global_reactive_power")
lines(x=timeticks,
      y=as.numeric(energyConsumptionData$Global_reactive_power ))

dev.off()
