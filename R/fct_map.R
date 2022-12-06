#' Draw the interactive
#'
#' Each marker corresponds to a card.
#'
#' @param data_sf A sf data,frame.
#' @return A leaflet object.
#'
#' @importFrom leaflet renderLeaflet leaflet addTiles setView addMarkers
#'
#' @examples
#' draw_interactive_map(data_sf = read_test_data())
#'
#' @noRd
draw_interactive_map <- function(data_sf) {
  leaflet(
    data = data_sf
  ) |>
    addTiles() |>
    addMarkers() |>
    setView(
      lng = 2.8186287540284862,
      lat = 48.37272732692216,
      zoom = 15
    )
}
