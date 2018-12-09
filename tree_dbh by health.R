rm(list=ls())
library(tidyverse)

NYCtree <- read_csv("/Users/xiaoyu/Desktop/Final/NYC_Trees.csv")

NYCtree <- NYCtree %>% mutate(health = replace_na(health, "Death"))

theme_set(theme_classic())

# Histogram on a Continuous (Numeric) Variable
g <- ggplot(NYCtree, aes(tree_dbh)) + scale_fill_brewer(palette = "Spectral")

g + geom_histogram(aes(fill=health), 
                   binwidth = .7, 
                   col="black", 
                   size=.1) +  xlim(0,30) + ggtitle("tree_dbh by health") +
  theme(plot.title = element_text(hjust = 0.5))

