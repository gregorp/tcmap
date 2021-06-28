library(tidyverse)
library(osmdata) # package for working with streets
library(showtext) # for custom fonts
library(ggmap)
library(rvest)

## Following this: http://joshuamccrain.com/tutorials/maps/streets_tutorial.html

tc_bb = getbb("Traverse City Michigan")
big_streets =  tc_bb |> 
  opq() |>
  add_osm_feature(key = "highway", 
                  value = c("motorway", "primary", "motorway_link", "primary_link")) |>
  osmdata_sf() 

med_streets = tc_bb |>
  opq() |>
  add_osm_feature(key = "highway", 
                  value = c("secondary", "tertiary", "secondary_link", "tertiary_link")) |>
  osmdata_sf()

small_streets <- tc_bb |>
  opq() |>
  add_osm_feature(key = "highway", 
                  value = c("residential", "living_street",
                            "unclassified",
                            "service", "footway"
                  )) |>
  osmdata_sf()

water = tc_bb |>
  opq() |>
  add_osm_feature(key = "natural", value = c("water", "bay", "coastline")) |>
  osmdata_sf()

ggplot() +
    geom_sf(data = water$osm_polygons, fill = "dodgerblue4") + 
    geom_sf(data = med_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = 0.3, alpha = 0.5) +
      geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = 0.2, alpha = 0.3) +
  geom_sf(data = big_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = 0.5, alpha = 0.6)  +

  theme_void()


