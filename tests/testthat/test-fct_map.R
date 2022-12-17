data_sf <- read_test_data()

test_that("draw_interactive_map() works", {
  interactive_map <- draw_interactive_map(
    data_sf = data_sf
  )
  expect_s3_class(interactive_map, c("leaflet", "htmlwidget"))
})


test_that("build_html_labels() works", {
  data_sf_with_labels <- build_html_labels(data_sf = data_sf)
  expected_html_labels <- list(
    structure(
      sprintf(
        "<div>\n  <img src=\"%s\"/>\n  <br/>\n  <strong>Une péniche</strong>\n</div>",
        app_sys("miniatures/dummy.png")
      ),
      html = TRUE,
      class = c(
        "html",
        "character"
      )
    ),
    structure(
      sprintf(
        "<div>\n  <img src=\"%s\"/>\n  <br/>\n  <strong>Un camion de pompier</strong>\n</div>",
        app_sys("miniatures/dummy.png")
      ),
      html = TRUE,
      class = c(
        "html",
        "character"
      )
    ),
    structure(
      sprintf(
        "<div>\n  <img src=\"%s\"/>\n  <br/>\n  <strong>Une église</strong>\n</div>",
        app_sys("miniatures/dummy.png")
      ),
      html = TRUE,
      class = c(
        "html",
        "character"
      )
    )
  )

  expect_equal(
    data_sf_with_labels[["html_label"]],
    expected_html_labels
  )

  data_sf_with_labels[["html_label"]] <- NULL
  expect_equal(
    data_sf,
    data_sf_with_labels
  )
})
