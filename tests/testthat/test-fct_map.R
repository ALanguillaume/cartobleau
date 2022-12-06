test_that("draw_interactive_map() works", {
  interactive_map <- draw_interactive_map(
    data_sf = read_test_data()
  )
  expect_s3_class(interactive_map, c("leaflet", "htmlwidget"))
})
