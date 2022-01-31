## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
#make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)
library(tidyr)

emission.data <- summarize(group_by(NEI, year), emission=sum(Emissions))

barplot(height=(emission.data$emission)/1000,
        names.arg = emission.data$year,
        col=c("Blue", "Red", "Green", "Yellow"),
        ylim=c(0,8000),
        xlab="Year",
        ylab="Total PM2.5 emission in kilotons",
        main="Total PM2.5 Emission by year")
