zipFile<-'exdata-data-household_power_consumption.zip'
fileName<-'household_power_consumption.txt'
fileURL<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

# Check if the .txt and .zip exists. If not, the dataset is downloaded and uncompressed
if(!file.exists(fileName)){
    if(!file.exists(zipFile)) {
        download.file(fileUrl,zipFile)
    }
    unzip(zipFile,fileName)
}

# Only rows corresponding to dates 01/02/2007 and 02/02/2007 are read
con<-file(fileName)
open(con)
header<-read.table(con,nrows=1,header=FALSE,sep=";")
data<-read.table(con,header=FALSE,skip=66636,nrows=2880,na.strings="?",sep=";")
colnames(data) <- unlist(header)
close(con)
data$DateTime<-as.POSIXct(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")

# Generate the plot4
png(filename="plot4.png")
par(mfrow=c(2,2)) #creates a 2 by 2 matrix where the plots will be placed
#plot 1,1
plot(data$Global_active_power, typ='l', ylab="Global Active Power (kilowatts)", xlab="", xaxt='n')
axis(1, at=c(0,1440,2880),labels=c('Thu','Fri','Sat'))
#plot 1,2
plot(data$Voltage, typ='l', ylab="Voltage", xlab="datetime", xaxt='n')
axis(1, at=c(0,1440,2880),labels=c('Thu','Fri','Sat'))
#plot 2,1
plot(as.numeric(data$Sub_metering_1),xaxt="n",type = "l", ylab = "Global Active Power (killowatts)", xlab="")
lines(as.numeric(data$Sub_metering_2),col="red")
lines(as.numeric(data$Sub_metering_3),col="blue")
axis(1, at=c(0,1440,2880),labels=c('Thu','Fri','Sat'))
legend(1300,38,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),lwd=c(2.5,2.5),col=c("black","red","blue"),bty="n",cex=0.75)
#plot 2,2
plot(data$Global_reactive_power, typ='l', xlab="datetime", xaxt='n')
axis(1, at=c(0,1440,2880),labels=c('Thu','Fri','Sat'))
dev.off()