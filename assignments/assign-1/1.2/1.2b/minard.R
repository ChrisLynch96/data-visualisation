rm(list = ls())
setwd("~/workspace/github.com/ChrisLynch96/data-visualisation/assignments/assign-1/1.2/1.2b")

# libraries
library(ggrepel)
library(readxl)
library(tidyverse)
library(ggplot2)
library(gridExtra)

data <- read_excel("minard-data.xlsx")

data.cities <- data[c("LONC", "LATC", "CITY")]
data.cities <- na.omit(data.cities)
data.troops <- data[c("LONP", "LATP", "SURV", "DIR", "DIV")]
data.troops <- na.omit(data.troops)
data.temps <- data[c("LONT", "TEMP", "DAYS", "MON", "DAY")]
data.temps <- na.omit(data.temps)

g.path <- ggplot() +
            geom_path(data = data.troops, aes(x = LONP, y = LATP, group = DIV, colour = SURV, size = SURV), lineend = "round") +
            scale_colour_gradientn(colours = c("red", "green")) +
            geom_point(data = data.cities, aes(x = LONC, y = LATC), color = "#1111FF", size = 5) +
            geom_label_repel(data = data.cities, aes(x = LONC, y = LATC, label = CITY), size = 5) +
            scale_size(range = c(0.5, 40)) +
            labs(x = "Longitude", y = "Latitude") +
            guides(color = FALSE, size = FALSE)

data.temps.nice <- data.temps %>% mutate(nice.label = paste0(TEMP, "°, ", MON, ". ", DAY))

g.temp <- ggplot(data = data.temps.nice, aes(x = LONT, y = TEMP)) +
            geom_line(colour = 'blue', size = 2.5) +
            geom_label(aes(label = nice.label), size = 2.5) +
            labs(x = NULL, y = "° Celcius") +
            coord_cartesian(ylim = c(-35, 5)) +
            theme(panel.grid.major.x = element_blank(),
                  panel.grid.minor.x = element_blank(),
                  panel.grid.minor.y = element_blank(),
                  axis.text.x = element_blank(), axis.ticks = element_blank(),
                  panel.border = element_blank())

png("~/Desktop/minard.png", width=1000, height=700)
grid.arrange(g.path, g.temp)
retval <- dev.off()

