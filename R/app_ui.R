#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom leaflet leafletOutput
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    navbarPage(
      title = "Cartobleau",
      id = "nav",
      tabPanel(
        title = "Carte interactive",
        div(
          class = "outer",
          # If not using custom CSS, set height of leafletOutput to a number
          # instead of percent
          leafletOutput(
            outputId = "map",
            width = "100%",
            height = "100%"
          ),
        )
      ),
      tabPanel(
        title = "\u00c0 propos"
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "cartobleau"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
