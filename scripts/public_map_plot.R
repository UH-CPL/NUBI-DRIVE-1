library(dplyr)
library(usmap)
library(maps)
library(tidyverse)
library(revgeo)
library(maps)
library(tidygeocoder)
library(ggrepel)

# reading dataset
full_df <- read.csv("NUBI_Drive_All_Data_P21.csv")
model_df <-read.csv("Model_Data_P21.csv")



#merging gps points with the trips included in the model dataframe
model_gps <- merge(model_df, full_df, by=c("P_ID","Day_Num","Trips"), all.x = T, all.y= F)
model_gps <-  model_gps[!is.na(model_gps$Trips),]
model_gps <-  model_gps[!is.na(model_gps$mean_rot_energy),]
model_gps <-  model_gps[!is.na(model_gps$State_Anxiety.x),]
model_gps <-  model_gps[!is.na(model_gps$MD.x),]
model_gps <-  model_gps[!is.na(model_gps$Mean_JF),]
model_gps <-  model_gps[!is.na(model_gps$Live_Lat),]



#remove duplicate gps points to reduce the size of the plot
model_gps <- model_gps[!duplicated(model_gps[,c('Live_Long','Live_Lat')]),]

#less overlapping gps points by reducing accuracy of GPS points
model_gps$Live_Lat <- round(model_gps$Live_Lat, digits = 2)
model_gps$Live_Long <- round(model_gps$Live_Long, digits = 2)
model_gps <- model_gps[!duplicated(model_gps[,c('P_ID','Day_Num','Trips','Live_Long','Live_Lat')]),]

#ensuring the number of trips is as expected

nrow(unique(model_gps[c('P_ID','Day_Num','Trips')]))



#getting participants origin
location <- read.csv("generalized_location.csv")
results<-revgeo(longitude=location$long, 
                latitude=location$lat, 
                provider = 'photon', output="frame")



reverse <- location %>%
  reverse_geocode(lat = lat, long = long, method = 'osm',
                  address = address_found, full_results = TRUE) 
reverse

#manually adding city based on location for unrecognized locations
reverse$city[is.na(reverse$city) & reverse$PID == "P18"] <- "Greenville"
reverse$city[is.na(reverse$city) & reverse$PID == "P29"] <- "Aransas Pass"
reverse$city[is.na(reverse$city) & reverse$PID == "P35"] <- "Grandview"
reverse$city[is.na(reverse$city) & reverse$PID == "P39"] <- "San Antonio"
reverse$city[is.na(reverse$city) & reverse$PID == "P46"] <- "Jarrell"
reverse$city[is.na(reverse$city) & reverse$PID == "P48"] <- "Sherman"
reverse$city[is.na(reverse$city) & reverse$PID == "P52"] <- "Big Spring"

#prepping map variables
us.counties = map_data('county')
states <- us.counties[us.counties$region %in% tolower(reverse$state),]
reverse$county = str_remove_all(reverse$county, " County")
app <- us.counties[paste(us.counties$region, us.counties$subregion) %in% paste(tolower(reverse$state), tolower(reverse$county)),]
#getting texas map
tex <- app[app$region == "texas",]
reverse$city_count <- as.numeric(ave(reverse$city, reverse$city, FUN = length))
p_cities <- data.frame(reverse$city, reverse$lat, reverse$long, reverse$city_count)

#keeping unique cities seperately
p_unique_cities <- p_cities
p_unique_cities <- p_unique_cities[!duplicated(p_unique_cities[,c('reverse.city')]),]



options(ggrepel.max.overlaps = Inf)


#plot data
plot <- ggplot(states, mapping = aes(long, lat, group = group))  + 
  geom_polygon(fill = "dark grey", colour = "grey") +
  coord_equal() +
  theme_void() +
  geom_point(data=model_gps, aes( x = as.numeric(Live_Long), y = as.numeric(Live_Lat),fill=P_ID),pch=21, size=3, stroke = 0.1,inherit.aes = FALSE )+
  scale_fill_discrete(name=NULL)+
  geom_label_repel(data = p_unique_cities , aes( x = as.numeric(reverse.long)+0.06, y = as.numeric(reverse.lat)+0.06, label=reverse.city),size = 5,direction="both", max.overlaps = Inf,colour="black", force=1, box.padding = 1,inherit.aes = FALSE )+
  theme(plot.margin=grid::unit(c(10,10,10,10), "mm"))

#save plot
ggsave(
  "Figure1.pdf",
  width = 11,
  height = 8.5,
  plot
)

