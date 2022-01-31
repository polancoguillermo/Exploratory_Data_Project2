## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(dplyr)
library(tidyr)
library(ggplot2)

motor.logical <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)

motor.data <- SCC[motor.logical,]

emission.data <-NEI[NEI$SCC %in% motor.data$SCC,]

emission.data <- summarize(group_by(emission.data, year), emission=sum(Emissions))
emission.data$year <- as.factor(emission.data$year)

ggplot(data=emission.data, aes(x=year, y=(emission/1000), fill=year)) +
  geom_bar(stat="identity")+
  xlab("year") +
  ylab("Total PM2.5 emission in kilotons") +
  ggtitle("Total PM2.5 Emission by year from Motor vehicle")

