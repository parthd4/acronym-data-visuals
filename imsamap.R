#Creates an interactive bubble map of where IMSA students are from.

setwd("/Users/Parth/Desktop/R/phenology_kingsgrove/")

library(maps)
library(mapdata)
library(ggmap)
library(plyr)
library(ggplot2)
library(plotly)
library(ggExtra)

states <- map_data("state")

city.data=read.csv("book4.csv")
imsa=data.frame(lon=c(-88.354291),lat=c(41.785042))


#city.data$lon<-as.numeric(as.character(city.data$lon))
#city.data$lat<-as.numeric(as.character(city.data$lat))


#map(database= "state", col="gray", fill=FALSE)
#map(database= "usa", col="gray", fill=FALSE,add=TRUE, lwd=0.9)   # the overwrite of boundary
#map(database= "usa", col="#AAAAAA22", fill=TRUE,lty=0,add=TRUE)

ill <- subset(states, region == "illinois")
gg1 <- ggplot(data = ill, mapping = aes(x = long, y = lat)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "gray99", fill = "gray")


#points(city.data$lon,city.data$lat)
gg1


a<-gg1+geom_point(data = city.data, aes(x = lon, y = lat, size=TOTAL_CITY), pch=21, fill="steelblue", alpha=1/2, color="steelblue4")+ scale_size(range = c(1, 15))+theme_nothing()
a

mytext=paste("City: ", city.data$Home_city, "\n" , " Total Count: ", city.data$TOTAL_CITY, "\n", "Percent: ",city.data$Percent,"%","\n", sep="")    
pp=plotly_build(a)%>% config(displayModeBar = F)
pp$height=700
pp$width=400
style( pp, text=mytext, hoverinfo = "text", traces = c(1, 2))%>% config(displayModeBar = F) # %>% layout(xaxis=list(fixedrange=TRUE)) %>% layout(yaxis=list(fixedrange=TRUE))


#plotly_POST(sharing="public")

