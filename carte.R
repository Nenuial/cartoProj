library(sf)
library(tidyverse)

cantons <- read_sf("geodata/Cantons.shp")
lacs <- read_sf("geodata/Lacs.shp")

cantons %>% 
  ggplot() +
  geom_sf() +
  geom_sf(data = lacs, fill = "blue")
