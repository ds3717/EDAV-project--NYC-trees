rm(list=ls())
library(tidyverse)

mydata <- read_csv("/Users/xiaoyu/Desktop/Final/NYC_Trees.csv")
mydata_1995 <- read_csv("/Users/xiaoyu/Desktop/Final/1995.csv")
mydata_2005 <- read_csv("/Users/xiaoyu/Desktop/Final/2005.csv")

sort(table(mydata$spc_common), decreasing=TRUE)
sort(table(mydata_1995$Spc_Common), decreasing=TRUE)
sort(table(mydata_2005$spc_common), decreasing=TRUE)
#London planetree/honeylocust/Callery pear/pin oak/Norway maple/littleleaf linden/red maple/Japanese zelkova/
#ginkgo/green ash
#MAPLE, NORWAY/LONDON PLANETREE/OAK, PIN/HONEYLOCUST/PEAR, CALLERY/LINDEN, LITTLE LEAF/ZELKOVA, JAPANESE/
#GINKGO/MAPLE, RED/ASH, GREEN

mydata$spc_common[mydata$spc_common == "London planetree"] <- "LONDON PLANETREE"
mydata$spc_common[mydata$spc_common == "honeylocust"] <- "HONEYLOCUST"
mydata$spc_common[mydata$spc_common == "Callery pear"] <- "PEAR, CALLERY"
mydata$spc_common[mydata$spc_common == "pin oak"] <- "OAK, PIN"
mydata$spc_common[mydata$spc_common == "Norway maple"] <- "MAPLE, NORWAY"
mydata$spc_common[mydata$spc_common == "littleleaf linden"] <- "LINDEN, LITTLE LEAF"
mydata$spc_common[mydata$spc_common == "Japanese zelkova"] <- "ZELKOVA, JAPANESE"
mydata$spc_common[mydata$spc_common == "ginkgo"] <- "GINKGO"
mydata$spc_common[mydata$spc_common == "green ash"] <- "ASH, GREEN"
mydata$spc_common[mydata$spc_common == "red maple"] <- "MAPLE, RED"

mydata_2 <- mydata %>% select(tree_dbh, postcode, spc_common) %>% filter(spc_common %in% c("LONDON PLANETREE", "HONEYLOCUST", "PEAR, CALLERY", "OAK, PIN",
                                                                                          "MAPLE, NORWAY", "LINDEN, LITTLE LEAF", "ZELKOVA, JAPANESE",
                                                                                          "GINKGO", "ASH, GREE", "MAPLE, RED"))                                                                        
mydata_2["Year"] <- "2015"

mydata_3 <- mydata_1995 %>% select(Diameter, Zip_New, Spc_Common) %>% filter(Spc_Common %in% c("LONDON PLANETREE", "HONEYLOCUST", "PEAR, CALLERY", "OAK, PIN",
                                                                                           "MAPLE, NORWAY", "LINDEN, LITTLE LEAF", "ZELKOVA, JAPANESE",
                                                                                           "GINKGO", "ASH, GREE", "MAPLE, RED"))                                                                        
mydata_3["Year"] <- "1995"

mydata_4 <- mydata_2005 %>% select(tree_dbh, zipcode, spc_common) %>% filter(spc_common %in% c("LONDON PLANETREE", "HONEYLOCUST", "PEAR, CALLERY", "OAK, PIN",
                                                                                               "MAPLE, NORWAY", "LINDEN, LITTLE LEAF", "ZELKOVA, JAPANESE",
                                                                                               "GINKGO", "ASH, GREE", "MAPLE, RED"))                                                                        
mydata_4["Year"] <- "2005"

colnames(mydata_2)[colnames(mydata_2) == 'postcode'] <- 'zipcode'
colnames(mydata_3)[colnames(mydata_3) == 'Diameter'] <- 'tree_dbh'
colnames(mydata_3)[colnames(mydata_3) == 'Spc_Common'] <- 'spc_common'
colnames(mydata_3)[colnames(mydata_3) == 'Zip_New'] <- 'zipcode'

mydata_5 <- rbind(mydata_2, mydata_3, mydata_4)

write.csv(mydata_5, file = "/Users/xiaoyu/Desktop/Final/interactive_data.csv")

