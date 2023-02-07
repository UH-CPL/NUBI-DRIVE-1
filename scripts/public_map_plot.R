library(dplyr)
library(usmap)
library(maps)
library(tidyverse)
library(revgeo)
library(maps)
library(ggmap)
library(tidygeocoder)
library(ggrepel)


#reading locations to plot
locations<-read.csv("participants_cities.csv") 

#prepping map variables

us.counties = map_data('county')
states <- us.counties[us.counties$region %in% tolower(locations$state),]
locations$county = str_remove_all(locations$county, " County")
app <- us.counties[paste(us.counties$region, us.counties$subregion) %in% paste(tolower(locations$state), tolower(locations$county)),]

#getting texas map
tex <- app[app$region == "texas",]
locations$city_count <- as.numeric(ave(locations$city, locations$city, FUN = length))
p_cities <- data.frame(locations$city, locations$lat, locations$lon, locations$city_count)

#keeping unique cities seperately
p_unique_cities <- p_cities[!duplicated(p_cities[,c('locations.city')]),]


#keeps labels from overlaping
options(ggrepel.max.overlaps = Inf)


#plot data
plot <- ggplot(states, mapping = aes(long, lat, group = group))  + 
  geom_polygon(fill = " grey", colour = "light grey") +
  coord_equal() +
  theme_void() +
  geom_point(data=locations, aes( x = as.numeric(lon), y = as.numeric(lat),fill=PID),pch=21, size=3, stroke = 0.25,inherit.aes = FALSE,position=position_jitter(h=0,w=0.1), alpha = 0.75 )+
  scale_fill_discrete(name=NULL)+
  geom_label_repel(data = p_unique_cities , aes( x = as.numeric(locations.lon)+0.06, y = as.numeric(locations.lat)+0.06, label=paste0(locations.city," / ",locations.city_count)),size = 5,direction="both", max.overlaps = Inf,colour="black", force=1, box.padding = 1,inherit.aes = FALSE )+
  theme(plot.margin=grid::unit(c(10,10,10,10), "mm"))

#save plot
ggsave(
  "Figure1.pdf",
  width = 11,
  height = 8.5,
  plot
)


