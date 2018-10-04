#Graphs IMSA racial demographics over time and school district origination

setwd("/Users/Parth/Desktop/R/phenology_kingsgrove/")

library(ggplot2)
library(gridExtra)
library(googleVis)
library(plotly)

foia.data <- read.csv("foia.csv")

stack.data <- read.csv("finalstack.csv")

bubble.data <- read.csv("bubblemap.csv")

b.data<-read.csv("bubblefinal.csv")

bc.data<-read.csv("bubblemapcombined.csv")

#create line chart
q <- ggplot(data=foia.data, aes(x=Graduating_Class, y=Percent, colour=Race)) + scale_color_brewer(palette="Paired") +
  geom_line()+labs(x="Graduating Class", y="Percent of Incoming Class")+theme_gray()
q


#Create stacked bar chart
q <- ggplot(data=stack.data, aes(x=Graduating_Class, y=Percent, fill=Race)) +
  geom_bar(stat="identity")+theme_grey()+labs(x="Graduating Class", y="Percent of Incoming Class")
q


ggplotly(q)# %>%layout(xaxis=list(fixedrange=TRUE)) %>%# layout(yaxis=list(fixedrange=TRUE))




#plotly_POST(sharing="public")

library(plotly)


#colors <- c('rgb(211,94,96)', 'rgb(128,133,133)')

x=c('Top 20 School Districts','Rest of School Districts (Bottom 445)')
y=c(2748,4133)

p <- plot_ly(data.frame(x,y), labels = ~x, values = ~y, type = 'pie',
             textposition = 'inside',
             textinfo = 'label+percent',
             insidetextfont = list(color = '#FFFFFF'),
             hoverinfo = 'text',
             text = ~paste(y,"students"),
             marker = list(colors = colors,
                           line = list(color = '#FFFFFF', width = 0)),
             #The 'pull' attribute can also be used to create space between the sectors
             showlegend = FALSE) %>%
  layout(title = 'School District Diversity',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
p


d <- plot_ly(b.data, labels = ~School_District, values = ~Count, type = 'pie',
             textposition = 'inside',
             textinfo = 'label+percent',
             insidetextfont = list(color = '#FFFFFF'),
             hoverinfo = 'text',
             text = ~paste(School_District,":",Count,"students"),
             marker = list(colors = colors,
                           line = list(color = '#FFFFFF', width = 0)),
             #The 'pull' attribute can also be used to create space between the sectors
             showlegend = FALSE) %>%
  layout(title = 'The Top 25 School Districts',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
d

d <- plot_ly(bc.data, labels = ~School_District, values = ~Count, type = 'pie',
             textposition = 'inside',
             textinfo = 'label+percent',
             insidetextfont = list(color = '#FFFFFF'),
             hoverinfo = 'text',
             text = ~paste(School_District,":",Count,"students"),
             marker = list(colors = colors,
                           line = list(color = '#FFFFFF', width = 0)),
             #The 'pull' attribute can also be used to create space between the sectors
             showlegend = FALSE) %>%
  layout(title = 'Top 20 School Districts',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
d

#plotly_POST(d, filename="pie")


#api_create(x = last_plot(), filename = NULL,
           #fileopt = "overwrite", sharing = "public")


b.data$School_District <- reorder(b.data$School_District, b.data$Count)
b.data$School_District <- factor(b.data$School_District, levels=rev(levels(b.data$School_District)))

q <- ggplot(data=b.data, aes(x=1, y=Count, fill=School_District, label=School_District)) +
  geom_bar(stat="identity")+theme_void()+labs(y="Percent of Incoming Class")+geom_text(size = 3, position = position_stack(vjust = 0.5))+theme(legend.position="none")+ggtitle("Top 20 School Districts")
q
ggplotly(q)

