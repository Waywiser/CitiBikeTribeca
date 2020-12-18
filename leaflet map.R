library(leaflet)
library(tidyverse)

start.stations$popup <- ifelse(start.stations$'2020' > 0, 
                               paste0(round((start.stations$'2020'/92), digits = 0), " average daily rides starting from this dock in 2020"),
                               paste0("No daily rides starting from this dock in 2020"))

start.stations$average.daily2020 <- round((start.stations$'2020'/92))
start.stations$average.daily2019 <- round((start.stations$'2019'/92))
start.stations$average.daily2018 <- round((start.stations$'2018'/92))
start.stations$average.daily2017 <- round((start.stations$'2017'/92))
start.stations$average.daily2016 <- round((start.stations$'2016'/92))


#add all stations by year, including ones removed before 2020
station.names16 <- as.data.frame(unique(total16[c("start.station.id", "start.station.name")]))
station.names17 <- as.data.frame(unique(total17[c("start.station.id", "start.station.name")]))
station.names18 <- as.data.frame(unique(total18[c("start.station.id", "start.station.name")]))
station.names19 <- as.data.frame(unique(total19[c("start.station.id", "start.station.name")]))
station.names20 <- as.data.frame(unique(total20[c("start.station.id", "start.station.name")]))

station.names <- rbind(station.names16,station.names17,station.names18,station.names19,station.names20)
station.names <- distinct(station.names, start.station.id, start.station.name)

start.stations <- merge(x = start.stations, y = station.names, by.x = "station.id", by.y= "start.station.id", all.x=TRUE)

start.stations[is.na(start.stations)] <- 0
start.stations2 <- subset(start.stations, station.id %in% station.names20$start.station.id)

map.stations <- start.stations2 %>% extract(geometry, c('lat', 'lon'), '\\((.*), (.*)\\)', convert = TRUE) 
start.nei[is.na(start.nei)] <- 0
map.neighborhoods <- as(start.nei, 'Spatial')

tribeca <- geojson_read("C:/Users/Ari/Documents/GitHub/CitiBikeTribeca/Other/tribeca.geojson",  what = "sp")

mapview::mapview(tribeca)

###MAP SEQUENCE###


#COLOR RAMPS
bins <- c(1, 50, 100, 150, 200, 250, 300, 350)
pal <- colorBin("Blues", domain = map.neighborhoods$daily.avg, bins = bins, na.color=rgb(0,0,0,0))

pal <- colorNumeric(
  palette = "Blues",
  domain = map.neighborhoods$daily.avg)

bins.stations <- c(1, 10, 20, 30, 40, 50, 60, 70)
pal.stations <- colorBin("YlOrRd", domain = map.stations$average.daily2020, bins = bins.stations)

pal.change <- colorNumeric(
  palette = "RdYlGn",
  domain = map.stations.change$avg.annual.chg)

#CUSTOM LABELS
labels2020 <- sprintf(
  "<strong>%s</strong><br/>%g daily trips from here",
  map.neighborhoods$Name , map.neighborhoods$daily.avg2020
) %>% lapply(htmltools::HTML)

labels2019 <- sprintf(
  "<strong>%s</strong><br/>%g daily trips from here",
  map.neighborhoods$Name , map.neighborhoods$daily.avg2019
) %>% lapply(htmltools::HTML)

labels2018 <- sprintf(
  "<strong>%s</strong><br/>%g daily trips from here",
  map.neighborhoods$Name , map.neighborhoods$daily.avg2018
) %>% lapply(htmltools::HTML)

labels2017 <- sprintf(
  "<strong>%s</strong><br/>%g daily trips from here",
  map.neighborhoods$Name , map.neighborhoods$daily.avg2017
) %>% lapply(htmltools::HTML)

labels2016 <- sprintf(
  "<strong>%s</strong><br/>%g daily trips from here",
  map.neighborhoods$Name , map.neighborhoods$daily.avg2016
) %>% lapply(htmltools::HTML)


slabels2020 <- sprintf(
  "<strong>%s</strong><br/>%g daily trips from here",
  map.stations$start.station.name, map.stations$average.daily2020
) %>% lapply(htmltools::HTML)

slabels2019 <- sprintf(
  "<strong>%s</strong><br/>%g daily trips from here",
  map.stations$start.station.name, map.stations$average.daily2019
) %>% lapply(htmltools::HTML)

slabels2018 <- sprintf(
  "<strong>%s</strong><br/>%g daily trips from here",
  map.stations$start.station.name, map.stations$average.daily2018
) %>% lapply(htmltools::HTML)

slabels2017 <- sprintf(
  "<strong>%s</strong><br/>%g daily trips from here",
  map.stations$start.station.name, map.stations$average.daily2017
) %>% lapply(htmltools::HTML)

slabels2016 <- sprintf(
  "<strong>%s</strong><br/>%g daily trips from here",
  map.stations$start.station.name, map.stations$average.daily2016
) %>% lapply(htmltools::HTML)

tribeca.label <- "Tribeca"

#BUILD MAP  
leaflet() %>%
addProviderTiles(providers$CartoDB.Positron) %>%
setView(-74.00054107468239, 40.72361200244055,  zoom = 14) %>%
    
#NEIGHBORHOODS
#2020  
addPolygons(data = map.neighborhoods, 
              fillColor = ~pal(map.neighborhoods$daily.avg2020),
              weight = 2,
              opacity = 1,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.7,
              highlightOptions = highlightOptions(
                weight = 3,
                color = "blue",
                dashArray = "1",
                opacity = 1.0,
                sendToBack = TRUE),
              group = "Neighborhoods 2020",
              label = labels2020) %>%

