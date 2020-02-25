rm(list = ls())
setwd("~/workspace/github.com/ChrisLynch96/data-visualisation/assignments/assign-1/1.2/1.2b")

# libraries
library(tidyverse)
library(lubridate)
library(ggmap)
library(ggrepel)
library(gridExtra)
library(pander)
library(readxl)

data <- read_excel("minard-data.xlsx")

data.cities <- data[c("LONC", "LATC", "CITY")]
data.cities <- na.omit(data.cities)
data.troops <- data[c("LONP", "LATP", "SURV", "DIR", "DIV")]
data.troops <- na.omit(data.troops)
data.temps <- data[c("LONT", "TEMP", "DAYS", "MON", "DAY")]
data.temps <- na.omit(data.temps)

g.path <- ggplot() +
            geom_path(data = data.troops, aes(x = LONP, y = LATP, group = DIV, color = DIR, size = SURV), lineend = "round") +
            geom_point(data = data.cities, aes(x = LONC, y = LATC), color = "#DC5B44") +
            geom_text_repel(data = data.cities, aes(x = LONC, y = LATC, label = CITY), color = "#DC5B44") +
            scale_size(range = c(0.5, 20)) +
            scale_colour_manual(values = c("#DFC17E", "#252523")) +
            labs(x = "Longitude", y = "Latitude") +
            guides(color = FALSE, size = FALSE)

data.temps.nice <- data.temps %>% mutate(nice.label = paste0(TEMP, "°, ", MON, ". ", DAY))

g.temp <- ggplot(data = data.temps.nice, aes(x = LONT, y = TEMP)) +
            geom_line() +
            geom_label(aes(label = nice.label), size = 2.5) +
            labs(x = "Longitude", y = "° Celcius") +
            coord_cartesian(ylim = c(-35, 5)) +
            theme(panel.grid.major.x = element_blank(),
                  panel.grid.minor.x = element_blank(),
                  panel.grid.minor.y = element_blank(),
                  axis.text.x = element_blank(), axis.ticks = element_blank(),
                  panel.border = element_blank())



png("minard.png", width=1920, height=1080)
grid.arrange(g.path, g.temp)
retval <- dev.off()

