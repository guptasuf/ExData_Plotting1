#exploratory data analysis (coursera)
#course project 1
#version 1
#subhajit gupta, 8th feb 2015

#set working directory
#currently it is my own directory: /home/shibai/Courses/datascience~eda
#first downloading the file from given url
#then unzipping the file and reading it
#reading dataset using data.table package 
#using fread to read data faster
rm(list=ls())#clear existing workspace
wrkdir<-"/home/shibai/Courses/datascience~eda" #working directory
setwd(wrkdir)
require(data.table)
fileurl<-"http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile="hpc.zip")
unzip("hpc.zip")#unzip file
filename<-unzip("hpc.zip",list=T)$Name#extract data set name
hpc<-fread(filename)

#some basic data understanding using str,head, etc.
str(hpc)
head(hpc)
colnames(hpc)
summary(hpc)
class(hpc$Date)

#subsetting according to date
#creating new datetime format combinig date and time variables
hpc.1<-hpc[as.Date(Date,"%d/%m/%Y") %in% c(as.Date("2007-02-01"),as.Date("2007-02-02"))]
hpc.1[,DateTime:=paste(Date,Time)]
hpc.1[,Date:=as.Date(Date,"%d/%m/%Y")]
hpc.1[,DateTime:=as.POSIXct(DateTime,format="%d/%m/%Y %H:%M:%S")]
str(hpc.1)
head(hpc.1)

#plot4
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
hpc.1[,Voltage:=as.numeric(Voltage)]
hpc.1[,Global_reactive_power:=as.numeric(Global_reactive_power)]
with(hpc.1,plot(DateTime,
                Global_active_power,
                type="l",
                xlab="",
                ylab="Global Active Power (kilowatts)"))
with(hpc.1,plot(DateTime,
                Voltage,
                type="l",
                xlab="datetime",
                ylab="Voltage"))
with(hpc.1,{
  plot(DateTime,
       Sub_metering_1,
       type="l",
       xlab="",
       ylab="Energy sub metering")
  lines(DateTime,Sub_metering_2,col="red")
  lines(DateTime,Sub_metering_3,col="blue")
  legend("topright",
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         col=c("black","red","blue"),
         lty=1)
})
with(hpc.1,plot(DateTime,
                Global_reactive_power,
                type="l",
                xlab="datetime",
                ylab="Global_reactive_power"))
dev.off()

par(mfrow=c(1,1))