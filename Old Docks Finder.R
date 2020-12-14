##


#get old dock neighborhoods
nas <- end.tribeca[is.na(end.tribeca$start.nei.name),]
nas <- unique(nas[c("start.station.id", "start.station.name", "start.station.latitude", "start.station.longitude")])

crs <- "+init=epsg:4326"

#read in NTA geojson 
nei <- geojson_read("C:/Users/Ari/Documents/GitHub/CitiBikeTribeca/Other/NYC_neighborhoods.geojson",  what = "sp")
#nei <- geojson_read("/Users/mac/Desktop/waywiser/CitiBikeTribeca/Other/nyc_neighborhoods.geojson",  what = "sp")
nei <- st_as_sf(nei)
st_crs(nei) <- crs
mapview::mapview(nei)

#get station locations
stations <- distinct(nas, start.station.id, .keep_all = T)
colnames(stations)
stations <- stations[c(4,6,7)] #windows
# stations <- stations[c(5,7,8)] #mac 
colnames(stations) <- c("station.id", "start.station.name", "lat", "lon")

#make spatial stations
stations <- SpatialPointsDataFrame(coords = data.frame(stations$lon, 
                                                       stations$lat),
                                   data = data.frame(stations$station.id),
                                   proj4string = CRS(crs))
stations <- st_as_sf(stations)
mapview(stations)+mapview(nei)

#join stations to nta
join_na <- st_join(stations, nei, join = st_intersects)
colnames(join_na)
join_na <- join_na[c(1,5)]
colnames(join_na) <- c("station.id","nei.name","geometry")

join <- rbind(join,join_na)

