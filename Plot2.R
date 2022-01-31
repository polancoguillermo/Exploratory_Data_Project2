## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 
#2008? Use the base plotting system to make a plot answering this question.

library(dplyr)
library(tidyr)


NEI2 <- filter(NEI, fips == "24510")

emission.data <- summarize(group_by(NEI2, year), emission=sum(Emissions))

barplot(height=(emission.data$emission),
        names.arg = emission.data$year,
        col=c("Blue", "Red", "Green", "Yellow"),
        ylim=c(0,4000),
        xlab="Year",
        ylab="Total PM2.5 emission in kilotons",
        main="Total PM2.5 Emission by year in Baltimore City")
