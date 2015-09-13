
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

## Generating and Save the Plot2 is a graph of "Global Active Power" vs date - time.
png()
png(filename = "plot2.png",width = 480, height = 480, units = "px")
plot(data$Date_time,data$Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
