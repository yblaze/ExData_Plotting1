# TODO: Filter out rows while reading a file
# 
# Author: g.guida
###############################################################################

rm(list=ls()); #clear memeory

library("stats"); #to use complete.cases
library("lubridate");

#Loading a file
file = "C:/Users/g.guida/workspace/ExData_Plotting1/household_power_consumption.txt";

#custom function to read from data
setClass("myDate", representation(date = "character"));
setClass("myTime", representation(time = "character"));
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") );
setAs("character","myTime", function(from) as.POSIXct(from, format="%H:%M:%S") );

#read from file
hpc = read.table(file, header = TRUE, sep = ";", 
		dec = ".",  
		na.strings = "?",
		colClasses = c("myDate", "myTime", rep("numeric", 7)),
		strip.white = TRUE, blank.lines.skip = TRUE
);

summary(hpc);

period <- c(as.Date("2007-02-01"), as.Date("2007-02-02"));
#as.Date("2007-02-01") %in% period

#Filtering out undesired dates and na
hpc2 <- hpc[hpc$Date %in% period,];
hpc3 <- hpc2[complete.cases(hpc2),];

#correcting datetime information
hpc4 <- cbind(
		as.POSIXct(
				paste(
				paste(year(hpc2[,1]),month(hpc2[,1]),day(hpc2[,1]), sep = "-"), 
				paste(hour(hpc2[,2]),minute(hpc2[,2]), sep = ":")
				)
		),
		hpc2[3:9]
)
colnames(hpc4)[1] <-  "Datetime";

write.table(hpc4, 
	file = "C:/Users/g.guida/workspace/ExData_Plotting1/household_power_consumption_01022007_02022007.txt",
	append = FALSE, 
	sep = ",",
	eol = "\n", dec = ".",
	col.names = TRUE,
	row.names = FALSE);

print("File created");
#alternative approach - filtering out while reading
#library(data.table)
#fileNames <- list.files(path = workDir)
#alldata <- rbindlist(
#				lapply(file, function(x) {
#					xx <- fread(x, sep = ';', colClasses = c("myDate", "myTime", rep("numeric", 7)));
#					xx[c("16/12/2006","16/12/2006")];
#				}, 
#			));