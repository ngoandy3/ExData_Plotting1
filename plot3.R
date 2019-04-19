data <- read.table("household_power_consumption.txt", header = TRUE, colClasses = c("character", "character",
                                                                                    "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
                   sep = ";", na.strings = "?")

#ake date turn into type date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

#get only date that is the following
data <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
#print out all without na / missing values
data <- data[complete.cases(data), ]
#combine the date and time column and name it
time_date <- paste(data$Date, data$Time)
time_date <- setNames(time_date, "DateTime")

#remove date and time column
data <- data[, !(names(data) %in% c("Date", "Time"))]
data <- cbind(time_date, data)
data$time_date <- as.POSIXct(time_date)

#create plot 3
with(data, {
        plot(Sub_metering_1 ~ time_date, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
        lines(Sub_metering_2 ~ time_date, col = "Red")
        lines(Sub_metering_3 ~ time_date, col = "Blue")
})
legend("topright", col = c("black", "red", "blue"), lwd = c(1, 1, 1),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
