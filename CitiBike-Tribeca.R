library(dplyr)
library(geojsonio)
library(geojson)
library(sp)
library(sf)
library(leafpop)
library(mapview)
library(lubridate)

#read in CSVs
setwd('C:/Users/Ari/Desktop/Waywiser/citibike')
jan19 <- read.csv("201901-citibike-tripdata.csv")
feb19 <- read.csv("201902-citibike-tripdata.csv")
mar19 <- read.csv("201903-citibike-tripdata.csv")
apr19 <- read.csv("201904-citibike-tripdata.csv")
may19 <- read.csv("201905-citibike-tripdata.csv")
jun19 <- read.csv("201906-citibike-tripdata.csv")
jul19 <- read.csv("201907-citibike-tripdata.csv")
aug19 <- read.csv("201908-citibike-tripdata.csv")
sep19 <- read.csv("201909-citibike-tripdata.csv")
oct19 <- read.csv("201910-citibike-tripdata.csv")
total19 <- rbind(jan19,feb19,mar19,apr19,may19,jun19,jul19,aug19,sep19,oct19)

jan20 <- read.csv("202001-citibike-tripdata.csv")
feb20 <- read.csv("202002-citibike-tripdata.csv")
mar20 <- read.csv("202003-citibike-tripdata.csv")
apr20 <- read.csv("202004-citibike-tripdata.csv")
may20 <- read.csv("202005-citibike-tripdata.csv")
jun20 <- read.csv("202006-citibike-tripdata.csv")
jul20 <- read.csv("202007-citibike-tripdata.csv")
aug20 <- read.csv("202008-citibike-tripdata.csv")
sep20 <- read.csv("202009-citibike-tripdata.csv")
oct20 <- read.csv("202010-citibike-tripdata.csv")

total20 <- rbind(jan20,feb20,mar20,apr20,may20,jun20,jul20,aug20,sep20,oct20)
total20 <- oct20
rm(oct20)

crs <- "+init=epsg:4326"

#read in NTA geojson 
nei <- geojson_read("C:/Users/Ari/Documents/GitHub/CitiBikeTribeca/Data/NYC_neighborhoods.geojson",  what = "sp")
nei <- st_as_sf(nei)
st_crs(nei) <- crs
mapview::mapview(nei)

#get station locations
stations <- distinct(total20, start.station.id, .keep_all = T)
stations <- stations[c(4,6,7)]
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
end.tribeca <- subset(total20, end.station.id %in% c(328,3461,248,3426,426,3664,249,79,276,309, 146))
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
mapview(start.nei, zcol= "n")+mapview(start.stations, cex = "n", zcol= "n")

mapviewOptions(basemaps = c("CartoDB.Positron"))
mapviewOptions(default = TRUE)
mapviewOptions()

mapview(nei)


#export GEOJSONs for webmap
st_write(start.stations, "start_stations.geojson")
st_write(start.nei, "start_nei.geojson")


#testing leaflet map
m <- leaflet() %>% addProviderTiles(providers$CartoDB.Positron)
               %>% addCircleMarkers(
                 data = start.stations,
                 lng = start.stations$geometry
                 color = ~pal()
               )


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
trips.to$peak_hour<- getmode(end.tribeca$start.nei.name)



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

