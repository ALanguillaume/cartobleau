#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  global <- reactiveValues(
    card_bank = data.frame()
  )

  output$map <- renderLeaflet({
    draw_interactive_map(
      data_sf = read_test_data()
    )
  })

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
