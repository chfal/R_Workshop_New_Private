# second dataset: TRIGGER WARNING - suicide, mental health

# what countries have the highest rates and lowest rates of suicide?

# data from gapminder - lots of missing data, estimates
library(tidyverse) # for tidying
library(scales) # for renaming lables

suiciderates<- read_csv("suicide_per_100000_people.csv")

interestingcountries <- c("United States", "United Kingdom", "Australia", "Denmark", "Japan", "Trinidad and Tobago")

suiciderates2 <- suiciderates %>% # data cleaning
  filter(country %in% interestingcountries) %>% # string matching to selected countries
  pivot_longer(cols = 2:68,
               names_to = "year",
               values_to = "rate") # long format because the years as a title of the columns was not helping because we wouldn't then be able to graph by year

suiciderates2$year <- as.numeric(unlist(suiciderates2$year)) # unlist so that we can change number of breaks in graphs - currently viewed years as a list, which is incorrect

ggplot(suiciderates2, aes(x=year, y=rate, color=country)) + #set up gg
  geom_point() + # display data with geom layer
  scale_x_continuous(breaks=pretty_breaks(n=10)) # make pretty breaks  - 10 year gaps

# things to think about: biases in data - more data from eurocentric countries, big gaps (in gapminder ironically)

# still can ask interesting questions - overlap of using gapminder visualizations and code it yourself - again we can have two components

