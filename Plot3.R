## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(tidyr)
library(ggplot2)


NEI2 <- filter(NEI, fips == "24510")

emission.data <- summarize(group_by(NEI2, year, type), emission=sum(Emissions))
emission.data$year <- as.factor(emission.data$year)

ggplot(data=emission.data, aes(x=year, y=emission, fill=type)) +
  geom_bar(stat="identity")+
  facet_grid(.~type) +
  xlab("year") +
  ylab("Total PM2.5 emission in tons") +
  ggtitle("Total PM2.5 Emission by year in Baltimore City by type")
  
