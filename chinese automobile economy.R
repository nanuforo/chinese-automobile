#instatllation of packages
install.packages("rvest")
install.packages("tidyverse")

#loading the packages
library(readr)
library(tidyverse)
library(dplyr)
library(rvest)
library(scales)


#importing data from chinese association of automobile manufacturers on exports via a wikipedia url

url <- "https://en.wikipedia.org/wiki/Automotive_industry_in_China"

#html content extract
wikipage <- read_html(url)
#tables <-  wikipage %>% html_elements("table")
chinese_exp <- wikipage%>%html_element("table.wikitable")%>%html_table()

#importing chinese export by country data from world international trade statistics
#values are in 1000 of USD

chinese_exp_country <- read_csv("~/chinese automobile/china_globalExp_by_country.csv")

#line plot of chinese exports from 2010 to 2025
chinese_exp %>% 
mutate(passenger = parse_number(`Passenger vehicle`), commercial = parse_number(`Commercial vehicle`), total = parse_number(Total)) %>%
ggplot(aes(Year, passenger))+ 
geom_smooth(size = 1, se = FALSE)+
scale_y_continuous(breaks = seq(0,8e6,by = 1e6), labels = label_number(scale = 1e-6,suffix = "m")) +
labs(y = "passenger cars", title = "Passenger car export by China 2010 - 2025", subtitle = "source: CAAM; Markline")+
theme_classic()
  
chinese_exp_country

