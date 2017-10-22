#setwd("The folder path containing zipped data Set")
#the program will create data data2 data3 in theenviroment
#it will clean up data and data2 
#if not unziped it will unzip the data required 
# and create a png plot
# created 22-10-2017

#unzips file if it does not exist
if(!file.exists("dataset/exdata_data_household_power_consumption/household_power_consumption.txt")){
  unzip(zipfile = "exdata_data_household_power_consumption.zip",exdir = "exdata_data_household_power_consumption")
}

#checks if data3 exists in global enviroment if not imports data and creates data3
#if a data3 exists that was not created by plot1.R plot2.R plot3.R or plot4.R
#please remove it before running this
if(!("data3" %in% ls())){
  #imports data
  data=read.csv("exdata_data_household_power_consumption/household_power_consumption.txt",sep = ";")
  #adds variable Date2 that is the Date in a date format
  data$Date2=as.Date.character(as.character(data$Date),format="%d/%m/%Y")
  #make new data set containing only data for  01/02/2007 and 02/02/2007
  data2=data[data$Date2 == as.Date.character("01/02/2007",format="%d/%m/%Y")
             |data$Date2 == as.Date.character("02/02/2007",format="%d/%m/%Y")
             ,]
  #cleans up the orignal input set.
  rm(data)
  #adds a variable Time2 that is a date tiem variable based on Date and Time variables
  data2$Time2=strptime(paste(as.character(data2$Date),as.character(data2$Time)),"%d/%m/%Y %T")
  #makes a new data set for futher clean up
  #replaces all "?" in variables of intrest with NA values
  data3=data2
  data3$Global_active_power[data3$Global_active_power=='?']=NA    
  data3$Global_reactive_power[data3$Global_reactive_power=='?']=NA 
  data3$Voltage[data3$Voltage=='?']=NA 
  data3$Global_intensity[data3$Global_intensity=='?']=NA 
  data3$Sub_metering_1[data3$Sub_metering_1=='?']=NA 
  data3$Sub_metering_2[data3$Sub_metering_2=='?']=NA 
  data3$Sub_metering_3[data3$Sub_metering_3=='?']=NA
  #Cahnges the variables of intrest that were factors at first to characters and then numeric
  data3$Global_active_power=as.numeric(as.character(data3$Global_active_power))
  data3$Global_reactive_power=as.numeric(as.character(data3$Global_reactive_power))
  data3$Voltage=as.numeric(as.character(data3$Voltage))
  data3$Global_intensity=as.numeric(as.character(data3$Global_intensity))
  data3$Sub_metering_1=as.numeric(as.character(data3$Sub_metering_1))
  data3$Sub_metering_2=as.numeric(as.character(data3$Sub_metering_2))
  data3$Sub_metering_3=as.numeric(as.character(data3$Sub_metering_3))
  #cleans up the data set data2
  rm(data2)
}


#crates plot2.png
#open png graphics device

png(filename = "plot2.png"
    ,width = 480
    ,height=480
    ,units = "px")
#plots into grapics device
#creates a basic line plot with ylable and a blank x lable
with(data3,plot(Time2,Global_active_power,ylab="Global Active Power (kilowatts)",xlab='',type="l"))
#closes graphics device
dev.off()