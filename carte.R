library(sf)
library(tidyverse)

cantons <- read_sf("geodata/Cantons.shp")
lacs <- read_sf("geodata/Lacs.shp")

population <- read_csv("statdata/swiss_pop_2021.csv")
divorces <- read_csv("statdata/swiss_divorces_2021.csv")

cantons %>% 
  left_join(population, by = c("KTNR" = "ID")) %>% 
  left_join(divorces, by = c("KTNR" = "ID"))  %>% 
  mutate(tx_divorces = Divorces / Population * 1000) -> donnees_carte

donnees_carte %>% 
  ggplot(aes(fill = tx_divorces)) + 
  geom_sf(size = .2) +
  geom_sf(size = .2, data = lacs, fill = "#adf9ff") +
  coord_sf(datum = NA) +
  scale_fill_viridis_c(option = "B", direction = -1) +
  theme_minimal() +
  labs(
    title = "Divorces en Suisse",
    subtitle = "en 2021, pour 1000 habitants",
    fill = "Taux de divorce"
  )
