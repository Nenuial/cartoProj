library(tidyverse)
library(sf)
library(rnaturalearth)
library(wbstats)

donnees_carte <- wb_data("SH.IMM.MEAS", start_date = 2018)

ne_countries(returnclass = "sf") %>% 
  left_join(donnees_carte, by = c("adm0_a3" = "iso3c")) %>% 
  ggplot(aes(fill = `SH.IMM.MEAS`)) +
  geom_sf() +
  coord_sf(crs = "+proj=eqearth", datum = NA) +
  scale_fill_viridis_b(direction = -1) +
  theme_minimal() +
  labs(fill = "Taux de vaccination")
