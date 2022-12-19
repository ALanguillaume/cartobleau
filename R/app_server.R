#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  global <- reactiveValues(
    data_sf = read_test_data()
  )

  output$map <- renderLeaflet({
    draw_interactive_map(
      data_sf = global$data_sf
    )
  })

  observeEvent(
    input$map_marker_click,
    {
      #' @importFrom dplyr filter
      to_display_df <- global$data_sf |>
        filter(
          id == input$map_marker_click$id
        )
      # browser()
      showModal(
        modalDialog(
          easyClose = TRUE,
          size = "l",
          footer = modalButton("Fermer"),
          h3(to_display_df$title),
          p(to_display_df$description),
          tags$img(
            src = file.path(
              "www/images",
              sprintf("%s.jpg", input$map_marker_click$id)
              ),
            width = "800"
          )
        )
      )
    }
  )

  observeEvent(
    input$map_click,
    {
      showModal(
        modalDialog(
          easyClose = TRUE,
          size = "l",
          footer = tagList(
            modalButton("Annuler"),
            actionButton(
              inputId = "add_card",
              label = "Ajouter"
            )
          ),
          h2("Ajouter une nouvelle carte"),
          fileInput(
            inputId = "card_image",
            label = "T\u00e9l\u00e9charger la carte"
          ),
          textInput(
            inputId = "card_name",
            label = "Nom de la carte"
          ),
          textAreaInput(
            inputId = "card_description",
            label = "Description de la carte"
          ),
          tags$ul(
            tags$li(
              sprintf("Latitude : %s", input$map_click$lat)
            ),
            tags$li(
              sprintf("Longitude : %s", input$map_click$lng)
            )
          )
        )
      )
    }
  )

  observeEvent(
    input$add_card,
    {
      showNotification(
        ui = "Carte ajout\u00e9e",
        type = "message"
      )
      removeModal()
    }
  )
}
