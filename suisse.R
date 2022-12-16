library(sf)
library(tidyverse)
library(santoku)

cantons <- read_sf("geodata/Cantons.shp")
lacs <- read_sf("geodata/Lacs.shp")

population <- read_csv("statdata/swiss_pop_2021.csv")
divorces <- read_csv("statdata/swiss_divorces_2021.csv")
naissances <- read_csv("statdata/swiss_nat_2021.csv")

cantons %>% 
  left_join(population, by = c("KTNR" = "ID")) %>% 
  left_join(divorces, by = c("KTNR" = "ID"))  %>% 
  left_join(naissances, by = c("KTNR" = "ID")) %>% 
  mutate(ratio_fg = Garçons / Filles * 100) -> donnees_carte

donnees_carte %>% 
  ggplot(aes(fill = chop(ratio_fg, c(95,97.5,100,102.5,105,107.5,110)))) + 
  geom_sf(size = .2) +
  geom_sf(size = .2, data = lacs, fill = "#adf9ff") +
  coord_sf(datum = NA) +
  scale_fill_manual(values = paletteer::paletteer_c("ggthemes::Red-Blue-White Diverging", 10)[3:10]) +
  guides(fill = guide_colorsteps()) +
  theme_minimal() +
  labs(
    title = "Ratio de genre à la naissance",
    subtitle = "nombre de naissances garçons pour 100 naissances filles",
    fill = "Ratio de genre"
  )
