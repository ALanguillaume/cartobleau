library(sf)
library(leaflet)
library(htmltools)

data_sf <- data.frame(
  lat = 48.3773651432161,
  long = 2.81810581684113,
  id = "pouet1212sdfh",
  title = "Coucou",
  description = "fluctuat nec mergitur.",
  img_path = "golem.png"
) |> st_as_sf(
  coords = c("long", "lat"),
  crs = 4326
)

build_html_label <- function(
  title,
  description,
  img_path
) {
  tags$div(
    tags$img(src = img_path, with = "100", height = "100"),
    tags$br(),
    tags$strong(title),
    tags$br(),
    tags$p(description)
  ) |>
    as.character() |>
    HTML()
}

with(
  data_sf,
  build_html_label(title, description, img_path)
) |>
  writeLines("./dev/leaflet-sandbox/test.html")


# https://stackoverflow.com/questions/36433899/image-in-r-leaflet-marker-popups
saveas <- function(map, file) {
  class(map) <- c("saveas", class(map))
  attr(map, "filesave") <- file
  map
}
print.saveas <- function(x, ...) {
  class(x) <- class(x)[class(x) != "saveas"]
  htmltools::save_html(x, file = attr(x, "filesave"))
}


m <- leaflet(
  data = data_sf
) |>
  addTiles() |>
  addMarkers(
    label = ~ build_html_label(title, description, img_path),
  )

path_index <- "./dev/leaflet-sandbox/index.html"
saveas(map = m, file = path_index)

browseURL(path_index)
