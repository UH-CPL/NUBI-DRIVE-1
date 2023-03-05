library(dplyr)
library(ggplot2)
library(tidyverse)
library(lubridate)
library(scales)
library(plotly)
library(patchwork)
library(grid)
library(ggbreak) 
library(ggh4x)
#time function
get_time <- function(col) {
  return(as.POSIXct(strptime(col, "%Y-%m-%d %H:%M:%S"), format = "%H:%M:%S"))
  
}


#getting the figure data
#model_time <-read.csv("Blinded_All_Data.csv")
model_time <- read.csv("Blinded_P27_Data.csv")

#create trip ID variable
model_time_validation <- model_time %>%                                        # Create ID by group
  group_by(P_ID, Day_Num, Trips) %>%
  dplyr::mutate(trip_ID = cur_group_id())

#checking number of trips
flag <- length(unique(model_time_validation$trip_ID))
flag

#preparing variables
model_time_validation$formatted_time <- format(get_time(model_time$Time),"%H:%M:%S")
model_time_validation$short_time<- as.POSIXct(model_time_validation$formatted_time,format="%H:%M:%S")
model_time_validation$Trip_Time <- factor(model_time_validation$Trip_Time, levels=c("Morning", "Afternoon"))
model_time_validation$Days <- factor(model_time_validation$Days, levels=c("WeekDays", "WeekEnd"))

#choosing one participant 
model_time_validation_single<- model_time_validation[model_time_validation$P_ID=="P27",]

#translating daynames to actual names
model_time_validation_single$day_name <- recode(model_time_validation_single$Day_Num, 
                                                "Day1"="Monday",
                                                "Day2"="Tuesday",
                                                "Day3"="Wednesday",
                                                "Day4"="Thursday",
                                                "Day5"="Friday",
                                                "Day6"="Saturday",
                                                "Day7"="Sunday")

model_time_validation_single$day_name <- factor(model_time_validation_single$day_name, levels = c("Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"))

# weekdays trips
trips_wd <- model_time_validation_single[model_time_validation_single$Days =="WeekDays", ]
n_wd= as.numeric(length(unique(trips_wd$trip_ID)))

#Trips that were soncsidered as 1 trip while having short speration period are sperated for the sake of plotting acurately for P27 
#times were trips were speperated by a short stop
time1a = "16:25:06"
time1b= "17:00:00"
time2a= "16:19:30"
time2b= "16:45:02"
time3a= "07:00:00"
time3b= "07:03:02"

trips_wd$trip_ID[trips_wd$trip_ID == 7 & trips_wd$short_time > as.POSIXct(time1a,format="%H:%M:%S") & trips_wd$short_time < as.POSIXct(time1b,format="%H:%M:%S")] <- 300
trips_wd$trip_ID[trips_wd$trip_ID == 12 & trips_wd$short_time > as.POSIXct(time2a,format="%H:%M:%S") & trips_wd$short_time < as.POSIXct(time2b,format="%H:%M:%S")] <- 301
trips_wd$trip_ID[trips_wd$trip_ID == 1 & trips_wd$short_time >= as.POSIXct(time3a,format="%H:%M:%S") & trips_wd$short_time < as.POSIXct(time3b,format="%H:%M:%S")] <- 302

#weekend trips
trips_nd <- model_time_validation_single[model_time_validation_single$Days =="WeekEnd", ]
n_nd= as.numeric(length(unique(trips_nd$trip_ID)))
######weekdays limits

lims <- as.POSIXct(strptime(c("06:00","21:00"), format = "%H:%M"))    


#### weekday plots
#time cloumn
x_df <- rep(trips_wd$short_time,4)
#number of rows
nr_wd<- nrow(trips_wd)
#value column
y_df = c(trips_wd$Raw_HR,trips_wd$Speed,trips_wd$JF,trips_wd$Weather_Info)
#label column
label = c(rep("HR [BPM]",nr_wd),rep("Speed [MPH]",nr_wd),rep("Jam Factor",nr_wd),rep("Weather",nr_wd))
#day column
day_nam <- rep(trips_wd$day_name,4)
#trip column
trip_num <- rep(trips_wd$trip_ID,4)
#create dataframe for plotting
df_test_final <- data.frame(x_df,y_df,label,day_nam,trip_num)
#remove NA values 
df_test_final <- df_test_final[!is.na(df_test_final$y_df),]
#plotting variables
p <- ggplot(df_test_final, aes(x=x_df, y=y_df, group=trip_num, colour=day_nam),na.rm = T) +
  geom_line(alpha=0.6,na.rm = T) +labs(tag = paste0("n=",n_wd)) +
  scale_x_datetime(name="" ,limits = lims,breaks = "1 hour", labels = scales::date_format("%H:%M",tz = Sys.timezone()))+ 
  scale_color_manual(values = c("blue","red","dark green","orange","darkorchid"), name=NULL,labels= c("Monday","Tuesday","Wednesday","Thursday","Friday"))+ 
  theme( plot.tag = element_text(face = "italic",size = 14),plot.tag.position = c(0.1, 0.85),legend.position = "top",axis.title.y = element_blank(),axis.text.y = element_text(size=14),
         panel.grid.major.x = element_blank(),panel.grid.major.y = element_blank(),panel.grid.minor = element_blank(), panel.background = element_blank(),axis.line.y = element_line(colour = "black"),axis.line.x = element_line(colour = "black"),legend.key = element_rect(colour = NA, fill = NA)) 
