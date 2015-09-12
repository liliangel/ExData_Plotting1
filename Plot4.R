
if(!file.exists("exdata_data_household_power_consumption.zip")){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url,destfile = "exdata_data_household_power_consumption.zip")
  
}

# Step 1 - Loading Data
## In this step one read only the data from the dates 2007-02-01 and 2007-02-02

unzip("exdata_data_household_power_consumption.zip") 
data <- read.table(pipe("findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt"),col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep= ";",na.strings = "?")

## Add other column "Datetime" converting the variables "Date" and "Time"  with the factor class to Date/Time classes

data$Date_time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

## Generating and Save the Plot4 is a set of graphs.

png(filename = "plot4.png",width = 480, height = 480, units = "px")

par(mfrow = c(2,2), cex= 0.5)

with(data, { 
  ##first graph c(1,1) correspond plot1
  plot(Date_time,Global_active_power, type = "l",ylab = "Global Active Power",  xlab = "")
   
  ##Second graph c(1,2) voltage vs date-time
  plot(Date_time,Voltage, type = "l",ylab = "Voltage",  xlab = "datetime")
  
  ##Third graph c(2,1) energy sub metering
  plot(Date_time, Sub_metering_1, type = "l", ylab = "Energy Sub metering", xlab = "")
  lines(Date_time, Sub_metering_2, col = 'Red')
  lines(Date_time, Sub_metering_3, col = 'Blue') 

  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1), bty = "n")
  
  ##Forth graph  c(2,2) Global Reactive power vs date-time
  plot(Date_time,Global_reactive_power, type = "l",ylab = "Global Reactive Power",  xlab = "datetime")
  })
  

dev.off()