#2019  
addPolygons(data = map.neighborhoods, 
              fillColor = ~pal(map.neighborhoods$daily.avg2019),
              weight = 2,
              opacity = 1,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.7,
              highlightOptions = highlightOptions(
                weight = 3,
                color = "blue",
                dashArray = "1",
                opacity = 1.0,
                sendToBack = TRUE),
              group = "Neighborhoods 2019",
              label = labels2019) %>%    

#2018 
addPolygons(data = map.neighborhoods, 
              fillColor = ~pal(map.neighborhoods$daily.avg2018),
              weight = 2,
              opacity = 1,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.7,
              highlightOptions = highlightOptions(
                weight = 3,
                color = "blue",
                dashArray = "1",
                opacity = 1.0,
                sendToBack = TRUE),
              group = "Neighborhoods 2018",
              label = labels2018) %>%    

#2017  
addPolygons(data = map.neighborhoods, 
              fillColor = ~pal(map.neighborhoods$daily.avg2017),
              weight = 2,
              opacity = 1,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.7,
              highlightOptions = highlightOptions(
                weight = 3,
                color = "blue",
                dashArray = "1",
                opacity = 1.0,
                sendToBack = TRUE),
              group = "Neighborhoods 2017",
              label = labels2017) %>%    
  
#2016  
addPolygons(data = map.neighborhoods, 
              fillColor = ~pal(map.neighborhoods$daily.avg2016),
              weight = 2,
              opacity = 1,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.7,
              highlightOptions = highlightOptions(
                weight = 3,
                color = "blue",
                dashArray = "1",
                opacity = 1.0,
                sendToBack = TRUE),
              group = "Neighborhoods 2016",
              label = labels2016) %>%    
  
  
#STATION MARKERS 
#2020
addCircleMarkers(data = map.stations,
             ~lat, 
             ~lon,
             fillColor = ~pal.stations(map.stations$average.daily2020),
             radius = ~(average.daily2020)*.8,
             label = slabels2020,
             stroke = T,
             weight = .5,
             color= "black",
             fillOpacity = .85,
             group = "Trips from Docks 2020") %>%
  
#2019
addCircleMarkers(data = map.stations, 
                 ~lat, 
                 ~lon,
                 fillColor = ~pal.stations(map.stations$average.daily2019),
                 radius = ~(average.daily2019)*.8,
                 label = slabels2019,
                 stroke = T,
                 weight = .5,
                 color= "black",
                 fillOpacity = .85,
                 group = "Trips from Docks 2019") %>%
  
#2019
addCircleMarkers(data = map.stations, 
                   ~lat, 
                   ~lon,
                   fillColor = ~pal.stations(map.stations$average.daily2018),
                   radius = ~(average.daily2018)*.8,
                   label = slabels2018,
                   stroke = T,
                   weight = .5,
                   color= "black",
                   fillOpacity = .85,
                   group = "Trips from Docks 2018") %>%
  
#2019
addCircleMarkers(data = map.stations, 
                   ~lat, 
                   ~lon,
                   fillColor = ~pal.stations(map.stations$average.daily2017),
                   radius = ~(average.daily2017)*.8,
                   label = slabels2017,
                   stroke = T,
                   weight = .5,
                   color= "black",
                   fillOpacity = .85,
                   group = "Trips from Docks 2017") %>%  
  
#2019
addCircleMarkers(data = map.stations, 
                   ~lat, 
                   ~lon,
                   fillColor = ~pal.stations(map.stations$average.daily2016),
                   radius = ~(average.daily2016)*.8,
                   label = slabels2016,
                   stroke = T,
                   weight = .5,
                   color= "black",
                   fillOpacity = .85,
                   group = "Trips from Docks 2016") %>%  
  
#Add Tribeca  
addPolygons(data = tribeca, 
              fillColor = 'orange',
              weight = 0,
              opacity = 1,
              color = "white",
              dashArray = "3",
              fillOpacity = 0.5,
              highlightOptions = highlightOptions(
                weight = 3,
                color = "blue",
                dashArray = "1",
                opacity = 1.0,
                sendToBack = TRUE),
              label = tribeca.label) %>%  
  
hideGroup("Neighborhoods 2020")%>%  
hideGroup("Neighborhoods 2019")%>%
hideGroup("Neighborhoods 2018")%>%  
hideGroup("Neighborhoods 2017")%>%  
hideGroup("Neighborhoods 2016")%>%  
hideGroup("Trips from Docks 2019")%>% 
hideGroup("Trips from Docks 2018")%>% 
hideGroup("Trips from Docks 2017")%>% 
hideGroup("Trips from Docks 2016")%>% 

#LEGENDS
  addLegend(values = map.neighborhoods$daily.avg, group = "Neighborhoods", title = "Daily Average Trips from Neighborhood", position = "bottomleft", labels = "2" , pal = pal) %>%
  addLegend(values = map.stations$average.daily2020, group = "Trips from Docks 2020", title = "Daily Average Trips from Dock", position = "bottomleft", labels = "1", pal=pal.stations)%>%
  addLayersControl(baseGroups = c("Trips from Docks 2020", 
                                  "Trips from Docks 2019", 
                                  "Trips from Docks 2018", 
                                  "Trips from Docks 2017", 
                                  "Trips from Docks 2016",
                                  "Neighborhoods 2020", 
                                  "Neighborhoods 2019",
                                  "Neighborhoods 2018",
                                  "Neighborhoods 2017",
                                  "Neighborhoods 2016"),
                   options = layersControlOptions(collapsed = FALSE))

