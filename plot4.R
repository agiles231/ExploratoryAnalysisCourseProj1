dat <- NULL
fileName <- "household_power_consumption.txt"
if(!file.exists("data.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
}
dat <- read.table(unz("data.zip", fileName), header = TRUE, sep = ";", na.strings = "?")
day1 <- dat[dat$Date=="1/2/2007",]
day2 <- dat[dat$Date=="2/2/2007",]
dat <- rbind(day1,day2)
times <- dat$Time
dates <- strptime(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S")
dat$Date <- dates
validDates <- !is.na(dat$Date)
validSM1 <- !is.na(dat$Sub_metering_1)
validSM2 <- !is.na(dat$Sub_metering_2)
validSM3 <- !is.na(dat$Sub_metering_3)
validVol <- !is.na(dat$Voltage)
validGAP <- !is.na(dat$Global_active_power)
validGRP <- !is.na(dat$Global_reactive_power)
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))
plot(x = dat$Date[validDates], y = dat$Global_active_power[validGAP],ylab = "Global Active Power(kilowatts)", type = 'l', xlab = "")
x <- 1:3
lables <- c("Thu", "Fri", "Sat")
text(x = x, labels = lables)
plot(x = dat$Date[validDates], y = dat$Voltage[validVol], type = 'l',ylab = "Voltage"
     , xlab = "datetime")
x <- 1:3
lables <- c("Thu", "Fri", "Sat")
text(x = x, labels = lables)
plot(dat$Date, dat$Sub_metering_1, type="n", ylab="Energy sub metering"
     , xlab="")
points(dat$Date[validDates],dat$Sub_metering_1[validSM1], col="black", type="l")
points(dat$Date[validDates],dat$Sub_metering_2[validSM2], col="red", type="l")
points(dat$Date[validDates],dat$Sub_metering_3[validSM3], col="blue", type="l")
legend("topright", legend = c("Sub_metering_1" , "Sub_metering_2", "Sub_metering_3")
       , bty="n"
       , lty=c(1,1)
       , col=c("black", "red", "blue"))
x <- 1:3
lables <- c("Thu", "Fri", "Sat")
text(x = x, labels = lables)
plot(dat$Date[validDates], dat$Global_reactive_power[validGRP], type="l", ylab="Global_reactive_power", xlab="datetime")
y <- c(0.0, 0.1, 0.2, 0.3, 0.4, 0.5)
dev.off()
