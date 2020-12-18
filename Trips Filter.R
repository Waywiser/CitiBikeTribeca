library(tidyr)

#swap in other years, go latest to earliest 
total <- total20

#trips ending in Tribeca
end.tribeca <- subset(total, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))
end.tribeca<- merge(end.tribeca, join, by.x='start.station.id', by.y='station.id', all.x=T)
end.tribeca<- end.tribeca[, !(names(end.tribeca) %in% 'geometry')]
colnames(end.tribeca)[16] <- "start.nei.name"

nrow(end.tribeca[is.na(end.tribeca$start.nei.name),])


########################## add removed stations
#get old dock neighborhoods
nas <- end.tribeca[is.na(end.tribeca$start.nei.name),]
nas <- unique(nas[c("start.station.id", "start.station.name", "start.station.latitude", "start.station.longitude")])

crs <- "+init=epsg:4326"

#read in NTA geojson 
nei <- geojson_read("C:/Users/Ari/Documents/GitHub/CitiBikeTribeca/Other/NYC_neighborhoods.geojson",  what = "sp")
#nei <- geojson_read("/Users/mac/Desktop/waywiser/CitiBikeTribeca/Other/nyc_neighborhoods.geojson",  what = "sp")
nei <- st_as_sf(nei)
st_crs(nei) <- crs

#get station locations
stations <- distinct(nas, start.station.id, .keep_all = T)
colnames(stations)
#stations <- stations[c(4,6,7)] #windows
# stations <- stations[c(5,7,8)] #mac 
colnames(stations) <- c("station.id", "start.station.name", "lat", "lon")

#make spatial stations
stations <- SpatialPointsDataFrame(coords = data.frame(stations$lon, 
                                                       stations$lat),
                                   data = data.frame(stations$station.id),
                                   proj4string = CRS(crs))
stations <- st_as_sf(stations)

#join stations to nta
join_na <- st_join(stations, nei, join = st_intersects)
colnames(join_na)
join_na <- join_na[c(1,5)]
colnames(join_na) <- c("station.id","nei.name","geometry")

join <- rbind(join,join_na)
###############################

end.tribeca<- merge(end.tribeca, join, by.x='start.station.id', by.y='station.id', all.x=T)
end.tribeca<- end.tribeca[, !(names(end.tribeca) %in% 'geometry')]
colnames(end.tribeca)[16] <- "start.nei.name"

#this should be zero now
nrow(end.tribeca[is.na(end.tribeca$nei.name),])



###COUNTING BY STATION
#aggregate to station ID
end.tribeca.stations2020 <- count(end.tribeca, start.station.id)
colnames(end.tribeca.stations2020) <- c("start.station.id","2020")


###COUNTING BY NEIGHBORHOOD
#aggregate to neighborhood
end.tribeca.nei2020 <- count(end.tribeca, nei.name)
colnames(end.tribeca.nei2020) <- c("start.nei.name", "2020")

##########################
##########################
##SUMMARY STATS
#ending by year SUBSCRIBER
ending_by_year_subscriber2020 <- as.data.frame(nrow(end.tribeca[which(end.tribeca$usertype == 'Subscriber'),]))
colnames(ending_by_year_subscriber2020)
colnames(ending_by_year_subscriber2020) <- c("2020")


#ending by year CUSTOMER
ending_by_year_customer2020 <- as.data.frame(nrow(end.tribeca[which(end.tribeca$usertype == 'Customer'),]))
colnames(ending_by_year_customer2020)
colnames(ending_by_year_customer2020) <- "2020"





total <- total16

#trips starting in Tribeca
start.tribeca <- subset(total, !(total$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 )))
start.tribeca <- subset(total, total$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))

#starting by year SUBSCRIBER
starting_by_year_subscriber2016 <- as.data.frame(nrow(start.tribeca[which(start.tribeca$usertype == 'Subscriber'),]))
colnames(starting_by_year_subscriber2016)
colnames(starting_by_year_subscriber2016) <- "2016"

#starting by year CUSTOMER
starting_by_year_customer2016 <- as.data.frame(nrow(start.tribeca[which(start.tribeca$usertype == 'Customer'),]))
colnames(starting_by_year_customer2016)
colnames(starting_by_year_customer2016) <- "2016"


