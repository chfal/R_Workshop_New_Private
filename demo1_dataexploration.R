# the motto of this script: fuck around, find out.

# should you run this? it may be ungodly. only time will tell!

# we are going to explore some data. let's load all necessary libraries.

library(tidyverse)
# this data set has to do with the probability of neonatal death by country. cheery stuff!
pOd<- read_csv("IHME_GBD_2019_U5M_2010_2019_POD_Y2020M12D19.CSV")

placenamesvector <- pOd %>% distinct(location_name) # we can see we are looking through a lot of data that may be repetitive - not sure. state data is not tied nicely to its respective country - is this "doubling up?"

# in 2019, which countries had the highest death rates for newborns (neonatals)?
pOd2 <- pOd %>%
  filter(year_id==2019) %>% #filters to year 2019
  filter(age_group_name=="Early Neonatal") %>% #filters to only neonatals
  arrange(desc(val)) %>%
  top_n(5)

#plot this question
ggplot(pOd2, aes(x=location_name, y=val, color=sex)) +
  geom_point() # looks like: kenya, mali, pakistan - issues with this graph include that it has states that are not linked to countries. 
