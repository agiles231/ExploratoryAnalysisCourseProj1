dat <- NULL
fileName <- "household_power_consumption.txt"
if(!file.exists("data.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
}
dat <- read.table(unz("data.zip", fileName), header = TRUE, sep = ";", na.strings = "?")
day1 <- dat[dat$Date=="1/2/2007",]
day2 <- dat[dat$Date=="2/2/2007",]
dat <- rbind(day1,day2)
par(mfrow = c(1,1))
png("Plot1.png", width=480, height=480)
dat$Global_active_power <- dat$Global_active_power[!is.na(dat$Global_active_power)]
print(dat$Global_active_power)
hist(x=dat$Global_active_power, col = "red", xlab = "Global Active Power", main="Global Active Power")
dev.off()
