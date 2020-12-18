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
total16 <- subset(total16, !(start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 )))
total17 <- subset(total17, !(start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 )))
total18 <- subset(total18, !(start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 )))
total19 <- subset(total19, !(start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 )))
total20 <- subset(total20, !(start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 )))


####run first for 2020 numbers, then move to Trips Filter file, swapping out total20 for subsequent years


crs <- "+init=epsg:4326"

#read in NTA geojson 
nei <- geojson_read("C:/Users/Ari/Documents/GitHub/CitiBikeTribeca/Other/NYC_neighborhoods.geojson",  what = "sp")
#nei <- geojson_read("/Users/mac/Desktop/waywiser/CitiBikeTribeca/Other/nyc_neighborhoods.geojson",  what = "sp")
nei <- st_as_sf(nei)
st_crs(nei) <- crs

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

#join start ntas back to join
start.nei <- merge(nei, end.tribeca.nei, by.x='Name', by.y='start.nei.name', all.x=T)



