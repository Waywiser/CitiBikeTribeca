library(dplyr)
library(geojsonio)
library(geojson)
library(sp)
library(sf)
library(leafpop)
library(mapview)
library(lubridate)

setwd('C:/Users/Ari/Desktop/Waywiser/citibike')

#read in CSVs
aug16 <- read.csv("201608-citibike-tripdata.csv")
sep16 <- read.csv("201609-citibike-tripdata.csv")
oct16 <- read.csv("201610-citibike-tripdata.csv")
colnames(oct16) <- c("tripduration"        ,    "starttime"          ,     "stoptime"          ,      "start.station.id",       
                     "start.station.name"    ,  "start.station.latitude" , "start.station.longitude" ,"end.station.id",         
                      "end.station.name"    ,    "end.station.latitude" ,   "end.station.longitude" ,  "bikeid",                 
                      "usertype"            ,    "birth.year"   ,           "gender")
total16 <- rbind(aug16,sep16,oct16)
rm(aug16, sep16, oct16)

aug17 <- read.csv("201708-citibike-tripdata.csv")
sep17 <- read.csv("201709-citibike-tripdata.csv")
oct17 <- read.csv("201710-citibike-tripdata.csv")
total17 <- rbind(aug17,sep17,oct17)
rm(aug17, sep17, oct17)

aug18 <- read.csv("201808-citibike-tripdata.csv")
sep18 <- read.csv("201809-citibike-tripdata.csv")
oct18 <- read.csv("201810-citibike-tripdata.csv")
total18 <- rbind(aug18,sep18,oct18)
rm(aug18, sep18, oct18)


aug19 <- read.csv("201908-citibike-tripdata.csv")
sep19 <- read.csv("201909-citibike-tripdata.csv")
oct19 <- read.csv("201910-citibike-tripdata.csv")
total19 <- rbind(aug19,sep19,oct19)
rm(aug19, sep19, oct19)

aug20 <- read.csv("202008-citibike-tripdata.csv")
sep20 <- read.csv("202009-citibike-tripdata.csv")
oct20 <- read.csv("202010-citibike-tripdata.csv")
total20 <- rbind(aug20,sep20,oct20)
rm(aug20, sep20, oct20)

#remove trips starting in Tribeca
total18 <- subset(total18, !(start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 )))
total <- total16


crs <- "+init=epsg:4326"

#read in NTA geojson 
nei <- geojson_read("C:/Users/Ari/Documents/GitHub/CitiBikeTribeca/Other/NYC_neighborhoods.geojson",  what = "sp")
#nei <- geojson_read("/Users/mac/Desktop/waywiser/CitiBikeTribeca/Other/nyc_neighborhoods.geojson",  what = "sp")
nei <- st_as_sf(nei)
st_crs(nei) <- crs
mapview::mapview(nei)

#get station locations
stations <- distinct(total20, start.station.id, .keep_all = T)
colnames(stations)
stations <- stations[c(4,6,7)] #windows
# stations <- stations[c(5,7,8)] #mac 
colnames(stations) <- c("station.id", "lat", "lon")

#make spatial stations
stations <- SpatialPointsDataFrame(coords = data.frame(stations$lon, 
                                                    stations$lat),
                                                    data = data.frame(stations$station.id),
                                                    proj4string = CRS(crs))
stations <- st_as_sf(stations)
mapview(stations)+mapview(nei)

#join stations to nta
join <- st_join(stations, nei, join = st_intersects)
join <- join[c(1,5,7)]
colnames(join) <- c("station.id","nei.name","geometry")

#trips ending in Tribeca
end.tribeca <- subset(total20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))
end.tribeca<- merge(end.tribeca, join, by.x='start.station.id', by.y='station.id', all.x=T)
end.tribeca<- end.tribeca[, !(names(end.tribeca) %in% 'geometry')]
colnames(end.tribeca)[16] <- "start.nei.name"

#aggregate to station ID
end.tribeca.stations <- count(end.tribeca, start.station.id)

#aggregate to neighborhood
end.tribeca.nei <- count(end.tribeca, start.nei.name)

#join start stations back to join
start.stations <- merge(join, end.tribeca.stations, by.x='station.id', by.y='start.station.id', all.x=T)
mapview::mapview(start.stations, cex = "n", zcol= "n")


#join start ntas back to join
start.nei <- merge(nei, end.tribeca.nei, by.x='Name', by.y='start.nei.name', all.x=T)



############### mapping options ###########
###########################################
###########################################
###########################################

#export GEOJSONs for webmap
st_write(start.stations, "start_stations.geojson", append=F)
st_write(start.nei, "start_nei.geojson", append = F)


###########################################
###########################################
###########################################
###########################################





################ By year ####################
ending_by_year <- as.data.frame(nrow(end.tribeca))
colnames(ending_by_year) <- "2020"

ending_by_year$e2019 <- as.data.frame(nrow(end.tribeca))
ending_by_year$e2018 <- as.data.frame(nrow(end.tribeca))
ending_by_year$e2017 <- as.data.frame(nrow(end.tribeca))
ending_by_year$e2016 <- as.data.frame(nrow(end.tribeca))
colnames(ending_by_year) <- c("2020", "2019", "2018", "2017", '2016')







#summary statistics
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

trips.to <- as.data.frame(1)
trips.to$pct_subscriber <- sum(end.tribeca$usertype == "Subscriber")/nrow(end.tribeca)
trips.to$pct_male <- sum(end.tribeca$gender == 1)/nrow(end.tribeca)
trips.to$pct_female <- sum(end.tribeca$gender == 2)/nrow(end.tribeca) #check
trips.to$gender_unk <- sum(end.tribeca$gender == 0)/nrow(end.tribeca)
trips.to$most_common_nei <- getmode(end.tribeca$start.nei.name)

trips <- as.data.frame(table(end.tribeca$start.station.id, end.tribeca$end.station.id))

trips.to$peak_hour<- getmode(end.tribeca$start.nei.name)
inout <- end.tribeca[which(end.tribeca$start.station.id == 3664 & end.tribeca$end.station.id == 3664),]
median(inout$tripduration)

sample <- end.tribeca[c(1:10),]

sample$starttime <- strptime(as.character(sample$starttime),"%Y-%m-%d %H:%M:%S")
sample$date <- as.Date(sample$starttime)
sample$time <- format(sample$starttime,"%H:%M:%S")
sample$time <- strptime(as.character(sample$starttime),"%H:%M:%S")

floor_date(
  sample$time,
  unit = "hours",
  week_start = getOption("lubridate.week.start", 7)
)

