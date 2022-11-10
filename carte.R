library(sf)
library(tidyverse)

cantons <- read_sf("geodata/Cantons.shp")
lacs <- read_sf("geodata/Lacs.shp")

population <- read_csv("statdata/swiss_pop_2021.csv")

cantons %>% 
  left_join(population, by = c("KTNR" = "ID")) -> donnees_carte

donnees_carte %>% 
  ggplot(aes(fill = Population)) + 
  geom_sf() +
  geom_sf(data = lacs, fill = "#adf9ff") +
  coord_sf(datum = NA) +
  scale_fill_viridis_c(direction = -1) +
  theme_minimal() +
  labs(
    title = "Population de la Suisse",
    subtitle = "en 2021"
  )
