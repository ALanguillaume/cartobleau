#' Read test data from test database
#'
#' @description Read test data from test database and
#' transform it as a sf data.frame.
#'
#' @return A sf data.frame.
#'
#' @importFrom DBI dbConnect dbReadTable dbDisconnect
#' @importFrom sf st_as_sf
#'
#' @noRd
read_test_data <- function() {
  test_db <- dbConnect(
    drv = RSQLite::SQLite(),
    dbname = app_sys("test_db.sqlite")
  )
  on.exit(dbDisconnect(test_db))

  test_data <- dbReadTable(test_db, "data")
  test_data_sf <- test_data |> st_as_sf(
    coords = c("long", "lat"),
    crs = 4326
  )

  return(test_data_sf)
}
