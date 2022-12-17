#' Draw the interactive
#'
#' Each marker corresponds to a card.
#'
#' @param data_sf A sf data.frame.
#'
#' @return A leaflet object.
#'
#' @importFrom leaflet renderLeaflet leaflet addTiles setView addMarkers
#'
#' @examples
#' draw_interactive_map(data_sf = read_test_data())
#'
#' @noRd
draw_interactive_map <- function(data_sf) {
  data_sf |>
    build_html_labels() |>
    leaflet(
      data = data_sf
    ) |>
    addTiles() |>
    addMarkers(
      label = ~title
    ) |>
    setView(
      lng = 2.8186287540284862,
      lat = 48.37272732692216,
      zoom = 15
    )
}


#' Build html labels for leaflet
#'
#' @param title A character string. Title of the card.
#' @param miniature_path A character string. Path to card miniature.
#'
#' @return An object of class html to be fed to leaflet::addMarkers()
#' as label.
#'
#' @importFrom glue glue
#'
#' @noRd
.build_html_label <- function(
  title,
  miniature_path = app_sys("miniatures/dummy.png")
) {
  tags$div(
    tags$img(src = "{miniature_path}"),
    tags$br(),
    tags$strong("{title}")
  ) |>
    as.character() |>
    glue() |>
    HTML()
}

#' Modify spatial data to incorporate html labels
#'
#' Build html labels for leaflet.
#'
#' @inheritParams draw_interactive_map
#'
#' @return A sf object with an added `html_label` column.
#'
#' @importFrom dplyr mutate
#' @importFrom purrr map
#'
#' @noRd
build_html_labels <- function(data_sf) {
  data_sf |>
    mutate(
      html_label = map(
        title,
        .build_html_label
      )
    )
}
