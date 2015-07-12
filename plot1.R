zipFile<-'exdata-data-household_power_consumption.zip'
fileName<-'household_power_consumption.txt'

if(!file.exists(fileName)){
    if(!file.exists(zipFile)) {
        download.file(fileUrl,zipFile)
    }
    unzip(zipFile,fileName)
}

con<-file(fileName)
open(con)
header<-read.table(con,nrows=1,header=FALSE,sep=";")
data<-read.table(con,header=FALSE,skip=66636,nrows=2880,na.strings="?",sep=";")
colnames(data) <- unlist(header)
close(con)

data$DateTime<-as.POSIXct(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
png(filename="plot1.png")
hist(data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()