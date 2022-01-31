## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
#motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(tidyr)
library(ggplot2)


emission.data.baltimore <- filter(NEI, fips=="24510", type=="ON-ROAD")
emission.data.baltimore$city <- "Baltimore City, MD"

emission.data.la <- filter(NEI, fips=="06037", type=="ON-ROAD")
emission.data.la$city <- "Los Angeles, CA"

emission.data.baltimore <- summarize(group_by(emission.data.baltimore, year, city), emission=sum(Emissions))
emission.data.la<- summarize(group_by(emission.data.la, year, city), emission=sum(Emissions))

emission.data <- rbind(emission.data.baltimore, emission.data.la)
emission.data$year <- as.factor(emission.data$year)

ggplot(data=emission.data, aes(x=year, y=emission, fill=city)) +
  geom_bar(stat="identity")+
  facet_grid(city~., scales="free")+
  xlab("year") +
  ylab("Total PM2.5 emission in tons") +
  ggtitle("Total PM2.5 Emission by year from Motor vehicle in LA vs Baltimore")

