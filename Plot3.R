library("stats"); #to use complete.cases
library("lubridate");

# Plot 0

rm(list=ls()); #clear memeory

library("stats"); #to use complete.cases
library("lubridate");

#File information
directory = getwd();
file = "household_power_consumption.txt";
dir_file = paste(directory, file, sep="/");
sep = ";"

#defining custom classes
setClass("myDate", representation(date = "character"));
setClass("myTime", representation(time = "character"));
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") );
setAs("character","myTime", function(from) as.POSIXct(from, format="%H:%M:%S") );

#read from file
hpc = read.table(dir_file, header = TRUE, sep = ";", 
                 dec = ".",  
                 na.strings = "?",
                 colClasses = c("myDate", "myTime", rep("numeric", 7)),
                 strip.white = TRUE, blank.lines.skip = TRUE
);

# Period to be analised
period <- c(as.Date("2007-02-01"), as.Date("2007-02-02"));

#Filtering out undesired dates and na
hpc2 <- hpc[hpc$Date %in% period,];
hpc3 <- hpc2[complete.cases(hpc2),];

#correcting datetime information
hpc4 <- cbind (
  as.POSIXct (
    paste (
      paste(year(hpc2[,1]),month(hpc2[,1]),day(hpc2[,1]), sep = "-"), 
      paste(hour(hpc2[,2]),minute(hpc2[,2]), sep = ":")
    )
  ),
  hpc2[3:9]
)
colnames(hpc4)[1] <-  "Datetime";

write.table(hpc4, 
            file = paste(getwd(), "household_power_consumption_plot.txt", sep="/"),
            append = FALSE, 
            sep = ",",
            eol = "\n", dec = ".",
            col.names = TRUE,
            row.names = FALSE);

print("File created")

#File information
directory = getwd();
file = "household_power_consumption_plot.txt";
file = paste(directory, file, sep="/");

hpc = read.table(
  file, 
  header = TRUE, 
  sep = ",", 
  dec = ".",
  colClasses = c("POSIXct", rep("numeric", 7)),
  quote = "\"'"
);

#plot3
with(hpc, {
  yrange <- range(hpc$Sub_metering_1, hpc$Sub_metering_2, hpc$Sub_metering_3);
  plot(Datetime, Sub_metering_1, type = "l", col = "black", ylim = yrange);
  plot(Datetime, Sub_metering_2, type = "l", col = "red", ylim = yrange);
  plot(Datetime, Sub_metering_3, type = "l", col = "blue", ylim = yrange);
  legend("topright", 
    pch = 20, 
    col = c("black", "blue", "red"), 
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  );
}
)

#png device
# png(file = "C:/Users/Giuseppe/Documents/R/plot3.png") ## Open PDF device; create 'myplot.pdf' in my working directory
png(filename = paste(getwd(), "plot3.png", sep="/"),
    width = 480, height = 480, units = "px", pointsize = 12,
    res = NA, family = "", restoreConsole = TRUE
)
## Create plot and send to a file (no plot appears on screen)
#screen device
yrange <- range(hpc$Sub_metering_1, hpc$Sub_metering_2, hpc$Sub_metering_3);
plot(hpc$Datetime, hpc$Sub_metering_1, type = "l", col = "black", ylim = yrange);par(new=TRUE);
plot(hpc$Datetime, hpc$Sub_metering_2, type = "l", col = "red", ylim = yrange);par(new=TRUE);
plot(hpc$Datetime, hpc$Sub_metering_3, type = "l", col = "blue", ylim = yrange, ylab = "Energy sub metering", xlab = "");par(new=TRUE);
legend("topright", pch = 20, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off() ## Close the PDF file device