scales <- list(
  scale_y_continuous(),
  scale_y_continuous(),
  scale_y_continuous(),
  scale_y_discrete(limits=factor(c(1,2,3,4)),labels =c("clear","cloud","rain","other"))
)
#separate by label ans format
p <- p +facet_wrap(vars(label),
                   scales="free_y",
                   strip.position="right",
                   nrow=4) +
  facetted_pos_scales(y = scales) + 
  theme( axis.text = element_text( size = 14 ),
        strip.text = element_text(size = 15),legend.text=element_text(size=12))

#adding breaks to allow better vision of lines

p <- p+ scale_x_break(c(as.POSIXct(strptime(c("07:10","11:00"), format = "%H:%M")) )) 
p <- p+ scale_x_break(c(as.POSIXct(strptime(c("12:30","16:00"), format = "%H:%M")) )) 
p <- p+ scale_x_break(c(as.POSIXct(strptime(c("17:10","17:45"), format = "%H:%M")) )) 
p <- p+ scale_x_break(c(as.POSIXct(strptime(c("19:30","20:30"), format = "%H:%M")) )) 
p
#save

pdf.options(reset = TRUE, onefile = FALSE)
ggsave(file="Figure3.pdf",plot=p,device="pdf",width=11,height=8)


######weekend limits

lims <- as.POSIXct(strptime(c("07:00","20:00"), format = "%H:%M"))    


####weekend plots
#time column
x_df <- rep(trips_nd$short_time,4)
#number of rows
nr_nd<- nrow(trips_nd)
#value column
y_df = c(trips_nd$Raw_HR,trips_nd$Speed,trips_nd$JF,trips_nd$Weather_Info)
#label column
label = c(rep("HR [BPM]",nr_nd),rep("Speed [MPH]",nr_nd),rep("Jam Factor",nr_nd),rep("Weather",nr_nd))
#day column
day_nam <- rep(trips_nd$day_name,4)
#trip clumn
trip_num <- rep(trips_nd$trip_ID,4)
#crerate  datafrem for ploting
df_test_final <- data.frame(x_df,y_df,label,day_nam,trip_num)
#removing na values
df_test_final <- df_test_final[!is.na(df_test_final$y_df),]
#plotting varaibles
p <- ggplot(df_test_final, aes(x=x_df, y=y_df, group=trip_num, colour=day_nam),na.rm = T) +
  geom_line(alpha=0.6,na.rm = T) +labs(tag = paste0("n = ",n_nd)) +
  scale_x_datetime(name="" ,limits = lims,breaks = "1 hour", labels = scales::date_format("%H:%M",tz = Sys.timezone()))+ 
  scale_color_manual(values = c("brown","limegreen"), name=NULL,labels= c("Saturday","Sunday"))+ 
  theme( plot.tag = element_text(face = "italic",size = 14),plot.tag.position = c(0.1, 0.85),legend.position = "top",axis.title.y = element_blank(),axis.text.y = element_text(size=14),
         panel.grid.major.x = element_blank(),panel.grid.major.y = element_blank(),panel.grid.minor = element_blank(), panel.background = element_blank(),axis.line.y = element_line(colour = "black"),axis.line.x = element_line(colour = "black"),legend.key = element_rect(colour = NA, fill = NA),) 
scales <- list(
  scale_y_continuous(),
  scale_y_continuous(),
  scale_y_continuous(),
  scale_y_discrete(limits=factor(c(1,2,3,4)),labels =c("clear","cloud","rain","other"))
)
#separate by label ans format
p <- p +facet_wrap(vars(label),
                   scales="free_y",
                   strip.position="right",
                   nrow=4) +
  facetted_pos_scales(y = scales) + 
  theme( axis.text = element_text( size = 14 ),
         strip.text = element_text(size = 15),legend.text=element_text(size=12))

#adding breaks to allow better vision of lines
p <- p+ scale_x_break(c(as.POSIXct(strptime(c("08:15","12:45"), format = "%H:%M")) )) 
p <- p+ scale_x_break(c(as.POSIXct(strptime(c("13:15","16:45"), format = "%H:%M")) )) 
p <- p+ scale_x_break(c(as.POSIXct(strptime(c("17:15","18:45"), format = "%H:%M")) )) 
p

#save
pdf.options(reset = TRUE, onefile = FALSE)
ggsave(file="Figure3_weekend.pdf",plot=p,device="pdf",width=11,height=8)





