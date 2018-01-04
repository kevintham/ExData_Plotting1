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

plot3 <- function() {
  png(filename = 'plot3.png', width = 480, height = 480)
  with(data, plot(timestamp, Sub_metering_1,type='n', 
                  xlab='',ylab='Energy sub metering'))
  lines(data$timestamp, data$Sub_metering_1, col='black')
  lines(data$timestamp, data$Sub_metering_2, col='red')
  lines(data$timestamp, data$Sub_metering_3, col='blue')
  legend(x='topright', legend=c('Sub_metering_1','Sub_metering_2',
                                'Sub_metering_3'), col=c('black','red','blue'),
         lty=1,lwd=1)
  dev.off()
  cat('Plot 3 has been saved in', getwd())
}

plot3()