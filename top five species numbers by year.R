rm(list=ls())
library(tidyverse)

NYCtree <- read_csv("/Users/xiaoyu/Desktop/Final/NYC_Trees.csv")

NYCtree <- NYCtree %>% mutate(health = replace_na(health, "Death"))

sort(table(NYCtree$spc_common), decreasing=TRUE)

name2015 <- c('London planetree', 'honeylocust', 'Callery pear', 'pin oak', 'Norway maple')
freq2015 <- c(87014, 64264, 58931, 53185, 34189)
spc2015 <- data.frame(name2015, freq2015)
colnames(spc2015)[colnames(spc2015) == 'name2015'] <- 'Species'
colnames(spc2015)[colnames(spc2015) == 'freq2015'] <- 'Numbers'
spc2015["Year"] <- "2015"

#London planetree/honeylocust/Callery pear/pin oak/Norway maple

NYCtree_1995 <- read_csv("/Users/xiaoyu/Desktop/Final/1995.csv")
sort(table(NYCtree_1995$Spc_Common), decreasing=TRUE)
freq1995 <- c(88040, 33727, 31293, 36553, 109321)
spc1995 <- data.frame(name2015, freq1995)
colnames(spc1995)[colnames(spc1995) == 'name2015'] <- 'Species'
colnames(spc1995)[colnames(spc1995) == 'freq1995'] <- 'Numbers'
spc1995["Year"] <- "1995"

NYCtree_2005 <- read_csv("/Users/xiaoyu/Desktop/Final/2005.csv")
sort(table(NYCtree_2005$spc_common), decreasing=TRUE)
freq2005 <- c(89529, 52191, 63593, 43895, 74721)
spc2005 <- data.frame(name2015, freq2005)
colnames(spc2005)[colnames(spc2005) == 'name2015'] <- 'Species'
colnames(spc2005)[colnames(spc2005) == 'freq2005'] <- 'Numbers'
spc2005["Year"] <- "2005"

spc <- rbind(spc1995, spc2005, spc2015)
spc$Species <- as.character(spc$Species)
spc$Numbers <- as.integer(spc$Numbers)

spc %>% ggplot(aes(x = Year, y = Numbers, group = Species, color = Species)) + geom_line() +
  ggtitle("top five species numbers by year")

