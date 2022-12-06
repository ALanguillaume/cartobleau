test_that("read_test_data() works", {
  test_data_sf <- read_test_data()
  expect_equal(dim(test_data_sf), c(3, 5))
  expect_s3_class(test_data_sf, c("sf", "data.frame"))
  expect_equal(
    names(test_data_sf),
    c("title", "description", "raw_image_path", "id", "geometry")
  )
  expect_equal(
    sf::st_crs(test_data_sf)[["input"]],
    "EPSG:4326"
  )
})
