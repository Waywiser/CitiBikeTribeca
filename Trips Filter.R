library(tidyr)

#trips ending in Tribeca
end.tribeca <- subset(total, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))
end.tribeca<- merge(end.tribeca, join, by.x='start.station.id', by.y='station.id', all.x=T)
end.tribeca<- end.tribeca[, !(names(end.tribeca) %in% 'geometry')]
colnames(end.tribeca)[16] <- "start.nei.name"

nrow(end.tribeca[is.na(end.tribeca$start.nei.name),])


###COUNTING BY STATION
#aggregate to station ID
end.tribeca.stations2019 <- count(end.tribeca, start.station.id)
colnames(end.tribeca.stations2019) <- c("start.station.id","2019")


###COUNTING BY NEIGHBORHOOD
#aggregate to neighborhood
end.tribeca.nei2019 <- count(end.tribeca, start.nei.name)
colnames(end.tribeca.nei2019) <- c("start.nei.name", "2019")


##########################
##########################
##SUMMARY STATS
#ending by year SUBSCRIBER
ending_by_year_subscriber2019 <- as.data.frame(nrow(end.tribeca[which(end.tribeca$usertype == 'Subscriber'),]))
colnames(ending_by_year_subscriber2019)
colnames(ending_by_year_subscriber2019) <- c("2019")


#ending by year CUSTOMER
ending_by_year_customer2019 <- as.data.frame(nrow(end.tribeca[which(end.tribeca$usertype == 'Customer'),]))
colnames(ending_by_year_customer2019)
colnames(ending_by_year_customer2019) <- "2019"

#trips starting in Tribeca
start.tribeca <- subset(total, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))

#starting by year SUBSCRIBER
starting_by_year_subscriber2019 <- as.data.frame(nrow(start.tribeca[which(start.tribeca$usertype == 'Subscriber'),]))
colnames(starting_by_year_subscriber2019)
colnames(starting_by_year_subscriber2019) <- "2019"

#starting by year CUSTOMER
starting_by_year_customer2019 <- as.data.frame(nrow(start.tribeca[which(start.tribeca$usertype == 'Customer'),]))
colnames(starting_by_year_customer2019)
colnames(starting_by_year_customer2019) <- "2019"






########BINDING########
end.tribeca.nei<- merge(end.tribeca.nei, end.tribeca.nei2019, by='start.nei.name', all.x=T)
end.tribeca.nei<- merge(end.tribeca.nei, end.tribeca.nei2018, by='start.nei.name', all.x=T)
end.tribeca.nei<- merge(end.tribeca.nei, end.tribeca.nei2017, by='start.nei.name', all.x=T)
end.tribeca.nei<- merge(end.tribeca.nei, end.tribeca.nei2016, by='start.nei.name', all.x=T)

end.tribeca.stations<- merge(end.tribeca.stations, end.tribeca.stations2019, by='start.station.id', all.x=T)
end.tribeca.stations<- merge(end.tribeca.stations, end.tribeca.stations2018, by='start.station.id', all.x=T)
end.tribeca.stations<- merge(end.tribeca.stations, end.tribeca.stations2017, by='start.station.id', all.x=T)
end.tribeca.stations<- merge(end.tribeca.stations, end.tribeca.stations2016, by='start.station.id', all.x=T)

ending_by_year_customer$'2019'<- ending_by_year_customer2019$'2019'
ending_by_year_customer$'2018'<- ending_by_year_customer2018$'2018'
ending_by_year_customer$'2017'<- ending_by_year_customer2017$'2017'
ending_by_year_customer$'2016'<- ending_by_year_customer2016$'2016'

ending_by_year_subscriber$'2019'<- ending_by_year_subscriber2019$'2019'
ending_by_year_subscriber$'2018'<- ending_by_year_subscriber2018$'2018'
ending_by_year_subscriber$'2017'<- ending_by_year_subscriber2017$'2017'
ending_by_year_subscriber$'2016'<- ending_by_year_subscriber2016$'2016'

starting_by_year_subscriber$'2019' <- starting_by_year_subscriber2019$'2019' 
starting_by_year_subscriber$'2018' <- starting_by_year_subscriber2018$'2018' 
starting_by_year_subscriber$'2017' <- starting_by_year_subscriber2017$'2017' 
starting_by_year_subscriber$'2016' <- starting_by_year_subscriber2016$'2016' 

starting_by_year_customer$'2019' <- starting_by_year_customer2019$'2019' 
starting_by_year_customer$'2018' <- starting_by_year_customer2018$'2018' 
starting_by_year_customer$'2017' <- starting_by_year_customer2017$'2017' 
starting_by_year_customer$'2016' <- starting_by_year_customer2016$'2016' 



setwd('C:/Users/Ari/Documents/GitHub/CitiBikeTribeca/Other/data')
write.csv(end.tribeca.nei, "Ending in Tribeca - by Neighborhood", row.names=F)
write.csv(end.tribeca.stations, "Ending in Tribeca - by Station", row.names = F)
write.csv(ending_by_year_customer, "Ending in Tribeca - Customers", row.names = F)
write.csv(ending_by_year_subscriber, "Ending in Tribeca - Subscribers", row.names = F)
write.csv(starting_by_year_subscriber, "Starting in Tribeca - Subscribers", row.names = F)
write.csv(starting_by_year_customer, "Starting in Tribeca - Customers", row.names = F)




#run at end
#join start stations back to join
start.stations <- merge(join, end.tribeca.stations, by.x='station.id', by.y='start.station.id', all.x=T)
colnames(start.stations)

write.csv(start.stations, "Annual Change - Stations")

start.stations_change <- start.stations %>% drop_na()
start.stations_change$avg.annual.chg <- (((start.stations_change$'2017'-start.stations_change$'2016')/start.stations_change$'2016')+
                                        ((start.stations_change$'2018'-start.stations_change$'2017')/start.stations_change$'2017')+
                                        ((start.stations_change$'2019'-start.stations_change$'2018')/start.stations_change$'2018')+
                                        ((start.stations_change$'2020'-start.stations_change$'2019')/start.stations_change$'2019'))/4

#may want to consider setting a rides threshold

#join start ntas back to join
start.nei <- merge(nei, end.tribeca.nei, by.x='Name', by.y='start.nei.name', all.x=T)


colnames(start.nei)




