## Expolratory Data Analysis : Assignment 1
## Rahul Garkhail, github=mayintara

## Used the Following "dwnld" function to Download and Unzip the File from the 
## given (Url=https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2F
## household_power_consumption.zip)

## RAM Calculations >>>> Since colClasses="numeric"
## 2075259 (rows) x 9 (cols) x 8 bytes/numeric
## 149418648 bytes ~ 149418648/2^20 bytes/MB ~ 142.49 MB
## Overhead required (Rule Of Thumb x 2) so we need roughly 285 MB. (SAFE)

## Optimizing the read.table function >>>>
## colClasses="numeric"-
## comment.char=""
## na.strings="?"
## Since each day has 1440 minutes ~ 1440 obs/day
## Start 12/16/2006-17:24:00 to 12/17/2006-23:59:00 = 396 obs + header
## 12/17/2006-00:00:00 to 01/31/2007-23:59:00=46x1440=66240 obs
## 02/01/2007 - 02/02/2007 = 2*1440 = 2880 obs.
## Therefore we only need to read 2880 obs (rows) + header.
## nrows = 2*1440 = 2880 obs ........ [1/2/2007 && 2/2/2007 @ 24x60 min obs]
## skip = 1+396+66240 = 66637

## Reading the Data

hpcDat<-read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",header=FALSE,sep=";",
                    col.names=read.table("./exdata-data-household_power_consumption/household_power_consumption.txt",
                                         colClasses="character",sep=";",nrows=1)
                   ,comment.char="",colClasses=c(rep("character",2),
                    rep("numeric",7)),nrows=2880,skip=66637,
                    na.strings="?")

## Convert hpcDat$Date and hpcDat$Time columns from "character" to "Date/Time" 
## class.e

Date<-as.Date(hpcDat$Date,"%d/%m/%Y")
Time<-hpcDat$Time
X<-paste(Date,Time)
DateTime<-strptime(X,format="%Y-%m-%d %H:%M:%S")
hpcDat$Time<-DateTime

## Plotting the histogram in Plot1 on screen device.

windows()
hist(hpcDat$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

## Copy Plot1 to PNG Device.
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()

