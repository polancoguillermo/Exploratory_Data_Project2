## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(dplyr)
library(tidyr)
library(ggplot2)

emission.data.baltimore <- filter(NEI, fips=="24510", type=="ON-ROAD")
emission.data.baltimore$city <- "Baltimore City, MD"
emission.data <- summarize(group_by(emission.data.baltimore, year, city), emission=sum(Emissions))

emission.data <- summarize(group_by(emission.data, year), emission=sum(Emissions))
emission.data$year <- as.factor(emission.data$year)

ggplot(data=emission.data, aes(x=year, y=(emission), fill=year)) +
  geom_bar(stat="identity")+
  xlab("year") +
  ylab("Total PM2.5 emission in tons") +
  ggtitle("Total PM2.5 Emission by year from Motor vehicle in Baltimore")

