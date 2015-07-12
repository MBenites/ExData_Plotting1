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

# Generate the plot3
png(filename="plot3.png")
plot(as.numeric(data$Sub_metering_1),xaxt="n",type = "l", ylab = "Global Active Power (killowatts)", xlab="")
lines(as.numeric(data$Sub_metering_2),col="red")
lines(as.numeric(data$Sub_metering_3),col="blue")
axis(1, at=c(0,1440,2880),labels=c('Thu','Fri','Sat'))
legend(1700,38,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),lwd=c(2.5,2.5),col=c("black","red","blue"))
dev.off()