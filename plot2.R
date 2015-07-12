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

# Generate the plot2
png(filename="plot2.png")
plot(data$Global_active_power, typ='l', ylab="Global Active Power (kilowatts)", xlab="", xaxt='n')
axis(1, at=c(0,1440,2880),labels=c('Thu','Fri','Sat'))
dev.off()