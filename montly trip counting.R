

jan20 <- subset(jan20, !(jan20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & jan20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('jan20 entering:', nrow(subset(jan20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('jan20 leaving:', nrow(subset(jan20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(jan20)

feb20 <- subset(feb20, !(feb20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & feb20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('feb20 entering:', nrow(subset(feb20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('feb20 leaving:', nrow(subset(feb20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(feb20)

mar20 <- subset(mar20, !(mar20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & mar20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('mar20 entering:', nrow(subset(mar20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('mar20 leaving:', nrow(subset(mar20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(mar20)

apr20 <- subset(apr20, !(apr20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & apr20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('apr20 entering:', nrow(subset(apr20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('apr20 leaving:', nrow(subset(apr20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(apr20)

may20 <- subset(may20, !(may20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & may20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('may20 entering:', nrow(subset(may20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('may20 leaving:', nrow(subset(may20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(may20)

jun20 <- subset(jun20, !(jun20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & jun20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('jun20 entering:', nrow(subset(jun20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('jun20 leaving:', nrow(subset(jun20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(jun20)

jul20 <- subset(jul20, !(jul20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & jul20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('jul20 entering:', nrow(subset(jul20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('jul20 leaving:', nrow(subset(jul20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(jul20)

aug20 <- subset(aug20, !(aug20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & aug20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('aug20 entering:', nrow(subset(aug20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('aug20 leaving:', nrow(subset(aug20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(aug20)

sep20 <- subset(sep20, !(sep20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & sep20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('sep20 entering:', nrow(subset(sep20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('sep20 leaving:', nrow(subset(sep20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(sep20)

oct20 <- subset(oct20, !(oct20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & oct20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('oct20 entering:', nrow(subset(oct20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('oct20 leaving:', nrow(subset(oct20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(oct20)

nov20 <- subset(nov20, !(nov20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & nov20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('nov20 entering:', nrow(subset(nov20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('nov20 leaving:', nrow(subset(nov20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(nov20)

dec20 <- subset(dec20, !(dec20$start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257) & dec20$end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257)))
paste('dec20 entering:', nrow(subset(dec20, end.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
paste('dec20 leaving:', nrow(subset(dec20, start.station.id %in% c(309, 3461, 417, 3690, 152, 146, 276, 249, 320, 79, 3664, 3436, 248, 328, 257 ))))
rm(dec20)





             