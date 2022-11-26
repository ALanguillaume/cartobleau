#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom leaflet renderLeaflet leaflet addTiles setView
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  output$map <- renderLeaflet({
    leaflet() |>
      addTiles() |>
      setView(
        lng = 2.8186287540284862,
        lat = 48.37272732692216,
        zoom = 15
      )
  })
}
