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
par(mfrow = c(1,1))
png("Plot3.png", width=480, height=480)
plot(dat$Date, dat$Sub_metering_1, type="n", ylab="Energy sub metering"
     , xlab="")
points(dat$Date,dat$Sub_metering_1, col="black", type="l")
points(dat$Date,dat$Sub_metering_2, col="red", type="l")
points(dat$Date,dat$Sub_metering_3, col="blue", type="l")
legend("topright", legend = c("Sub_metering_1" , "Sub_metering_2", "Sub_metering_3")
       , lty=c(1,1)
       , col=c("black", "red", "blue"))
x <- 1:3
lables <- c("Thu", "Fri", "Sat")
text(x = x, labels = lables)
dev.off()
