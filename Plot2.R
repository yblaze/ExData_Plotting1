# Ex Plot2
# Author: g.guida
###############################################################################

#read from file
file = "C:/Users/g.guida/workspace/ExData_Plotting1/household_power_consumption_01022007_02022007.txt";

hpc = read.table(file, header = TRUE, sep = ",", 
		dec = ".",
		colClasses = c("POSIXct", rep("numeric", 7))
		,quote = "\"'",
);

summary(hpc)

#screen device
with(hpc
	,plot(Datetime, Global_active_power
	,type = "l"
	,main = "Global active power over time"
	,xlab = "", ylab = "lobal active power (kilowatts) "
));


#png device
png(file = "plot1.pdf") ## Open PDF device; create 'myplot.pdf' in my working directory
png(filename = "plot1.png",
		width = 480, height = 480, units = "px", pointsize = 12,
		res = NA, family = "", restoreConsole = TRUE
		)
## Create plot and send to a file (no plot appears on screen)
#screen device
with(hpc
		,plot(Datetime, Global_active_power
				,type = "l"
				,main = "Global active power over time"
				,xlab = "", ylab = "lobal active power (kilowatts) "
		));
dev.off() ## Close the PDF file device
## Now you can view the file 'myplot.pdf' on your computer