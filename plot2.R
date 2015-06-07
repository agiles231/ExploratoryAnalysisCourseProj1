dat <- NULL
fileName <- "household_power_consumption.txt"
if(!file.exists("data.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
}
dat <- read.table(unz("data.zip", fileName), header = TRUE, sep = ";")
day1 <- dat[dat$Date=="1/2/2007",]
day2 <- dat[dat$Date=="2/2/2007",]
dat <- rbind(day1,day2)
par(mfrow = c(1,1))
png("Plot2.png", width=480, height=480)
times <- dat$Time
dates <- strptime(paste(dat$Date, dat$Time), format="%d/%m/%Y %H:%M:%S")
dat$Date <- dates
plot(x = dat$Date, y = dat$Global_active_power,ylab = "Global Active Power(kilowatts)", type = 'l', xlab = "") 
x <- 1:3
lables <- c("Thu", "Fri", "Sat")
text(x = x, labels = lables)
dev.off()