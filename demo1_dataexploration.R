# we are going to explore some data. let's load all necessary libraries.

library(tidyverse) # for tidying data
library(maps) # to get country names
library(gganimate) # to animate
library(scales) # to help with x and y labelling

# this data set has to do with the probability of  death (pOd) by country, specifically of infant neonatals.
pOd<- read_csv("IHME_GBD_2019_U5M_2010_2019_POD_Y2020M12D19.CSV")

# get names of countries only from the maps package because the data set treats location weirdly, and I only want country level data
countrynames <- tibble(iso3166$ISOname)
countrynames <- countrynames %>% rename("location_name"="iso3166$ISOname")

# get only the country data from the pOd data
pOd2 <- left_join(countrynames, pOd)

# exploratory analyses to print which five countries had the highest average of neonatal deaths across the 5 years. now we know which ones had the highest we are going to plot the five highest
pOd3a <- pOd2 %>%
  group_by(location_name) %>% # helpful to summarize within groups - in this case, country
  summarize(mean(val)) %>% #summarize by variable val, which is the model's prediction for probability of death
  top_n(5) # select top 5 distinct entries

#now that we know which are the five highest, we make a vector of five highest countries for infant neonatal death
highest5 <- c("Central African Republic", "Guinea-Bissau", "Mali", "Pakistan", "Nigeria")

pOd3 <- pOd2 %>%
  filter(age_group_name == "Early Neonatal") %>% # only neonatal death
  filter(sex=="Both") %>% # across both males and females - the data set has males, females, and both
  filter(location_name %in% highest5) # we want to filter our data set to the only five countries selected above

#plot this question
graph <- ggplot(pOd3, aes(x=year_id, y=val, color=location_name, frame=year_id)) + #frame_id will help animate this later
  geom_point() + # point graph
  labs(x="Year", y="Infant Mortality Rates") +
  scale_x_continuous(breaks=pretty_breaks()) # helps with scaling

graph #preview what we just made

# now we are going to animate by creating a new gg object with the original graph
graphanim <- graph +
  transition_time(year_id) + # this will help transition time
  shadow_mark() + # this adds layers of dots instead of having the dots move - you'll see
  labs(title="Date: {as.integer(frame_time)}") # this is going to make the title change as the year changes

graphanim # when we run this, we render our gganimate object

anim_save("graph.gif") # we can save this as a gif, to put into dynamic online documents!

# let's look at the graph animation. what story can we tell? do we notice any trends?

# thinking big, what are the implications of the story behind this graph? what has happened to make infant neonatal death probability drop across time? these are interesting connections you should make when you think about this data.