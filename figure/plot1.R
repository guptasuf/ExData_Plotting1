#exploratory data analysis (coursera)
#course project 1
#version 1
#subhajit gupta, 8th feb 2015

rm(list=ls())#clear working directory

#set working directory
#reading dataset using data.table package 
#using fread to read data faster
setwd("/home/shibai/Courses/datascience~eda")
require(data.table)
hpc<-fread("household_power_consumption.txt")

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

#plot1
png(filename="plot1.png", width=480, height=480)
hpc.1[,Global_active_power:=as.numeric(Global_active_power)]
with(hpc.1,hist(Global_active_power,
                col="red",xlab="Global Active Power (kilowatts)",
                main="Global Active Power")
)
dev.off()
