# Ex Plot3
# Author: g.guida
###############################################################################

#read from file
file = "C:/Users/g.guida/workspace/ExData_Plotting1/household_power_consumption_01022007_02022007.txt";

hpc = read.table(file, header = TRUE, sep = ",", 
		dec = ".",
		colClasses = c("POSIXct", rep("numeric", 7))
		,quote = "\"'",
);

summary(hpc);

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(hpc, {
	
	#plot1
	with(hpc
			,plot(Datetime, Global_active_power
					,type = "l"
					,main = "Global active power over time"
					,xlab = "", ylab = "lobal active power (kilowatts) "
			));
	
	#plot1
	with(hpc
			,plot(Datetime, Voltage
					,type = "l"
					,main = "Global active power over time"
					,xlab = "", ylab = "lobal active power (kilowatts) "
			));
	
	#plot1
	with(hpc
			,plot(Datetime, Global_reactive_power
					,type = "l"
					,main = "Global active power over time"
					,xlab = "", ylab = "lobal active power (kilowatts) "
			));
	
	#plot4
	with(hpc, {
				yrange <- range(hpc$Sub_metering_1, hpc$Sub_metering_2, hpc$Sub_metering_3);
		plot(Datetime, Sub_metering_1, type = "l", col = "black", ylim = yrange);par(new=TRUE);
		plot(Datetime, Sub_metering_2, type = "l", col = "red", ylim = yrange);par(new=TRUE);
		plot(Datetime, Sub_metering_3, type = "l", col = "blue", ylim = yrange);par(new=TRUE);
		legend("topright", pch = 20, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));
 	})
})

#png device
png(file = "plot1.pdf") ## Open PDF device; create 'myplot.pdf' in my working directory
png(filename = "plot1.png",
		width = 480, height = 480, units = "px", pointsize = 12,
		res = NA, family = "", restoreConsole = TRUE
		)
## Create plot and send to a file (no plot appears on screen)
#screen device
yrange <- range(hpc$Sub_metering_1, hpc$Sub_metering_2, hpc$Sub_metering_3);
plot(hpc$Datetime, hpc$Sub_metering_1, type = "l", col = "black", ylim = yrange);par(new=TRUE);
plot(hpc$Datetime, hpc$Sub_metering_2, type = "l", col = "red", ylim = yrange);par(new=TRUE);
plot(hpc$Datetime, hpc$Sub_metering_3, type = "l", col = "blue", ylim = yrange);par(new=TRUE);
legend("topright", pch = 20, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off() ## Close the PDF file device
## Now you can view the file 'myplot.pdf' on your computer