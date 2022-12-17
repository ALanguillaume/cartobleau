library(sf)
library(leaflet)
library(htmltools)
library(dplyr)

data_sf <- list(
  data.frame(
    lat = 48.3773651432161,
    long = 2.81810581684113,
    id = "card1",
    title = "Coucou",
    img_path = "golem.png"
  ),
  data.frame(
    lat = 48.3739942801645,
    long = 2.81742453575134,
    id = "card2",
    title = "Hello",
    img_path = "golem.png"
  )
) |>
  Reduce(rbind, x = _) |>
  st_as_sf(
    coords = c("long", "lat"),
    crs = 4326
  )

template_html_label <- tags$div(
  tags$img(src = "{img_path}", with = "100", height = "100"),
  tags$br(),
  tags$strong("{title}")
) |>
  as.character()


#' Build html labels for leaflet
#'
#' @param title A character string. Title of the card.
#' @param description A character string. Description of the card.
#' @param temtemplate_html_label_ A character string. HTML template to be
#' filled using `glue::glue()`.
#'
#' @return An object of class html to be fed to leaflet::addMarkers() as label.
#'
#' @noRd
build_html_label <- function(
  title,
  img_path,
  template_html_label_ = template_html_label
) {
  HTML(
    glue::glue(template_html_label_)
  )
}

build_html_label(
  title = "Coucou",
  img_path = "img.png"
)

data_sf <- data_sf |>
  mutate(
    html_label = purrr::map2(
      title,
      img_path,
      build_html_label
    )
  )

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
    label = ~html_label,
  )

m

path_index <- "./dev/leaflet-sandbox/index.html"
saveas(map = m, file = path_index)

browseURL(path_index)
