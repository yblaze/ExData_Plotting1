# Ex Plot1
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

hist(
	hpc$Global_active_power 
	,xlab = "Global active power", ylab = "Frequency"
	,main = "Global active power"
	,col="red"
	,freq = TRUE
	#,breaks = c(0,2,4,6)
);


png(filename = "plot1.png",
		width = 480, height = 480, units = "px", pointsize = 12,
		res = NA, family = "", restoreConsole = TRUE
		)
## Create plot and send to a file (no plot appears on screen)
hist(
	hpc$Global_active_power 
	,xlab = "Global active power", ylab = "Frequency"
	,main = "Global active power"
	,col="red"
	,freq = TRUE
#,breaks = c(0,2,4,6)
);
dev.off() ## Close the PDF file device. Now you can view the file 'myplot.pdf' on your computer