setwd("C:/Users/Grant/Documents/classes/Exploratory_Data_Analysis")

### memory estimate:
### 2,075,259 rows and 9 columns
### 2M * 9 * (8 bytes/numeric) = 144 MB

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "Fhousehold_power_consumption.zip"
unzipfile <- "household_power_consumption.txt"

if (!file.exists(zipfile)) {
    download.file(url, destfile=zipfile)
}

data <- read.csv(unz(zipfile, unzipfile), 
                 header=TRUE, 
                 sep=";", 
                 as.is=TRUE
)

data[data=="?"] <- NA

data <- data[data$Date=="2/2/2007" | data$Date=="1/2/2007",]

data$datetime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

data[,3] <- as.numeric(data[,3])
data[,4] <- as.numeric(data[,4])
data[,5] <- as.numeric(data[,5])
data[,6] <- as.numeric(data[,6])
data[,7] <- as.numeric(data[,7])
data[,8] <- as.numeric(data[,8])
data[,9] <- as.numeric(data[,9])

### Plot 3
par(mfrow=c(1,1))
### need to scale the text to match the example...
par(cex=0.78)
with(data, plot(datetime, Sub_metering_1, 
                type="l", 
                xlab="", 
                ylab="Energy sub metering", 
                col="gray", 
                lwd=2
                )
     )

with(data, points(datetime, Sub_metering_2, 
                  type="l", 
                  xlab="", 
                  ylab="Energy sub metering", 
                  col="red", 
                  lwd=2
                  )
     )

with(data, points(datetime, Sub_metering_3, 
                  type="l", 
                  xlab="", 
                  ylab="Energy sub metering", 
                  col="blue", 
                  lwd=2
                  )
     )

legend("topright", 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("gray","red","blue"), 
       lwd=2, 
       text.width=45000, 
       y.intersp=2
       )

dev.copy(png, file="plot3.png")
dev.off()