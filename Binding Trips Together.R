
########BINDING########
colnames(end.tribeca.nei)[2] <- "2020"
end.tribeca.nei<- merge(end.tribeca.nei, end.tribeca.nei2019, by='start.nei.name', all.x=T)
end.tribeca.nei<- merge(end.tribeca.nei, end.tribeca.nei2018, by='start.nei.name', all.x=T)
end.tribeca.nei<- merge(end.tribeca.nei, end.tribeca.nei2017, by='start.nei.name', all.x=T)
end.tribeca.nei<- merge(end.tribeca.nei, end.tribeca.nei2016, by='start.nei.name', all.x=T)

colnames(end.tribeca.stations)[2] <- "2020"
end.tribeca.stations<- merge(end.tribeca.stations, end.tribeca.stations2019, by='start.station.id', all.x=T)
end.tribeca.stations<- merge(end.tribeca.stations, end.tribeca.stations2018, by='start.station.id', all.x=T)
end.tribeca.stations<- merge(end.tribeca.stations, end.tribeca.stations2017, by='start.station.id', all.x=T)
end.tribeca.stations<- merge(end.tribeca.stations, end.tribeca.stations2016, by='start.station.id', all.x=T)

ending_by_year_customer <- ending_by_year_customer2020
ending_by_year_customer$'2019'<- ending_by_year_customer2019$'2019'
ending_by_year_customer$'2018'<- ending_by_year_customer2018$'2018'
ending_by_year_customer$'2017'<- ending_by_year_customer2017$'2017'
ending_by_year_customer$'2016'<- ending_by_year_customer2016$'2016'

ending_by_year_subscriber <- ending_by_year_subscriber2020
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
start.nei$daily.avg <- round((start.nei$'2020'+start.nei$'2019'+start.nei$'2018'+start.nei$'2017'+start.nei$'2016')/(92*5))
start.nei$daily.avg2020 <- round((start.nei$'2020'/92))
start.nei$daily.avg2019 <- round((start.nei$'2019'/92))
start.nei$daily.avg2018 <- round((start.nei$'2018'/92))
start.nei$daily.avg2017 <- round((start.nei$'2017'/92))
start.nei$daily.avg2016 <- round((start.nei$'2016'/92))

colnames(start.nei)



