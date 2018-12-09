rm(list=ls())
library(tidyverse)
library(ggridges)

NYCtree <- read_csv("/Users/xiaoyu/Desktop/Final/NYC_Trees.csv")

NYCtree <- NYCtree %>% mutate(health = replace_na(health, "Death"))

borough_2015 <- data.frame(table(NYCtree$borough))

colnames(borough_2015)[colnames(borough_2015) == 'Var1'] <- 'Borough'
borough_2015$Borough <- as.character(borough_2015$Borough)

NYCtree_1995 <- read_csv("/Users/xiaoyu/Desktop/Final/1995.csv")

NYCtree_2005 <- read_csv("/Users/xiaoyu/Desktop/Final/2005.csv")

borough_1995 <- data.frame(table(NYCtree_1995$Borough))
colnames(borough_1995)[colnames(borough_1995) == 'Var1'] <- 'Borough'
borough_1995$Borough <- as.character(borough_1995$Borough)

borough_2005 <- data.frame(table(NYCtree_2005$boroname))
colnames(borough_2005)[colnames(borough_2005) == 'Var1'] <- 'Borough'

borough_2005$Borough <- as.character(borough_2005$Borough)
borough_2005$Borough[borough_2005$Borough == "5"] <- "Staten Island"

borough_1995["Year"] <- "1995"
borough_2005["Year"] <- "2005"
borough_2015["Year"] <- "2015"

borough <- rbind(borough_1995, borough_2005, borough_2015)
colnames(borough)[colnames(borough) == 'Freq'] <- 'Numbers'

str(borough) 

borough %>% ggplot(aes(x = Year, y = Numbers, group = Borough, color = Borough)) + geom_line() +
  ggtitle("tree numbers for earch borough by year")
