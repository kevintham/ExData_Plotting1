if(!require(functional)) {
  install.packages("functional")
  library('functional')
}

if(!file.exists("exdata%2Fdata%2Fhousehold_power_consumption.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

power <- read.table(file, header=T, sep=";")
data <- subset(power, Date=='1/2/2007' | Date =='2/2/2007')
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Global_intensity <- as.numeric(as.character(data$Global_intensity))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data <- transform(data, timestamp = as.POSIXct(strptime(paste(Date,Time),
                                                        "%d/%m/%Y %H:%M:%S")))
data <- data[-c(1,2)]

plot2 <- function() {
  png(filename = 'plot2.png', width = 480, height = 480)
  with(data, plot(timestamp, Global_active_power,type='l', 
                  xlab='',ylab='Global Active Power (kilowatts)'))
  dev.off()
  cat('Plot 2 has been saved in', getwd())
}

plot2()