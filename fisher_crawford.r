setwd("~/workspace/fishercrawford")

library(ggplot2)
library(grid)
library(scales)

people <- read.csv("people.csv", stringsAsFactors=FALSE)
marriages <- read.csv("marriages.csv", stringsAsFactors=FALSE)
births <- read.csv("births.csv", stringsAsFactors=FALSE)
people$start = as.Date(people$start) 
people$end = as.Date(people$end) 
births$date = as.Date(births$date) 
marriages$start = as.Date(marriages$start) 
marriages$end = as.Date(marriages$end) 


cairo_pdf(height=8,width=10.5)
ggplot() +
  geom_rect(data=marriages, fill='lightgrey', aes(xmin=start, xmax=end, ymin=p1, ymax=p2)) +
  geom_segment(data=people, aes(x=start, xend=end, y=initials, yend=initials,
                                color=gender),
               size=2.5) +
  geom_vline(xintercept=seq(
    as.numeric(as.Date("1850-01-01")), as.numeric(as.Date("2020-01-01")), by=10*365),
             color='white', alpha=0.5) +
  geom_segment(data=births, color='grey', size=0.5,
               aes(x=date, xend=date, y=mother, yend=child), color='grey') +
  geom_text(data=people, hjust=-0.05, family="Helvetica Neue", size=2,
            aes(label=name, x=start, y=initials)) +
  scale_colour_manual(values = c("white","lightgreen", "lightblue")) +
  scale_y_discrete(breaks = NULL, name= "", limits = rev(people$initials)) + 
  scale_x_date(breaks = "10 year", minor_breaks=NULL, labels = date_format("%Y"),
               limits = c(as.Date("1849-01-01"), as.Date("2020-01-01")), name= "") + 
  theme(legend.position='none', panel.background=element_blank(),
        text=element_text(family="Georgia"), 
        axis.ticks.length= unit(0,units='cm'),
        plot.title = element_text(size=18, vjust=1)
        ) +
  labs(title=expression(atop(
    "Fisher-Crawford Descendants",
    atop(italic("compiled by Harold Kenneth Fisher, visualized by Nicolas Jérémie Kruchten"), ""))))
dev.off()
